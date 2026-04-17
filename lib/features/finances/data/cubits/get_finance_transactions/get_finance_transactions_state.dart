part of 'get_finance_transactions_cubit.dart';

@immutable
sealed class GetFinanceTransactionsState {}

final class GetFinanceTransactionsInitial extends GetFinanceTransactionsState {}

final class GetFinanceTransactionsLoading extends GetFinanceTransactionsState {}

final class GetFinanceTransactionsSuccess extends GetFinanceTransactionsState {
  final List<FinanceTransactionModel> finances;

  GetFinanceTransactionsSuccess({required this.finances});
}

final class GetFinanceTransactionsFailure extends GetFinanceTransactionsState {
  final String errMessage;

  GetFinanceTransactionsFailure({required this.errMessage});
}
