part of 'get_monthly_finance_details_cubit.dart';

@immutable
sealed class GetMonthlyFinanceDetailsState {}

final class GetMonthlyFinanceDetailsInitial
    extends GetMonthlyFinanceDetailsState {}

final class GetMonthlyFinanceDetailsLoading
    extends GetMonthlyFinanceDetailsState {}

final class GetMonthlyFinanceDetailsSuccess
    extends GetMonthlyFinanceDetailsState {
  final SingleFinanceMonthlyModel finance;

  GetMonthlyFinanceDetailsSuccess({required this.finance});
}

final class GetMonthlyFinanceDetailsFailure
    extends GetMonthlyFinanceDetailsState {
  final String errMessage;

  GetMonthlyFinanceDetailsFailure({required this.errMessage});
}
