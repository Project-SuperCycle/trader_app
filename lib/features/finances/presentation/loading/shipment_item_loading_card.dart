import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';

class ShipmentItemLoadingCard extends StatelessWidget {
  const ShipmentItemLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border(
          right: BorderSide(
            color: const Color(0xFF3BC577).withValues(alpha: 0.75),
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
                      CustomFadingWidget.line(width: 60, height: 12),
                      const SizedBox(height: 6),
                      CustomFadingWidget.line(width: 120, height: 16),
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
                        CustomFadingWidget.line(width: 60, height: 12),
                        const SizedBox(height: 6),
                        CustomFadingWidget.line(width: 100, height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Row 2: Weight + Value ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                      CustomFadingWidget.box(
                        width: 30,
                        height: 30,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFadingWidget.line(width: 50, height: 10),
                          const SizedBox(height: 4),
                          CustomFadingWidget.line(width: 70, height: 18),
                        ],
                      ),
                    ],
                  ),

                  // Value
                  Row(
                    children: [
                      CustomFadingWidget.box(
                        width: 30,
                        height: 30,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFadingWidget.line(width: 40, height: 10),
                          const SizedBox(height: 4),
                          CustomFadingWidget.line(width: 80, height: 18),
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
                    CustomFadingWidget.line(width: 80, height: 12),
                    const SizedBox(width: 6),
                    CustomFadingWidget.line(width: 60, height: 12),
                  ],
                ),

                // Details Button
                CustomFadingWidget.line(width: 60, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
