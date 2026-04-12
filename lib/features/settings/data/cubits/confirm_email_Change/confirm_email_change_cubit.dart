import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'confirm_email_change_state.dart';

class ConfirmEmailChangeCubit extends Cubit<ConfirmEmailChangeState> {
  final SettingsRepoImp repo;

  ConfirmEmailChangeCubit({required this.repo})
    : super(ConfirmEmailChangeInitial());

  // Future<void> getExternalFinanceDetails({required String shipmentId}) async {
  //   emit(GetExternalFinanceDetailsLoading());
  //   try {
  //     var result = await repo.getExternalFinanceDetails(shipmentId: shipmentId);
  //     result.fold(
  //           (failure) {
  //         emit(
  //           GetExternalFinanceDetailsFailure(errMessage: failure.errMessage),
  //         );
  //       },
  //           (data) {
  //         emit(GetExternalFinanceDetailsSuccess(finance: data));
  //       },
  //     );
  //   } catch (error) {
  //     emit(GetExternalFinanceDetailsFailure(errMessage: error.toString()));
  //   }
  // }
}
