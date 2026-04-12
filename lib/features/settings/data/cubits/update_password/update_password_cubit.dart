import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final SettingsRepoImp repo;

  UpdatePasswordCubit({required this.repo}) : super(UpdatePasswordInitial());
}
