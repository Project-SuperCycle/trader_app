import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_logo_state.dart';

class UpdateLogoCubit extends Cubit<UpdateLogoState> {
  final SettingsRepoImp repo;

  UpdateLogoCubit({required this.repo}) : super(UpdateLogoInitial());
}
