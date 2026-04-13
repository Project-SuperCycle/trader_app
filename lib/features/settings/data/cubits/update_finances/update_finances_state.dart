part of 'update_finances_cubit.dart';

@immutable
sealed class UpdateFinancesState {}

final class UpdateFinancesInitial extends UpdateFinancesState {}

final class UpdateFinancesLoading extends UpdateFinancesState {}

final class UpdateFinancesSuccess extends UpdateFinancesState {
  final String message;

  UpdateFinancesSuccess({required this.message});
}

final class UpdateFinancesFailure extends UpdateFinancesState {
  final String errMessage;

  UpdateFinancesFailure({required this.errMessage});
}
