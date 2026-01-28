import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/features/forget_password/data/model/reset_password_model.dart';
import 'package:trader_app/features/forget_password/data/model/verify_reset_otp_model.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failure, String>> forgetPassword(String email);

  Future<Either<Failure, String>> verifyResetOtp(
    VerifyResetOtpModel verifyModel,
  );

  Future<Either<Failure, String>> resetPassword(ResetPasswordModel resetModel);
}
