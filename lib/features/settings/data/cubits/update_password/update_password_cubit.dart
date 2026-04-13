import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/models/update_password_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final SettingsRepoImp repo;

  UpdatePasswordCubit({required this.repo}) : super(UpdatePasswordInitial());

  Future<void> updatePassword({required UpdatePasswordModel password}) async {
    emit(UpdatePasswordLoading());
    try {
      var result = await repo.updatePassword(password: password);
      result.fold(
        (failure) {
          emit(UpdatePasswordFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(UpdatePasswordSuccess(message: data));
        },
      );
    } catch (error) {
      emit(UpdatePasswordFailure(errMessage: error.toString()));
    }
  }
}
