import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/finance_transaction_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_finance_transactions_state.dart';

class GetFinanceTransactionsCubit extends Cubit<GetFinanceTransactionsState> {
  final FinancesRepoImp repo;

  GetFinanceTransactionsCubit({required this.repo})
    : super(GetFinanceTransactionsInitial());

  Future<void> getFinancesTransactions({
    required String type,
    required String status,
    required int page,
  }) async {
    emit(GetFinanceTransactionsLoading());
    try {
      var result = await repo.getFinanceTransactions(
        type: type,
        status: status,
        page: page,
      );
      result.fold(
        (failure) {
          emit(GetFinanceTransactionsFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetFinanceTransactionsSuccess(finances: data));
        },
      );
    } catch (error) {
      emit(GetFinanceTransactionsFailure(errMessage: error.toString()));
    }
  }
}
