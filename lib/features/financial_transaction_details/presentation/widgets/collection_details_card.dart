import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/entities/transaction_model.dart';

class CollectionDetailsCard extends StatelessWidget {
  const CollectionDetailsCard({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3BC577).withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: Title + Status ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title + Icon
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3BC577).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.receipt_outlined,
                        color: Color(0xFF3BC577),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'بيانات التحصيل',
                      textDirection: TextDirection.rtl,
                      style: AppStyles.styleBold16(
                        context,
                      ).copyWith(color: Color(0xFF10B981)),
                    ),
                    const SizedBox(width: 110),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: transaction.isPending
                            ? Colors.orange.withValues(alpha: 0.12)
                            : const Color(0xFF3BC577).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: transaction.isPending
                                ? Colors.orange.shade700
                                : const Color(0xFF3BC577),
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            transaction.isPending ? 'منتظر' : 'تم التحصيل',
                            textDirection: TextDirection.rtl,
                            style: AppStyles.styleBold12(context).copyWith(
                              color: transaction.isPending
                                  ? Colors.orange.shade700
                                  : const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Amount + Payment Method ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF3BC577).withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3BC577).withValues(alpha: 0.15),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Total Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إجمالي المبلغ المستحق',
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.totalAmount
                            .toStringAsFixed(0)
                            .replaceAllMapped(
                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                              (m) => ',',
                            ),
                        style: AppStyles.styleBold24(
                          context,
                        ).copyWith(color: Color(0xFF10B981), fontSize: 30),
                      ),
                      Text(
                        'جنيه مصري',
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.grey.shade400),
                      ),
                    ],
                  ),

                  // Payment Method
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'طريقة التحصيل',
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        transaction.paymentMethod,
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleBold16(
                          context,
                        ).copyWith(color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Images Row ──
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      color: const Color(0xFF3BC577).withValues(alpha: 0.07),
                      child: Icon(
                        Icons.image_outlined,
                        color: const Color(0xFF3BC577).withValues(alpha: 0.4),
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      color: const Color(0xFF3BC577).withValues(alpha: 0.07),
                      child: Icon(
                        Icons.image_outlined,
                        color: const Color(0xFF3BC577).withValues(alpha: 0.4),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
