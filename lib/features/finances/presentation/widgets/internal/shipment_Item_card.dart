import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/functions/get_formaated_date.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/models/internal/finance_shipment_model.dart';

// ======== Shipment Card ========
class ShipmentItemCard extends StatelessWidget {
  const ShipmentItemCard({
    super.key,
    required this.shipment,
    required this.onDetailsTap,
  });

  final FinanceShipmentModel shipment;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border(
          right: BorderSide(
            color: Color(0xFF3BC577).withValues(alpha: 0.75),
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: Column(
            children: [
              // ── Row 1: Shipment Number + Date ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shipment Number
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم الشحنة',
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleMedium12(
                            context,
                          ).copyWith(color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shipment.shipmentNumber,
                          style: AppStyles.styleBold16(
                            context,
                          ).copyWith(color: Color(0xFF1A1A1A)),
                        ),
                      ],
                    ),
                  ),

                  // Date
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'تاريخ الوزن',
                            textDirection: TextDirection.rtl,
                            style: AppStyles.styleMedium12(
                              context,
                            ).copyWith(color: Colors.grey.shade400),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getFormattedDateLabel(shipment.weightedAt),
                            textDirection: TextDirection.rtl,
                            style: AppStyles.styleBold16(
                              context,
                            ).copyWith(color: Color(0xFF1A1A1A)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Row 2: Weight + Value ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200, width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Weight
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.inventory_2_outlined,
                                    color: Colors.grey.shade600,
                                    size: 16,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'الوزن الكلي',
                                      textDirection: TextDirection.rtl,
                                      style: AppStyles.styleMedium12(context)
                                          .copyWith(
                                            color: Colors.grey.shade400,
                                            fontSize: 10,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          getWeightValue(
                                            shipment.totalWeightedKg,
                                          ).toString(),
                                          style: AppStyles.styleBold18(
                                            context,
                                          ).copyWith(color: AppColors.primary),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          getWeightUnit(
                                            shipment.totalWeightedKg,
                                          ),
                                          style:
                                              AppStyles.styleSemiBold12(
                                                context,
                                              ).copyWith(
                                                color: Colors.grey.shade400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Value
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.attach_money_rounded,
                            color: Colors.grey.shade600,
                            size: 16,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'القيمة',
                              style: AppStyles.styleMedium12(context).copyWith(
                                color: Colors.grey.shade400,
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  shipment.amount
                                      .toStringAsFixed(0)
                                      .replaceAllMapped(
                                        RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                        (m) => ',',
                                      ),
                                  style: AppStyles.styleBold18(
                                    context,
                                  ).copyWith(color: AppColors.primary),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  'ج.م',
                                  style: AppStyles.styleSemiBold12(
                                    context,
                                  ).copyWith(color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Row 3: Payment Method + Details ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Payment Method
                  Row(
                    children: [
                      Text(
                        'طريقة التحصيل: ',
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.grey.shade400),
                      ),

                      Text(
                        shipment.paymentMethod,
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleSemiBold12(context),
                      ),
                    ],
                  ),

                  // Details Button
                  GestureDetector(
                    onTap: onDetailsTap,
                    child: Row(
                      children: [
                        Text(
                          'التفاصيل',
                          style: AppStyles.styleBold14(
                            context,
                          ).copyWith(color: Colors.grey.shade400),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
