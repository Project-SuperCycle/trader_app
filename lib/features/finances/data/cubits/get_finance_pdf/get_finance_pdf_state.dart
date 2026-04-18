part of 'get_finance_pdf_cubit.dart';

@immutable
sealed class GetFinancePdfState {}

final class GetFinancePdfInitial extends GetFinancePdfState {}

final class GetFinancePdfLoading extends GetFinancePdfState {}

final class GetFinancePdfSuccess extends GetFinancePdfState {
  final String pdfUrl;

  GetFinancePdfSuccess({required this.pdfUrl});
}

final class GetFinancePdfFailure extends GetFinancePdfState {
  final String errMessage;

  GetFinancePdfFailure({required this.errMessage});
}
