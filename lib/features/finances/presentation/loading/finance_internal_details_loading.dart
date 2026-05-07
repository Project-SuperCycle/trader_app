import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/presentation/loading/shipment_item_loading_card.dart';

class FinanceInternalDetailsLoading extends StatelessWidget {
  const FinanceInternalDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FinancialCollectionLoadingCard(),
        const SizedBox(height: 16),
        _ShipmentsListLoadingSection(),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── FinancialCollectionCard skeleton ────────────────────────────────────────

class _FinancialCollectionLoadingCard extends StatelessWidget {
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
                  // Reference + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomFadingWidget.box(
                        width: 130,
                        height: 28,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      CustomFadingWidget.box(
                        width: 80,
                        height: 28,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Total Amount label
                  CustomFadingWidget.line(width: 120, height: 13),
                  const SizedBox(height: 10),
                  // Amount value
                  CustomFadingWidget.line(width: 180, height: 36),
                ],
              ),
            ),

            // ── Bottom Section (White) ──
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Date Part
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_LoadingDateColumn(), _LoadingDateColumn()],
                    ),
                  ),

                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300, thickness: 0.75),

                  // Payment Method
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _LoadingLabelValue(labelWidth: 72, valueWidth: 88),
                        _LoadingLabelValue(labelWidth: 80, valueWidth: 96),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Images label
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomFadingWidget.line(width: 110, height: 12),
                  ),
                  const SizedBox(height: 10),

                  // Images Row
                  Row(
                    children: [
                      CustomFadingWidget.box(
                        width: 80,
                        height: 80,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(width: 10),
                      CustomFadingWidget.box(
                        width: 80,
                        height: 80,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(width: 10),
                      CustomFadingWidget.box(
                        width: 80,
                        height: 80,
                        borderRadius: BorderRadius.circular(10),
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

// ── ShipmentsListSection skeleton ───────────────────────────────────────────

class _ShipmentsListLoadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الشحنات المتضمنة',
                textDirection: TextDirection.rtl,
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Colors.white),
              ),
              CustomFadingWidget.line(width: 64, height: 14),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Shipment Cards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, __) => ShipmentItemLoadingCard(),
        ),
      ],
    );
  }
}

// ── Shared helpers ───────────────────────────────────────────────────────────

class _LoadingDateColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFadingWidget.line(width: 56, height: 11),
        const SizedBox(height: 8),
        CustomFadingWidget.line(width: 96, height: 14),
      ],
    );
  }
}

class _LoadingLabelValue extends StatelessWidget {
  const _LoadingLabelValue({
    required this.labelWidth,
    required this.valueWidth,
  });

  final double labelWidth;
  final double valueWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFadingWidget.line(width: labelWidth, height: 11),
        const SizedBox(height: 6),
        CustomFadingWidget.line(width: valueWidth, height: 14),
      ],
    );
  }
}
