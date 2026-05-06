import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/finances_part/info_row.dart';

// ─── Single Payment Method Card ───────────────────────────────────────────────
class PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<InfoRow> rows;

  const PaymentMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.rows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icon,
                          size: 20,
                          color: AppColors.primary.withValues(alpha: 0.9),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: AppStyles.styleSemiBold14(
                          context,
                        ).copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  if (rows.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    ...rows.map((r) => _InfoRowWidget(row: r)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Detail Row Widget ────────────────────────────────────────────────────────
class _InfoRowWidget extends StatelessWidget {
  final InfoRow row;

  const _InfoRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 16),
      child: Row(
        children: [
          Text(
            '${row.label}: ',
            style: AppStyles.styleMedium12(
              context,
            ).copyWith(color: AppColors.subTextColor),
          ),
          Flexible(
            child: Text(
              row.value,
              style: AppStyles.styleMedium12(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
