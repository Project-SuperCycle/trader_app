import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/models/update_notifications_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_notifications_state.dart';

class UpdateNotificationsCubit extends Cubit<UpdateNotificationsState> {
  final SettingsRepoImp repo;

  UpdateNotificationsCubit({required this.repo})
    : super(UpdateNotificationsInitial());

  Future<void> updateNotificationsPermissions({
    required UpdateNotificationsModel permissions,
  }) async {
    emit(UpdateNotificationsLoading());
    try {
      var result = await repo.updateNotificationsPermissions(
        permissions: permissions,
      );
      result.fold(
        (failure) {
          emit(UpdateNotificationsFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(UpdateNotificationsSuccess(message: data));
        },
      );
    } catch (error) {
      emit(UpdateNotificationsFailure(errMessage: error.toString()));
    }
  }
}
