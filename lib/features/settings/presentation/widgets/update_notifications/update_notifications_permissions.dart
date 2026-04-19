import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/features/settings/data/cubits/update_notifications/update_notifications_cubit.dart';
import 'package:trader_app/features/settings/data/models/update_notifications_model.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/channel_row.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/section_config.dart';
import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

import 'notification_section_card.dart';

// ─────────────────────────────────────────────
//  Widget
// ─────────────────────────────────────────────

class UpdateNotificationsPermissions extends StatefulWidget {
  const UpdateNotificationsPermissions({super.key});

  @override
  State<UpdateNotificationsPermissions> createState() =>
      _UpdateNotificationsPermissionsState();
}

class _UpdateNotificationsPermissionsState
    extends State<UpdateNotificationsPermissions> {
  NotificationPreferencesModel _data = NotificationPreferencesModel();

  static const Color _primaryGreen = Color(0xFF1B7A4A);

  final List<SectionConfig> _sections = [
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
      getter: (d) =>
          d.shipments ??
          NotificationChannelModel(inApp: true, push: true, email: true),
      // ✅ null-safe
      setter: (d, v) => NotificationPreferencesModel(
        shipments: v,
        finance:
            d.finance ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
        system:
            d.system ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
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
          subtitle: 'الفواتير الضريبية بنسخة PDF',
        ),
      ],
      getter: (d) =>
          d.finance ??
          NotificationChannelModel(inApp: true, push: true, email: true),
      // ✅ null-safe
      setter: (d, v) => NotificationPreferencesModel(
        shipments:
            d.shipments ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
        finance: v,
        system:
            d.system ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
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
      getter: (d) =>
          d.system ??
          NotificationChannelModel(inApp: true, push: true, email: true),
      // ✅ null-safe
      setter: (d, v) => NotificationPreferencesModel(
        shipments:
            d.shipments ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
        finance:
            d.finance ??
            NotificationChannelModel(
              inApp: true,
              push: true,
              email: true,
            ), // ✅ null-safe
        system: v,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageServices.getUserData();
    if (userData != null) {
      final notificationPreferences = userData.notificationPreferences;
      setState(() {
        _data = notificationPreferences;
      });
    }
  }

  NotificationChannelModel _setField(
    NotificationChannelModel channel,
    int index,
    bool value,
  ) {
    return switch (index) {
      0 => channel.copyWith(inApp: value),
      1 => channel.copyWith(push: value),
      2 => channel.copyWith(email: value),
      _ => channel,
    };
  }

  void _save() {
    NotificationPreferencesModel updatedData = _data;
    UpdateNotificationsModel model = UpdateNotificationsModel(
      shipments: updatedData.shipments!,
      finance: updatedData.finance!,
      system: updatedData.system!,
    );
    Logger().i('Saving notification permissions: $model');
    BlocProvider.of<UpdateNotificationsCubit>(
      context,
    ).updateNotificationsPermissions(permissions: model);
  }

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
        BlocConsumer<UpdateNotificationsCubit, UpdateNotificationsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UpdateNotificationsSuccess) {
              GoRouter.of(context).pop();
            }
            if (state is UpdateNotificationsFailure) {
              CustomSnackBar.showError(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is UpdateNotificationsLoading) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomLoadingIndicator(color: AppColors.primary),
                ),
              );
            }
            return SaveButton(onSave: _save);
          },
        ),

        const SizedBox(height: 10),

        // ── Cancel Button ──
        CancelButton(onCancel: _cancel),
      ],
    );
  }
}
