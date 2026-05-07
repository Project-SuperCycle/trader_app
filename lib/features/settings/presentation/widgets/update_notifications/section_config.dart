import 'package:flutter/material.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/channel_row.dart';
import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

class SectionConfig {
  final String title;
  final IconData icon;
  final List<ChannelRow> rows;
  final NotificationChannelModel Function(NotificationPreferencesModel) getter;
  final NotificationPreferencesModel Function(
    NotificationPreferencesModel,
    NotificationChannelModel,
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
