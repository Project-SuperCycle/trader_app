import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader_app/features/settings/data/repos/settings_repo_imp.dart';

part 'update_notifications_state.dart';

class UpdateNotificationsCubit extends Cubit<UpdateNotificationsState> {
  final SettingsRepoImp repo;

  UpdateNotificationsCubit({required this.repo})
    : super(UpdateNotificationsInitial());
}
