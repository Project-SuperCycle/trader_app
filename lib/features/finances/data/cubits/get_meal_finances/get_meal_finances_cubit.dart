import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/meal/finance_meal_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_meal_finances_state.dart';

class GetMealFinancesCubit extends Cubit<GetMealFinancesState> {
  final FinancesRepoImp repo;

  GetMealFinancesCubit({required this.repo}) : super(GetMealFinancesInitial());

  Future<void> getMealFinances({
    required String type,
    required String status,
    required int page,
  }) async {
    emit(GetMealFinancesLoading());
    try {
      var result = await repo.getMealFinances(
        type: type,
        status: status,
        page: page,
      );
      result.fold(
        (failure) {
          emit(GetMealFinancesFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetMealFinancesSuccess(finances: data));
        },
      );
    } catch (error) {
      emit(GetMealFinancesFailure(errMessage: error.toString()));
    }
  }
}
