import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/monthly/single_finance_monthly_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_monthly_finance_details_state.dart';

class GetMonthlyFinanceDetailsCubit
    extends Cubit<GetMonthlyFinanceDetailsState> {
  final FinancesRepoImp repo;

  GetMonthlyFinanceDetailsCubit({required this.repo})
    : super(GetMonthlyFinanceDetailsInitial());

  Future<void> getMonthlyFinanceDetails({required String paymentId}) async {
    emit(GetMonthlyFinanceDetailsLoading());
    try {
      var result = await repo.getMonthlyFinanceDetails(paymentId: paymentId);
      result.fold(
        (failure) {
          emit(GetMonthlyFinanceDetailsFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetMonthlyFinanceDetailsSuccess(finance: data));
        },
      );
    } catch (error) {
      emit(GetMonthlyFinanceDetailsFailure(errMessage: error.toString()));
    }
  }
}
