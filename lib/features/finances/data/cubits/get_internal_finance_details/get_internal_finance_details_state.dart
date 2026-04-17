part of 'get_internal_finance_details_cubit.dart';

@immutable
sealed class GetInternalFinanceDetailsState {}

final class GetInternalFinanceDetailsInitial
    extends GetInternalFinanceDetailsState {}

final class GetInternalFinanceDetailsLoading
    extends GetInternalFinanceDetailsState {}

final class GetInternalFinanceDetailsSuccess
    extends GetInternalFinanceDetailsState {
  final SingleFinanceInternalModel finance;

  GetInternalFinanceDetailsSuccess({required this.finance});
}

final class GetInternalFinanceDetailsFailure
    extends GetInternalFinanceDetailsState {
  final String errMessage;

  GetInternalFinanceDetailsFailure({required this.errMessage});
}
