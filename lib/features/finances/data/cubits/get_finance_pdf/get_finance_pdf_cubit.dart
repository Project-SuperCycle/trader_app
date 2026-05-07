import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_finance_pdf_state.dart';

class GetFinancePdfCubit extends Cubit<GetFinancePdfState> {
  final FinancesRepoImp repo;

  GetFinancePdfCubit({required this.repo}) : super(GetFinancePdfInitial());

  Future<void> getFinancePdf({required String paymentId}) async {
    emit(GetFinancePdfLoading());
    try {
      var result = await repo.getFinancePdf(paymentId: paymentId);
      result.fold(
        (failure) {
          emit(GetFinancePdfFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetFinancePdfSuccess(pdfUrl: data));
        },
      );
    } catch (error) {
      emit(GetFinancePdfFailure(errMessage: error.toString()));
    }
  }
}
