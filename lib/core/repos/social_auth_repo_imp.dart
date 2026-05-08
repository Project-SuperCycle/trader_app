import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:trader_app/core/constants/storage_constants.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/models/social_auth_request_model.dart'
    show SocialAuthRequestModel;
import 'package:trader_app/core/models/social_auth_response_model.dart'
    show SocialAuthResponseModel;
import 'package:trader_app/core/repos/social_auth_repo.dart';
import 'package:trader_app/core/services/api_endpoints.dart' show ApiEndpoints;
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/auth_manager_services.dart';
import 'package:trader_app/core/services/notifications/push_notifications_service.dart';
import 'package:trader_app/core/services/services_locator.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/services/user_profile_services.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';
import 'package:trader_app/features/sign_in/data/models/logined_user_model.dart';

class SocialAuthRepoImp implements SocialAuthRepo {
  final ApiServices apiServices;

  final AuthManager _authManager = AuthManager();

  SocialAuthRepoImp({required this.apiServices});

  @override
  @override
  Future<Either<Failure, SocialAuthResponseModel>> socialSignup({
    required SocialAuthRequestModel credentials,
  }) async {
    return ErrorHandler.handleApiResponse<SocialAuthResponseModel>(
      apiCall: () => apiServices.post(
        endPoint: ApiEndpoints.socialLogin,
        data: credentials.toJson(),
      ),
      errorContext: 'social signup',
      responseParser: (response) {
        return SocialAuthResponseModel.fromJson({
          "status": response['status'],
          "message": response['message'],
          "token": response['token'],
          "user": response['data'],
        });
      },
      customErrorChecks: (response) {
        return ErrorHandler.validateResponseData(response, ['token']);
      },
      onSuccess: (socialAuth, response) async {
        final token = socialAuth.token;
        if (token == null) return;

        final user = socialAuth.user;
        await _saveUserData(user!, token);
        unawaited(_registerDeviceToServer());
      },
    );
  }

  /// حفظ بيانات المستخدم
  Future<void> _saveUserData(LoginUserModel user, String token) async {
    // ✅ Fix #2: always save token regardless of role
    await StorageServices.storeData('token', token);

    if (user.role == "representative") return;

    await Future.wait([StorageServices.storeData('user', user.toJson())]);

    await UserProfileService.fetchAndStoreUserProfile();
    await _authManager.onLoginSuccess();

    // GET FINANCE METHODS
    var repo = getIt.get<FinancesRepoImp>();
    var result = await repo.getFinanceMethods();
    result.fold(
      (failure) {
        Logger().e(failure.errMessage);
      },
      (data) async {
        await StorageServices.storeData(
          StorageConstants.FINANCES_METHODS,
          data.toJson(),
        );
      },
    );
  }

  /// تسجيل الجهاز (آمن 100%)
  Future<void> _registerDeviceToServer() async {
    try {
      final canRegister = await PushNotificationsService.canRegisterDevice();
      if (!canRegister) {
        // ✅ Fix #3: log the reason instead of silently returning
        Logger().w(
          '⚠️ Device registration skipped: canRegisterDevice() = false',
        );
        return;
      }

      final fcmData = await PushNotificationsService.getStoredFCMData();
      if (fcmData == null) {
        Logger().w('⚠️ Device registration skipped: FCM data is null');
        return;
      }

      final token = fcmData['token'];
      final platform = fcmData['platform'];

      if (token == null || token.isEmpty || platform == null) {
        Logger().w(
          '⚠️ Device registration skipped: token or platform is missing',
        );
        return;
      }

      Logger().d('''
╔════════════════════════════════════════
║ Registering Device REPO
╠════════════════════════════════════════
║ Token: ${token.substring(0, token.length.clamp(0, 20))}...
║ Platform: $platform
║ App: trader
╚════════════════════════════════════════
''');

      await apiServices.post(
        endPoint: ApiEndpoints.registerDevice,
        data: {"token": token, "platform": platform, "app": "trader"},
      );
    } catch (e, stackTrace) {
      Logger().e(
        '⚠️ Device registration failed (non-critical)',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
