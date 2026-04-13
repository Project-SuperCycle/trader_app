part of 'get_meal_finances_cubit.dart';

@immutable
sealed class GetMealFinancesState {}

final class GetMealFinancesInitial extends GetMealFinancesState {}

final class GetMealFinancesLoading extends GetMealFinancesState {}

final class GetMealFinancesSuccess extends GetMealFinancesState {
  final List<FinanceMealModel> finances;

  GetMealFinancesSuccess({required this.finances});
}

final class GetMealFinancesFailure extends GetMealFinancesState {
  final String errMessage;

  GetMealFinancesFailure({required this.errMessage});
}
