part of 'get_external_finances_cubit.dart';

@immutable
sealed class GetExternalFinancesState {}

final class GetExternalFinancesInitial extends GetExternalFinancesState {}

final class GetExternalFinancesLoading extends GetExternalFinancesState {}

final class GetExternalFinancesSuccess extends GetExternalFinancesState {
  final List<FinanceExternalModel> finances;

  GetExternalFinancesSuccess({required this.finances});
}

final class GetExternalFinancesFailure extends GetExternalFinancesState {
  final String errMessage;

  GetExternalFinancesFailure({required this.errMessage});
}
