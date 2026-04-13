import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/models/update_profile_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final SettingsRepoImp repo;

  UpdateProfileCubit({required this.repo}) : super(UpdateProfileInitial());

  Future<void> updateProfile({required UpdateProfileModel profile}) async {
    emit(UpdateProfileLoading());
    try {
      var result = await repo.updateProfile(profile: profile);
      result.fold(
        (failure) {
          emit(UpdateProfileFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(UpdateProfileSuccess(message: data));
        },
      );
    } catch (error) {
      emit(UpdateProfileFailure(errMessage: error.toString()));
    }
  }
}
