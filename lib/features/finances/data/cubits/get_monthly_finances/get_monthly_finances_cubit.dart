import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/monthly/finance_monthly_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_monthly_finances_state.dart';

class GetMonthlyFinancesCubit extends Cubit<GetMonthlyFinancesState> {
  final FinancesRepoImp repo;

  GetMonthlyFinancesCubit({required this.repo})
    : super(GetMonthlyFinancesInitial());

  Future<void> getMonthlyFinances({
    required String type,
    required String status,
    required int page,
  }) async {
    emit(GetMonthlyFinancesLoading());
    try {
      var result = await repo.getMonthlyFinances(
        type: type,
        status: status,
        page: page,
      );
      result.fold(
        (failure) {
          emit(GetMonthlyFinancesFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetMonthlyFinancesSuccess(finances: data));
        },
      );
    } catch (error) {
      emit(GetMonthlyFinancesFailure(errMessage: error.toString()));
    }
  }
}
