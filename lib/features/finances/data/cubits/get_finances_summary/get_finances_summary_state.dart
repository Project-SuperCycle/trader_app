part of 'get_finances_summary_cubit.dart';

@immutable
sealed class GetFinancesSummaryState {}

final class GetFinancesSummaryInitial extends GetFinancesSummaryState {}

final class GetFinancesSummaryLoading extends GetFinancesSummaryState {}

final class GetFinancesSummarySuccess extends GetFinancesSummaryState {
  final FinanceSummaryModel summary;

  GetFinancesSummarySuccess({required this.summary});
}

final class GetFinancesSummaryFailure extends GetFinancesSummaryState {
  final String errMessage;

  GetFinancesSummaryFailure({required this.errMessage});
}
