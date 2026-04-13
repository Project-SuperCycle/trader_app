import 'notification_channel_data.dart';

class NotificationsSettingsData {
  NotificationChannelData shipments;
  NotificationChannelData finances;
  NotificationChannelData system;

  NotificationsSettingsData({
    NotificationChannelData? shipments,
    NotificationChannelData? finances,
    NotificationChannelData? system,
  }) : shipments = shipments ?? NotificationChannelData(),
       finances = finances ?? NotificationChannelData(),
       system = system ?? NotificationChannelData();
}
