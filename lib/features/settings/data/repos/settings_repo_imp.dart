import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/services/user_profile_services.dart';
import 'package:trader_app/features/settings/data/models/request_email_change_model.dart';
import 'package:trader_app/features/settings/data/models/update_notifications_model.dart';
import 'package:trader_app/features/settings/data/models/update_password_model.dart';
import 'package:trader_app/features/settings/data/models/update_profile_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo.dart';
import 'package:trader_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

class SettingsRepoImp implements SettingsRepo {
  final ApiServices apiServices;

  SettingsRepoImp({required this.apiServices});

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
    required FinancesMethodsModel methods,
  }) {
    // TODO: implement updateFinancesMethods
    return ErrorHandler.handleApiCall<String>(
      apiCall: () async {
        final response = await apiServices.patch(
          endPoint: ApiEndpoints.updateFinanceMethods,
          data: {"receivingMethods": methods.toJson()},
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
          endPoint: ApiEndpoints.updateLogo,
          data: buildLogoFormData(logo: logo),
        );
        String? logoUrl = response['data']['logoUrl'];

        if (logoUrl == null) {
          throw ServerFailure('Invalid response: Missing Logo', 422);
        }

        LoginUserModel? userModel = await StorageServices.getUserData();
        LoginUserModel newUserModel = userModel!.copyWith(logoUrl: logoUrl);
        await StorageServices.storeData('user', newUserModel.toJson());

        await UserProfileService.fetchAndStoreUserProfile();
        return logoUrl;
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

        LoginUserModel? userModel = await StorageServices.getUserData();
        NotificationPreferencesModel newPermissions =
            NotificationPreferencesModel(
              shipments: permissions.shipments,
              finance: permissions.finance,
              system: permissions.system,
            );
        LoginUserModel newUserModel = userModel!.copyWith(
          notificationPreferences: newPermissions,
        );
        await StorageServices.storeData('user', newUserModel.toJson());

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

        LoginUserModel? userModel = await StorageServices.getUserData();
        LoginUserModel newUserModel = userModel!.copyWith(
          bussinessName: (profile.businessName.isEmpty)
              ? userModel.bussinessName
              : profile.businessName,
          bussinessAdress: (profile.businessAddress.isEmpty)
              ? userModel.bussinessAdress
              : profile.businessAddress,
          doshMangerName: (profile.doshManagerName.isEmpty)
              ? userModel.doshMangerName
              : profile.doshManagerName,
          doshMangerPhone: (profile.doshManagerPhone.isEmpty)
              ? userModel.doshMangerPhone
              : profile.doshManagerPhone,
          rawBusinessType: (profile.rawBusinessType.isEmpty)
              ? userModel.rawBusinessType
              : profile.rawBusinessType,
        );
        await StorageServices.storeData('user', newUserModel.toJson());
        await UserProfileService.fetchAndStoreUserProfile();
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
