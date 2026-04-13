part of 'get_external_finance_details_cubit.dart';

@immutable
sealed class GetExternalFinanceDetailsState {}

final class GetExternalFinanceDetailsInitial
    extends GetExternalFinanceDetailsState {}

final class GetExternalFinanceDetailsLoading
    extends GetExternalFinanceDetailsState {}

final class GetExternalFinanceDetailsSuccess
    extends GetExternalFinanceDetailsState {
  final SingleFinanceExternalModel finance;

  GetExternalFinanceDetailsSuccess({required this.finance});
}

final class GetExternalFinanceDetailsFailure
    extends GetExternalFinanceDetailsState {
  final String errMessage;

  GetExternalFinanceDetailsFailure({required this.errMessage});
}
