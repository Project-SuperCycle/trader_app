import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/features/notifications/data/repos/notifications_repo_imp.dart';

part 'read_notification_state.dart';

class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  final NotificationsRepoImp notificationsRepoImp;

  ReadNotificationCubit({required this.notificationsRepoImp})
    : super(ReadNotificationInitial());

  Future<void> readNotification({required String id}) async {
    emit(ReadNotificationLoading());
    try {
      var result = await notificationsRepoImp.readNotification(
        notificationId: id,
      );
      result.fold(
        (failure) {
          emit(ReadNotificationFailure(errorMessage: failure.errMessage));
        },
        (_) {
          emit(ReadNotificationSuccess(message: "تم قراءة الإشعار"));
          // Store user globally
        },
      );
    } catch (error) {
      emit(ReadNotificationFailure(errorMessage: error.toString()));
    }
  }
}
