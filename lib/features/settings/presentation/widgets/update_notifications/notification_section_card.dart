import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/section_config.dart';
import 'package:trader_app/features/sign_in/data/models/notification_preferences_model.dart';

class NotificationSectionCard extends StatelessWidget {
  final SectionConfig config;
  final NotificationChannelModel channel;
  final Color primaryGreen;
  final void Function(int rowIndex, bool value) onRowChanged;

  const NotificationSectionCard({
    super.key,

    required this.config,
    required this.channel,
    required this.primaryGreen,
    required this.onRowChanged,
  });

  bool _getValue(int index) => switch (index) {
    0 => channel.inApp,
    1 => channel.push,
    2 => channel.email,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 0.75,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Section Header ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                // Icon badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(config.icon, color: primaryGreen, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    config.title,
                    textAlign: TextAlign.right,
                    style: AppStyles.styleSemiBold16(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ──
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),

          // ── Channel Rows ──
          ...List.generate(config.rows.length, (i) {
            final row = config.rows[i];
            final isLast = i == config.rows.length - 1;
            return Column(
              children: [
                _ChannelRowTile(
                  title: row.title,
                  subtitle: row.subtitle,
                  value: _getValue(i),
                  primaryGreen: primaryGreen,
                  onChanged: (v) => onRowChanged(i, v),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ChannelRowTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Color primaryGreen;
  final ValueChanged<bool> onChanged;

  const _ChannelRowTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.primaryGreen,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text on the right
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleMedium14(context),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: AppStyles.styleRegular12(
                    context,
                  ).copyWith(color: AppColors.subTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
