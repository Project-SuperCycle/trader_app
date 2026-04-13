part of 'get_meal_finance_details_cubit.dart';

@immutable
sealed class GetMealFinanceDetailsState {}

final class GetMealFinanceDetailsInitial extends GetMealFinanceDetailsState {}

final class GetMealFinanceDetailsLoading extends GetMealFinanceDetailsState {}

final class GetMealFinanceDetailsSuccess extends GetMealFinanceDetailsState {
  final SingleFinanceMealModel finance;

  GetMealFinanceDetailsSuccess({required this.finance});
}

final class GetMealFinanceDetailsFailure extends GetMealFinanceDetailsState {
  final String errMessage;

  GetMealFinanceDetailsFailure({required this.errMessage});
}
