import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/data/models/otp_verification_model.dart';
import 'package:trader_app/features/sign_up/data/models/signup_credentials_model.dart';
import 'package:trader_app/features/sign_up/data/repos/signup_repo.dart';

class SignUpRepoImp implements SignUpRepo {
  final ApiServices apiServices;

  SignUpRepoImp({required this.apiServices});

  /// بدء عملية التسجيل
  @override
  Future<Either<Failure, String>> initiateSignup({
    required SignupCredentialsModel credentials,
  }) async {
    return await ErrorHandler.simpleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.post(
          endPoint: ApiEndpoints.signup,
          data: credentials.toJson(),
        );
        return response['message'] as String;
      },
      errorContext: 'initiating signup',
      errorMessage: 'Failed to initiate signup. Please try again.',
      specificErrorMessages: {
        'email already exists': 'This email is already registered',
        'invalid email': 'Please enter a valid email address',
        'weak password': 'Password is too weak',
      },
    );
  }

  /// التحقق من رمز OTP
  @override
  Future<Either<Failure, String>> verifyOtp({
    required OtpVerificationModel credentials,
  }) async {
    return await ErrorHandler.handleApiResponse<String>(
      apiCall: () => apiServices.post(
        endPoint: ApiEndpoints.verifyOtp,
        data: credentials.toJson(),
      ),
      errorContext: 'verifying OTP',
      responseParser: (response) => response['message'] as String,
      customErrorChecks: (response) {
        // التحقق من وجود token
        if (response['token'] == null) {
          return ServerFailure('Invalid response: Missing token', 422);
        }
        return null;
      },
      onSuccess: (message, response) async {
        await StorageServices.storeData('token', response['token']);
      },
    );
  }

  /// إكمال عملية التسجيل
  @override
  Future<Either<Failure, String>> completeSignup({
    required BusinessInformationModel businessInfo,
    required FinancesMethodsModel methods,
  }) async {
    return await ErrorHandler.handleApiResponse<String>(
      apiCall: () => apiServices.post(
        endPoint: ApiEndpoints.completeSignup,
        data: {
          ...businessInfo.toJson(),
          'receivingMethods': _handleReceivingMethods(methods),
        },
      ),
      errorContext: 'completing signup',
      responseParser: (response) => response['message'] as String,
    );
  }
}

Map<String, dynamic> _handleReceivingMethods(FinancesMethodsModel methods) {
  final Map<String, dynamic> json = {'cash': methods.cash};

  if (methods.bankTransfer.enabled) {
    json['bankTransfer'] = methods.bankTransfer.toJson();
  }

  if (methods.wallet.enabled) {
    json['wallet'] = methods.wallet.toJson();
  }

  return json;
}
