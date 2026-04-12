import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final SettingsRepoImp repo;

  UpdateProfileCubit({required this.repo}) : super(UpdateProfileInitial());
}
