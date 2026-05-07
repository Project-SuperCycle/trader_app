import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_logo_state.dart';

class UpdateLogoCubit extends Cubit<UpdateLogoState> {
  final SettingsRepoImp repo;

  UpdateLogoCubit({required this.repo}) : super(UpdateLogoInitial());

  Future<void> updateLogo({required File logo}) async {
    emit(UpdateLogoLoading());
    try {
      var result = await repo.updateLogo(logo: logo);
      result.fold(
        (failure) {
          emit(UpdateLogoFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(UpdateLogoSuccess(imageUrl: data));
        },
      );
    } catch (error) {
      emit(UpdateLogoFailure(errMessage: error.toString()));
    }
  }
}
