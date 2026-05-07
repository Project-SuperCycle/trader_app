import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/features/settings/data/models/request_email_change_model.dart';
import 'package:trader_app/features/settings/data/models/update_notifications_model.dart';
import 'package:trader_app/features/settings/data/models/update_password_model.dart';
import 'package:trader_app/features/settings/data/models/update_profile_model.dart';

abstract class SettingsRepo {
  Future<Either<Failure, String>> updateProfile({
    required UpdateProfileModel profile,
  });

  Future<Either<Failure, String>> updateFinancesMethods({
    required FinancesMethodsModel methods,
  });

  Future<Either<Failure, String>> updateNotificationsPermissions({
    required UpdateNotificationsModel permissions,
  });

  Future<Either<Failure, String>> updatePassword({
    required UpdatePasswordModel password,
  });

  Future<Either<Failure, String>> requestEmailChange({
    required RequestEmailChangeModel email,
  });

  Future<Either<Failure, String>> confirmEmailChange({required String otp});

  Future<Either<Failure, String>> updateLogo({required File logo});
}
