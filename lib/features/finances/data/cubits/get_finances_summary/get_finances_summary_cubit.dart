import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/finance_summary_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_finances_summary_state.dart';

class GetFinancesSummaryCubit extends Cubit<GetFinancesSummaryState> {
  final FinancesRepoImp repo;

  GetFinancesSummaryCubit({required this.repo})
    : super(GetFinancesSummaryInitial());

  Future<void> getFinancesSummary({required String type}) async {
    emit(GetFinancesSummaryLoading());
    try {
      var result = await repo.getFinancesSummary(type: type);
      result.fold(
        (failure) {
          emit(GetFinancesSummaryFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetFinancesSummarySuccess(summary: data));
        },
      );
    } catch (error) {
      emit(GetFinancesSummaryFailure(errMessage: error.toString()));
    }
  }
}
