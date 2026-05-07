import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.enabled,
    required this.onChanged,
    required this.children,
  });

  static const Color _primaryGreen = Color(0xFF1B7A4A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 0.75,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row — icon + title + switch in one row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _primaryGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: _primaryGreen, size: 20),
                  ),
                  const SizedBox(width: 8),

                  Text(
                    title,
                    style: AppStyles.styleMedium14(context),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),

              Switch(
                value: enabled,
                onChanged: onChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade200,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),

          // Animated extra fields
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: enabled && children.isNotEmpty
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 14),
                const Divider(height: 1, thickness: 0.5),
                const SizedBox(height: 14),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
