import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/entities/transaction_model.dart';

class FinancialCollectionCard extends StatelessWidget {
  const FinancialCollectionCard({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Section (Gradient) ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: kGradientButton,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kBorderRadius),
                  topRight: Radius.circular(kBorderRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Reference + Status ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Reference Number
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'رقم المرجع: #${transaction.id}',
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleSemiBold12(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          transaction.isPending ? 'منتظر' : 'تم التحصيل',
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleBold12(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Total Amount ──
                  Text(
                    'إجمالي المبلغ المحصل',
                    textDirection: TextDirection.rtl,
                    style: AppStyles.styleMedium14(
                      context,
                    ).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transaction.totalAmount
                            .toStringAsFixed(0)
                            .replaceAllMapped(
                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                              (m) => ',',
                            ),
                        style: AppStyles.styleBold24(
                          context,
                        ).copyWith(color: Colors.white, fontSize: 36),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ج.م',
                        style: AppStyles.styleSemiBold16(
                          context,
                        ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Bottom Section (White) ──
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ── Date Part ──
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date Range
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'من تاريخ',
                              textDirection: TextDirection.rtl,
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: Colors.grey.shade400),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey.shade400,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),

                                Text(
                                  transaction.date.split('•').first.trim(),
                                  textDirection: TextDirection.rtl,
                                  style: AppStyles.styleBold14(context),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'إلى تاريخ',
                              textDirection: TextDirection.rtl,
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: Colors.grey.shade400),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey.shade400,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),

                                Text(
                                  transaction.date.split('•').first.trim(),
                                  textDirection: TextDirection.rtl,
                                  style: AppStyles.styleBold14(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Divider(color: Colors.grey.shade300, thickness: 0.75),

                  // ── Payment Method ──
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date Range
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'حالة التحصيل',
                              textDirection: TextDirection.rtl,
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: Colors.grey.shade400),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle_rounded,
                                  color: Color(0xFF3BC577),
                                  size: 8,
                                ),
                                const SizedBox(width: 4),

                                Text(
                                  'تم التحصيل',
                                  textDirection: TextDirection.rtl,
                                  style: AppStyles.styleBold12(
                                    context,
                                  ).copyWith(color: Color(0xFF10B981)),
                                ),
                              ],
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
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_outlined,
                                  color: const Color(0xFF3BC577),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  transaction.paymentMethod,
                                  textDirection: TextDirection.rtl,
                                  style: AppStyles.styleBold14(
                                    context,
                                  ).copyWith(color: Color(0xFF10B981)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Images Section ──
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'صور إثبات التحصيل',
                      textDirection: TextDirection.rtl,
                      style: AppStyles.styleMedium12(
                        context,
                      ).copyWith(color: Colors.grey.shade400),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Image 1
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade100,
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.grey.shade300,
                            size: 28,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Image 2
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade100,
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.grey.shade300,
                            size: 28,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Add Image Button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF3BC577,
                            ).withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(
                                0xFF3BC577,
                              ).withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: const Color(
                              0xFF3BC577,
                            ).withValues(alpha: 0.5),
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getWeightUnit(num totalWeight) {
  return totalWeight < 1000 ? 'كجم' : 'طن';
}

num getWeightValue(num totalWeight) {
  return totalWeight < 1000 ? totalWeight : totalWeight / 1000;
}
