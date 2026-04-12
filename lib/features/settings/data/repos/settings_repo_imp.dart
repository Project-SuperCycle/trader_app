import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/features/settings/data/models/request_email_change_model.dart';
import 'package:trader_app/features/settings/data/models/update_finance_methods_model.dart';
import 'package:trader_app/features/settings/data/models/update_notifications_model.dart';
import 'package:trader_app/features/settings/data/models/update_password_model.dart';
import 'package:trader_app/features/settings/data/models/update_profile_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo.dart';

class SettingsRepoImp implements SettingsRepo {
  final ApiServices apiServices;

  SettingsRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> createTraderEcoRequest({
    required int quantity,
  }) {
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.post(
          endPoint: ApiEndpoints.createTraderEcoRequest,
          data: {
            "rewardItemId": "68f39e4ab208ebb112d58b89",
            "quantity": quantity,
          },
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'create trader eco request',
    );
  }

  @override
  Future<Either<Failure, String>> confirmEmailChange({required String otp}) {
    // TODO: implement confirmEmailChange
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.post(
          endPoint: ApiEndpoints.confirmEmailChange,
          data: {"otp": otp},
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'confirm email change',
    );
  }

  @override
  Future<Either<Failure, String>> requestEmailChange({
    required RequestEmailChangeModel email,
  }) {
    // TODO: implement requestEmailChange
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.post(
          endPoint: ApiEndpoints.requestEmailChange,
          data: email.toJson(),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'request email change',
    );
  }

  @override
  Future<Either<Failure, String>> updateFinancesMethods({
    required UpdateFinanceMethodsModel methods,
  }) {
    // TODO: implement updateFinancesMethods
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patch(
          endPoint: ApiEndpoints.updateFinanceMethods,
          data: methods.toJson(),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'update finances methods',
    );
  }

  @override
  Future<Either<Failure, String>> updateLogo({required File logo}) {
    // TODO: implement updateLogo
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patchFormData(
          endPoint: ApiEndpoints.updateFinanceMethods,
          data: buildLogoFormData(logo: logo),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'update profile logo',
    );
  }

  @override
  Future<Either<Failure, String>> updateNotificationsPermissions({
    required UpdateNotificationsModel permissions,
  }) {
    // TODO: implement updateNotificationsPermissions
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patch(
          endPoint: ApiEndpoints.updateNotificationsPermissions,
          data: permissions.toJson(),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'update notifications permissions',
    );
  }

  @override
  Future<Either<Failure, String>> updatePassword({
    required UpdatePasswordModel password,
  }) {
    // TODO: implement updatePassword
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patch(
          endPoint: ApiEndpoints.updatePassword,
          data: password.toJson(),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'update account password',
    );
  }

  @override
  Future<Either<Failure, String>> updateProfile({
    required UpdateProfileModel profile,
  }) {
    // TODO: implement updateProfile
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patch(
          endPoint: ApiEndpoints.updateProfile,
          data: profile.toJson(),
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        return response['message'];
      },
      errorContext: 'update profile data',
    );
  }

  FormData buildLogoFormData({required File logo}) {
    return FormData.fromMap({
      'logo': MultipartFile.fromFileSync(
        logo.path,
        filename: logo.path.split('/').last,
      ),
    });
  }
}
