import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'request_email_change_state.dart';

class RequestEmailChangeCubit extends Cubit<RequestEmailChangeState> {
  final SettingsRepoImp repo;

  RequestEmailChangeCubit({required this.repo})
    : super(RequestEmailChangeInitial());
}
