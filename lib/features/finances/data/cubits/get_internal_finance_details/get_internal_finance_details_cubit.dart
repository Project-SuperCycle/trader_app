import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/internal/single_finance_internal_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_internal_finance_details_state.dart';

class GetInternalFinanceDetailsCubit
    extends Cubit<GetInternalFinanceDetailsState> {
  final FinancesRepoImp repo;

  GetInternalFinanceDetailsCubit({required this.repo})
    : super(GetInternalFinanceDetailsInitial());

  Future<void> getMonthlyFinanceDetails({required String paymentId}) async {
    emit(GetInternalFinanceDetailsLoading());
    try {
      var result = await repo.getMonthlyFinanceDetails(paymentId: paymentId);
      result.fold(
        (failure) {
          emit(
            GetInternalFinanceDetailsFailure(errMessage: failure.errMessage),
          );
        },
        (data) {
          emit(GetInternalFinanceDetailsSuccess(finance: data));
        },
      );
    } catch (error) {
      emit(GetInternalFinanceDetailsFailure(errMessage: error.toString()));
    }
  }

  Future<void> getMealFinanceDetails({required String paymentId}) async {
    emit(GetInternalFinanceDetailsLoading());
    try {
      var result = await repo.getMealFinanceDetails(paymentId: paymentId);
      result.fold(
        (failure) {
          emit(
            GetInternalFinanceDetailsFailure(errMessage: failure.errMessage),
          );
        },
        (data) {
          emit(GetInternalFinanceDetailsSuccess(finance: data));
        },
      );
    } catch (error) {
      emit(GetInternalFinanceDetailsFailure(errMessage: error.toString()));
    }
  }
}
