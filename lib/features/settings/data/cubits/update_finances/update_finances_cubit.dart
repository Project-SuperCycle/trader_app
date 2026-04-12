import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_finances_state.dart';

class UpdateFinancesCubit extends Cubit<UpdateFinancesState> {
  final SettingsRepoImp repo;

  UpdateFinancesCubit({required this.repo}) : super(UpdateFinancesInitial());
}
