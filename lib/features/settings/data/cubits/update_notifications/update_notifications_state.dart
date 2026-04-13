part of 'update_notifications_cubit.dart';

@immutable
sealed class UpdateNotificationsState {}

final class UpdateNotificationsInitial extends UpdateNotificationsState {}

final class UpdateNotificationsLoading extends UpdateNotificationsState {}

final class UpdateNotificationsSuccess extends UpdateNotificationsState {
  final String message;

  UpdateNotificationsSuccess({required this.message});
}

final class UpdateNotificationsFailure extends UpdateNotificationsState {
  final String errMessage;

  UpdateNotificationsFailure({required this.errMessage});
}
