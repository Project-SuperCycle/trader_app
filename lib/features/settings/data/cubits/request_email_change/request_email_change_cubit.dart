import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/models/request_email_change_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'request_email_change_state.dart';

class RequestEmailChangeCubit extends Cubit<RequestEmailChangeState> {
  final SettingsRepoImp repo;

  RequestEmailChangeCubit({required this.repo})
    : super(RequestEmailChangeInitial());

  Future<void> requestEmailChange({
    required RequestEmailChangeModel email,
  }) async {
    emit(RequestEmailChangeLoading());
    try {
      var result = await repo.requestEmailChange(email: email);
      result.fold(
        (failure) {
          emit(RequestEmailChangeFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(RequestEmailChangeSuccess(message: data));
        },
      );
    } catch (error) {
      emit(RequestEmailChangeFailure(errMessage: error.toString()));
    }
  }
}
