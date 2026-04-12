part of 'get_monthly_finances_cubit.dart';

@immutable
sealed class GetMonthlyFinancesState {}

final class GetMonthlyFinancesInitial extends GetMonthlyFinancesState {}

final class GetMonthlyFinancesLoading extends GetMonthlyFinancesState {}

final class GetMonthlyFinancesSuccess extends GetMonthlyFinancesState {
  final List<FinanceMonthlyModel> finances;

  GetMonthlyFinancesSuccess({required this.finances});
}

final class GetMonthlyFinancesFailure extends GetMonthlyFinancesState {
  final String errMessage;

  GetMonthlyFinancesFailure({required this.errMessage});
}
