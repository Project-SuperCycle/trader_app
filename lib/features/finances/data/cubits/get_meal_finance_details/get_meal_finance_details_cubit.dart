import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/meal/single_finance_meal_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_meal_finance_details_state.dart';

class GetMealFinanceDetailsCubit extends Cubit<GetMealFinanceDetailsState> {
  final FinancesRepoImp repo;

  GetMealFinanceDetailsCubit({required this.repo})
    : super(GetMealFinanceDetailsInitial());

  Future<void> getMealFinanceDetails({required String paymentId}) async {
    emit(GetMealFinanceDetailsLoading());
    try {
      var result = await repo.getMealFinanceDetails(paymentId: paymentId);
      result.fold(
        (failure) {
          emit(GetMealFinanceDetailsFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetMealFinanceDetailsSuccess(finance: data));
        },
      );
    } catch (error) {
      emit(GetMealFinanceDetailsFailure(errMessage: error.toString()));
    }
  }
}
