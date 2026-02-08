import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/models/notifications_model.dart';
import 'package:trader_app/features/notifications/data/repos/notifications_repo_imp.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  final NotificationsRepoImp notificationsRepoImp;

  GetNotificationsCubit({required this.notificationsRepoImp})
    : super(GetNotificationsInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    try {
      var result = await notificationsRepoImp.fetchNotifications();
      result.fold(
        (failure) {
          emit(GetNotificationsFailure(errorMessage: failure.errMessage));
        },
        (notifications) {
          emit(GetNotificationsSuccess(notifications: notifications));
          // Store user globally
        },
      );
    } catch (error) {
      emit(GetNotificationsFailure(errorMessage: error.toString()));
    }
  }
}
