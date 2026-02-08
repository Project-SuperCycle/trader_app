part of 'get_notifications_cubit.dart';

sealed class GetNotificationsState extends Equatable {
  const GetNotificationsState();
}

final class GetNotificationsInitial extends GetNotificationsState {
  @override
  List<Object> get props => [];
}

// GET ALL SHIPMENTS
final class GetNotificationsLoading extends GetNotificationsState {
  @override
  List<Object> get props => [];
}

final class GetNotificationsSuccess extends GetNotificationsState {
  final List<NotificationModel> notifications;

  const GetNotificationsSuccess({required this.notifications});

  @override
  List<Object> get props => [];
}

final class GetNotificationsFailure extends GetNotificationsState {
  final String errorMessage;

  const GetNotificationsFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
