import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/features/notifications/data/repos/notifications_repo_imp.dart';

part 'delete_notification_state.dart';

class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  final NotificationsRepoImp notificationsRepoImp;

  DeleteNotificationCubit({required this.notificationsRepoImp})
    : super(DeleteNotificationInitial());

  Future<void> deleteNotification({required String id}) async {
    emit(DeleteNotificationLoading());
    try {
      var result = await notificationsRepoImp.deleteNotification(
        notificationId: id,
      );
      result.fold(
        (failure) {
          emit(DeleteNotificationFailure(errorMessage: failure.errMessage));
        },
        (_) {
          emit(DeleteNotificationSuccess(message: "تم حذف الإشعار"));
          // Store user globally
        },
      );
    } catch (error) {
      emit(DeleteNotificationFailure(errorMessage: error.toString()));
    }
  }
}
