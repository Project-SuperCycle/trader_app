part of 'update_password_cubit.dart';

@immutable
sealed class UpdatePasswordState {}

final class UpdatePasswordInitial extends UpdatePasswordState {}

final class UpdatePasswordLoading extends UpdatePasswordState {}

final class UpdatePasswordSuccess extends UpdatePasswordState {
  final String message;

  UpdatePasswordSuccess({required this.message});
}

final class UpdatePasswordFailure extends UpdatePasswordState {
  final String errMessage;

  UpdatePasswordFailure({required this.errMessage});
}
