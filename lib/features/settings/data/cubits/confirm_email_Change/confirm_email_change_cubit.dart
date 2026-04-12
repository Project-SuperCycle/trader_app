import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'confirm_email_change_state.dart';

class ConfirmEmailChangeCubit extends Cubit<ConfirmEmailChangeState> {
  final SettingsRepoImp repo;

  ConfirmEmailChangeCubit({required this.repo})
    : super(ConfirmEmailChangeInitial());

  Future<void> confirmEmailChange({required String otp}) async {
    emit(ConfirmEmailChangeLoading());
    try {
      var result = await repo.confirmEmailChange(otp: otp);
      result.fold(
        (failure) {
          emit(ConfirmEmailChangeFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(ConfirmEmailChangeSuccess(message: data));
        },
      );
    } catch (error) {
      emit(ConfirmEmailChangeFailure(errMessage: error.toString()));
    }
  }
}
