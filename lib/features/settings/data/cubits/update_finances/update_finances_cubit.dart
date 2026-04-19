import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_finances_state.dart';

class UpdateFinancesCubit extends Cubit<UpdateFinancesState> {
  final SettingsRepoImp repo;

  UpdateFinancesCubit({required this.repo}) : super(UpdateFinancesInitial());

  Future<void> updateFinancesMethods({
    required FinancesMethodsModel methods,
  }) async {
    emit(UpdateFinancesLoading());
    try {
      var result = await repo.updateFinancesMethods(methods: methods);
      result.fold(
        (failure) {
          emit(UpdateFinancesFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(UpdateFinancesSuccess(message: data));
        },
      );
    } catch (error) {
      emit(UpdateFinancesFailure(errMessage: error.toString()));
    }
  }
}
