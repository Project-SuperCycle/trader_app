import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/finances/data/models/methods/finance_method_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo_imp.dart';

part 'get_finance_methods_state.dart';

class GetFinanceMethodsCubit extends Cubit<GetFinanceMethodsState> {
  final FinancesRepoImp repo;

  GetFinanceMethodsCubit({required this.repo})
    : super(GetFinanceMethodsInitial());

  Future<void> getFinanceMethods() async {
    emit(GetFinanceMethodsLoading());
    try {
      var result = await repo.getFinanceMethods();
      result.fold(
        (failure) {
          emit(GetFinanceMethodsFailure(errMessage: failure.errMessage));
        },
        (data) {
          emit(GetFinanceMethodsSuccess(methods: data));
        },
      );
    } catch (error) {
      emit(GetFinanceMethodsFailure(errMessage: error.toString()));
    }
  }
}
