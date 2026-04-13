import 'package:flutter/material.dart';
import 'package:trader_app/features/settings/data/classes/notification_channel_data.dart';
import 'package:trader_app/features/settings/data/classes/notifications_settings_data.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/channel_row.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/section_config.dart';

import 'notification_section_card.dart';

// ─────────────────────────────────────────────
//  Widget
// ─────────────────────────────────────────────

class UpdateNotificationsPermissions extends StatefulWidget {
  final NotificationsSettingsData? initialData;

  const UpdateNotificationsPermissions({super.key, this.initialData});

  @override
  State<UpdateNotificationsPermissions> createState() =>
      _UpdateNotificationsPermissionsState();
}

class _UpdateNotificationsPermissionsState
    extends State<UpdateNotificationsPermissions> {
  late NotificationsSettingsData _data;

  static const Color _primaryGreen = Color(0xFF1B7A4A);

  static final List<SectionConfig> _sections = [
    SectionConfig(
      title: 'إشعارات الشحنات',
      icon: Icons.local_shipping_outlined,
      rows: const [
        ChannelRow(
          title: 'داخل التطبيق',
          subtitle: 'تنبيهات تظهر داخل واجهة المستخدم',
        ),
        ChannelRow(
          title: 'إشعارات لحظية',
          subtitle: 'تنبيهات فورية على شاشة القفل',
        ),
        ChannelRow(
          title: 'عبر البريد الإلكتروني',
          subtitle: 'تقارير أسبوعية وملخصات الشحن',
        ),
      ],
      getter: (d) => d.shipments,
      setter: (d, v) => NotificationsSettingsData(
        shipments: v,
        finances: d.finances,
        system: d.system,
      ),
    ),
    SectionConfig(
      title: 'إشعارات الماليات',
      icon: Icons.receipt_long_outlined,
      rows: const [
        ChannelRow(
          title: 'داخل التطبيق',
          subtitle: 'تنبيهات الفواتير والمدفوعات',
        ),
        ChannelRow(
          title: 'إشعارات لحظية',
          subtitle: 'تنبيهات فورية بالتحويلات المالية',
        ),
        ChannelRow(
          title: 'عبر البريد الإلكتروني',
          subtitle: 'الفواتير الضريبية بنسيخة PDF',
        ),
      ],
      getter: (d) => d.finances,
      setter: (d, v) => NotificationsSettingsData(
        shipments: d.shipments,
        finances: v,
        system: d.system,
      ),
    ),
    SectionConfig(
      title: 'إشعارات النظام',
      icon: Icons.settings_outlined,
      rows: const [
        ChannelRow(
          title: 'داخل التطبيق',
          subtitle: 'تنبيهات تحديثات التطبيق والمزات',
        ),
        ChannelRow(title: 'إشعارات لحظية', subtitle: 'إعلانات الصيانة الهامة'),
        ChannelRow(
          title: 'عبر البريد الإلكتروني',
          subtitle: 'تنبيهات أمان الحساب وتغيير المرور',
        ),
      ],
      getter: (d) => d.system,
      setter: (d, v) => NotificationsSettingsData(
        shipments: d.shipments,
        finances: d.finances,
        system: v,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _data =
        widget.initialData ??
        NotificationsSettingsData(
          shipments: NotificationChannelData(
            inApp: true,
            local: true,
            email: false,
          ),
          finances: NotificationChannelData(
            inApp: true,
            local: true,
            email: false,
          ),
          system: NotificationChannelData(
            inApp: true,
            local: false,
            email: false,
          ),
        );
  }

  NotificationChannelData _setField(
    NotificationChannelData channel,
    int index,
    bool value,
  ) {
    return switch (index) {
      0 => channel.copyWith(inApp: value),
      1 => channel.copyWith(local: value),
      2 => channel.copyWith(email: value),
      _ => channel,
    };
  }

  void _save() {}

  void _cancel() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._sections.map((section) {
          final channel = section.getter(_data);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: NotificationSectionCard(
              config: section,
              channel: channel,
              primaryGreen: _primaryGreen,
              onRowChanged: (rowIndex, value) {
                setState(() {
                  final updated = _setField(channel, rowIndex, value);
                  _data = section.setter(_data, updated);
                });
              },
            ),
          );
        }),

        const SizedBox(height: 8),

        // ── Save Button ──
        SaveButton(onSave: _save),

        const SizedBox(height: 10),

        // ── Cancel Button ──
        CancelButton(onCancel: _cancel),
      ],
    );
  }
}
