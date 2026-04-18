import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/functions/get_formated_date.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';

class ShipmentHeroCard extends StatelessWidget {
  const ShipmentHeroCard({super.key, required this.transaction});

  final SingleFinanceExternalModel transaction;

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Date + Shipment ID ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'رقم الشحنة',
                  textDirection: TextDirection.rtl,
                  style: AppStyles.styleMedium12(
                    context,
                  ).copyWith(color: Colors.grey.shade400),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3BC577).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF3BC577),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        getFormattedDateLabel(transaction.paidAt!),
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleSemiBold14(
                          context,
                        ).copyWith(color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                transaction.shipmentNumber,
                style: AppStyles.styleBold24(
                  context,
                ).copyWith(color: Color(0xFF10B981)),
              ),
            ),

            const SizedBox(height: 16),

            // ── Row 2: Material Type + Total Weight ──
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إجمالي الوزن',
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleMedium12(
                            context,
                          ).copyWith(color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              getWeightValue(transaction.weight).toString(),
                              style: AppStyles.styleBold22(
                                context,
                              ).copyWith(color: Color(0xFF10B981)),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              getWeightUnit(transaction.weight),
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طريقة الدفع',
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleMedium12(
                            context,
                          ).copyWith(color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              getPaymentType(transaction.paymentMethod),
                              textDirection: TextDirection.rtl,
                              style: AppStyles.styleBold22(
                                context,
                              ).copyWith(color: Color(0xFF10B981)),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.recycling_rounded,
                              color: Color(0xFF3BC577),
                              size: 20,
                            ),
                          ],
                        ),
                      ],
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

String getWeightUnit(num totalWeight) {
  return totalWeight < 1000 ? 'كجم' : 'طن';
}

num getWeightValue(num totalWeight) {
  return totalWeight < 1000 ? totalWeight : totalWeight / 1000;
}

String getPaymentType(String paymentMethod) {
  switch (paymentMethod) {
    case 'cash':
      return 'نقدي';
    case 'bankTransfer':
      return 'بنكي';
    case 'wallet':
      return 'محفظة';
    default:
      return 'نقدي';
  }
}
