import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/external/finance_external_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_external_finances_state.dart';

class GetExternalFinancesCubit extends Cubit<GetExternalFinancesState> {
  final FinancesRepoImp repo;

  GetExternalFinancesCubit({required this.repo})
    : super(GetExternalFinancesInitial());

  Future<void> getExternalFinances({
    required String type,
    required String status,
    required int page,
  }) async {
    emit(GetExternalFinancesLoading());
    try {
      var result = await repo.getExternalFinances(
        type: type,
        status: status,
        page: page,
      );
      result.fold(
        (failure) {
          emit(GetExternalFinancesFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetExternalFinancesSuccess(finances: data));
        },
      );
    } catch (error) {
      emit(GetExternalFinancesFailure(errMessage: error.toString()));
    }
  }
}
