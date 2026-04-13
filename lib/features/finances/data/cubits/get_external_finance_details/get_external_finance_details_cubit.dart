import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_external_finance_details_state.dart';

class GetExternalFinanceDetailsCubit
    extends Cubit<GetExternalFinanceDetailsState> {
  final FinancesRepoImp repo;

  GetExternalFinanceDetailsCubit({required this.repo})
    : super(GetExternalFinanceDetailsInitial());

  Future<void> getExternalFinanceDetails({required String shipmentId}) async {
    emit(GetExternalFinanceDetailsLoading());
    try {
      var result = await repo.getExternalFinanceDetails(shipmentId: shipmentId);
      result.fold(
        (failure) {
          emit(
            GetExternalFinanceDetailsFailure(errMessage: failure.errMessage),
          );
        },
        (data) {
          emit(GetExternalFinanceDetailsSuccess(finance: data));
        },
      );
    } catch (error) {
      emit(GetExternalFinanceDetailsFailure(errMessage: error.toString()));
    }
  }
}
