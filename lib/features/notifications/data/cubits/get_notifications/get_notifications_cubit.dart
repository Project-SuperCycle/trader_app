import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/features/notifications/data/cubits/get_notifications/get_notifications_state.dart';
import 'package:trader_app/features/notifications/data/repos/notifications_repo_imp.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  final NotificationsRepoImp repo;

  GetNotificationsCubit({required this.repo})
    : super(GetNotificationsInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    final result = await repo.fetchNotifications();
    result.fold(
      (f) => emit(GetNotificationsFailure(errorMessage: f.errMessage)),
      (list) => emit(GetNotificationsSuccess(notifications: list)),
    );
  }

  void markAsRead(String id) {
    if (state is! GetNotificationsSuccess) return;

    final current = (state as GetNotificationsSuccess).notifications;

    emit(
      GetNotificationsSuccess(
        notifications: current
            .map((n) => n.id == id ? n.copyWith(seen: true) : n)
            .toList(),
      ),
    );
  }

  void removeNotification(String id) {
    if (state is! GetNotificationsSuccess) return;

    final current = (state as GetNotificationsSuccess).notifications;

    emit(
      GetNotificationsSuccess(
        notifications: current.where((n) => n.id != id).toList(),
      ),
    );
  }
}
