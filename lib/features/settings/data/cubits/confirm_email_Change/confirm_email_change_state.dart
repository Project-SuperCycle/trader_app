part of 'confirm_email_change_cubit.dart';

@immutable
sealed class ConfirmEmailChangeState {}

final class ConfirmEmailChangeInitial extends ConfirmEmailChangeState {}

final class ConfirmEmailChangeLoading extends ConfirmEmailChangeState {}

final class ConfirmEmailChangeSuccess extends ConfirmEmailChangeState {
  final String message;

  ConfirmEmailChangeSuccess({required this.message});
}

final class ConfirmEmailChangeFailure extends ConfirmEmailChangeState {
  final String errMessage;

  ConfirmEmailChangeFailure({required this.errMessage});
}
