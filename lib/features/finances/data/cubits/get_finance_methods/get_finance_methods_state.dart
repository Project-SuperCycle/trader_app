part of 'get_finance_methods_cubit.dart';

@immutable
sealed class GetFinanceMethodsState {}

final class GetFinanceMethodsInitial extends GetFinanceMethodsState {}

final class GetFinanceMethodsLoading extends GetFinanceMethodsState {}

final class GetFinanceMethodsSuccess extends GetFinanceMethodsState {
  final FinanceMethodModel methods;

  GetFinanceMethodsSuccess({required this.methods});
}

final class GetFinanceMethodsFailure extends GetFinanceMethodsState {
  final String errMessage;

  GetFinanceMethodsFailure({required this.errMessage});
}
