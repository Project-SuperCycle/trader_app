import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:trader_app/core/errors/failures.dart';

/// Helper class لمعالجة الأخطاء بشكل مركزي
class ErrorHandler {
  static final Logger _logger = Logger();
  static final Connectivity _connectivity = Connectivity();

  /// التحقق من وجود اتصال بالإنترنت
  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();

      // التحقق من جميع أنواع الاتصالات
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet)) {
        return true;
      }

      return false;
    } catch (e) {
      _logger.e('❌ Error checking internet connection: $e');
      // في حالة فشل الفحص، نفترض وجود اتصال ونترك الـ API يحدد
      return true;
    }
  }

  /// التحقق من الاتصال وإرجاع Failure في حالة عدم وجود إنترنت
  static Future<Either<Failure, bool>> checkConnectivity() async {
    final isConnected = await hasInternetConnection();

    if (!isConnected) {
      _logger.w('⚠️ No internet connection');
      return left(
        ServerFailure('No internet connection. Please check your network.', 0),
      );
    }

    return right(true);
  }

  static Future<Either<Failure, T>> handleApiCall<T>({
    required Future<T> Function() apiCall,
    required String errorContext,
    Map<String, dynamic>? additionalErrorHandling,
    bool checkInternet = true, // خيار للتحكم في فحص الإنترنت
  }) async {
    // التحقق من الإنترنت أولاً
    if (checkInternet) {
      final connectivityCheck = await checkConnectivity();
      if (connectivityCheck.isLeft()) {
        return connectivityCheck.fold(
          (failure) => left(failure),
          (_) => left(ServerFailure('Unknown connectivity error', 0)),
        );
      }
    }

    try {
      final result = await apiCall();
      return right(result);
    } on DioException catch (dioError) {
      _logger.e(
        '❌ DioException during $errorContext: ${dioError.message}',
        error: dioError,
      );

      // استخدام ServerFailure.fromDioError الموجود في الـ Failure class
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      _logger.e('❌ FormatException during $errorContext: $formatError');
      return left(
        ServerFailure('Invalid data format: ${formatError.message}', 422),
      );
    } on TypeError catch (typeError) {
      _logger.e('❌ TypeError during $errorContext: $typeError');
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Unexpected error during $errorContext: ${e.toString()}');
      _logger.w('Stack trace: ${stackTrace.toString()}');

      // معالجة أخطاء مخصصة إضافية
      if (additionalErrorHandling != null) {
        for (var entry in additionalErrorHandling.entries) {
          if (e.toString().contains(entry.key)) {
            return left(ServerFailure(entry.value as String, 400));
          }
        }
      }

      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }

  static Future<Either<Failure, T>> handleApiResponse<T>({
    required Future<Map<String, dynamic>> Function() apiCall,
    required String errorContext,
    required T Function(Map<String, dynamic> response) responseParser,
    Future<void> Function(T model, Map<String, dynamic> response)? onSuccess,
    Failure? Function(Map<String, dynamic> response)? customErrorChecks,
    Map<String, dynamic>? additionalErrorHandling,
    bool checkInternet = true,
  }) async {
    return await handleApiCall<T>(
      apiCall: () async {
        final response = await apiCall();

        // التحقق من الأخطاء المخصصة أولاً
        if (customErrorChecks != null) {
          final customError = customErrorChecks(response);
          if (customError != null) {
            throw customError;
          }
        }

        // التحقق من وجود البيانات
        if (response['data'] == null) {
          throw ServerFailure('Invalid response: Missing data', 422);
        }

        // تحليل الاستجابة
        final model = responseParser(response);

        // تنفيذ عمليات إضافية عند النجاح
        if (onSuccess != null) {
          await onSuccess(model, response);
        }

        return model;
      },
      errorContext: errorContext,
      additionalErrorHandling: additionalErrorHandling,
      checkInternet: checkInternet,
    );
  }

  static Future<Either<Failure, T>> simpleApiCall<T>({
    required Future<T> Function() apiCall,
    required String errorContext,
    String? errorMessage,
    Map<String, String>? specificErrorMessages,
    bool checkInternet = true,
  }) async {
    // التحقق من الإنترنت أولاً
    if (checkInternet) {
      final connectivityCheck = await checkConnectivity();
      if (connectivityCheck.isLeft()) {
        return connectivityCheck.fold(
          (failure) => left(failure),
          (_) => left(ServerFailure('Unknown connectivity error', 0)),
        );
      }
    }

    try {
      final result = await apiCall();
      return right(result);
    } on DioException catch (dioError) {
      _logger.e('❌ DioException during $errorContext: $dioError');
      return left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      _logger.e('❌ Error during $errorContext: $e');

      // التحقق من رسائل أخطاء محددة
      if (specificErrorMessages != null) {
        for (var entry in specificErrorMessages.entries) {
          if (e.toString().contains(entry.key)) {
            return left(ServerFailure(entry.value, 400));
          }
        }
      }

      // رسالة خطأ افتراضية
      final message = errorMessage ?? 'An error occurred during $errorContext';
      return left(ServerFailure(message, 520));
    }
  }

  /// تسجيل الأخطاء فقط دون إرجاع Either
  static void logError(
    String context,
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    _logger.e(
      '❌ Error in $context: $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// التحقق من وجود البيانات المطلوبة في الاستجابة
  static Failure? validateResponseData(
    Map<String, dynamic> response,
    List<String> requiredFields,
  ) {
    for (var field in requiredFields) {
      if (response[field] == null) {
        return ServerFailure('Invalid response: Missing $field', 422);
      }
    }
    return null;
  }

  /// الاستماع لتغييرات حالة الاتصال (Stream)
  static Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) {
      // إرجاع أول نتيجة فعالة
      if (results.contains(ConnectivityResult.mobile)) {
        return ConnectivityResult.mobile;
      } else if (results.contains(ConnectivityResult.wifi)) {
        return ConnectivityResult.wifi;
      } else if (results.contains(ConnectivityResult.ethernet)) {
        return ConnectivityResult.ethernet;
      } else {
        return ConnectivityResult.none;
      }
    });
  }

  /// معالجة الأخطاء في الـ UI بشكل موحد
  static String getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      // أخطاء الشبكة (statusCode = 0)
      if (failure.statusCode == 0) {
        return failure.errMessage;
      }

      // أخطاء الـ Authentication
      if (failure.statusCode == 401 || failure.statusCode == 403) {
        return 'يرجى تسجيل الدخول مرة أخرى';
      }

      // أخطاء الـ Validation
      if (failure.statusCode == 422) {
        return failure.errMessage;
      }

      // باقي الأخطاء
      return failure.errMessage;
    }

    return 'حدث خطأ غير متوقع';
  }

  /// التحقق من نوع الخطأ
  static bool isNetworkError(Failure failure) {
    return failure is ServerFailure && failure.statusCode == 0;
  }

  static bool isAuthError(Failure failure) {
    return failure is ServerFailure &&
        (failure.statusCode == 401 || failure.statusCode == 403);
  }

  static bool isValidationError(Failure failure) {
    return failure is ServerFailure && failure.statusCode == 422;
  }

  static bool isServerError(Failure failure) {
    return failure is ServerFailure &&
        failure.statusCode >= 500 &&
        failure.statusCode < 600;
  }
}
