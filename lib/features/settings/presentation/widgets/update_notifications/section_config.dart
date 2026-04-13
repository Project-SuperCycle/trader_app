import 'package:flutter/material.dart';
import 'package:trader_app/features/settings/data/classes/notification_channel_data.dart';
import 'package:trader_app/features/settings/data/classes/notifications_settings_data.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/channel_row.dart';

class SectionConfig {
  final String title;
  final IconData icon;
  final List<ChannelRow> rows;
  final NotificationChannelData Function(NotificationsSettingsData) getter;
  final NotificationsSettingsData Function(
    NotificationsSettingsData,
    NotificationChannelData,
  )
  setter;

  const SectionConfig({
    required this.title,
    required this.icon,
    required this.rows,
    required this.getter,
    required this.setter,
  });
}
