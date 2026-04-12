part of 'request_email_change_cubit.dart';

@immutable
sealed class RequestEmailChangeState {}

final class RequestEmailChangeInitial extends RequestEmailChangeState {}

final class RequestEmailChangeLoading extends RequestEmailChangeState {}

final class RequestEmailChangeSuccess extends RequestEmailChangeState {
  final String message;

  RequestEmailChangeSuccess({required this.message});
}

final class RequestEmailChangeFailure extends RequestEmailChangeState {
  final String errMessage;

  RequestEmailChangeFailure({required this.errMessage});
}
