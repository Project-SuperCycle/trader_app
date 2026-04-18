import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';

class FinanceExternalDetailsLoading extends StatelessWidget {
  const FinanceExternalDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ShipmentHeroLoadingCard(),
        const SizedBox(height: 16),
        _ProductsListLoadingSection(),
        const SizedBox(height: 16),
        _CollectionDetailsLoadingCard(),
        const SizedBox(height: 20),
        _ExportReceiptLoadingButton(),
      ],
    );
  }
}

// ── ShipmentHeroCard skeleton ────────────────────────────────────────────────

class _ShipmentHeroLoadingCard extends StatelessWidget {
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
          children: [
            // Row 1: Shipment ID + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFadingWidget.line(width: 72, height: 11),
                    const SizedBox(height: 6),
                    CustomFadingWidget.line(width: 130, height: 24),
                  ],
                ),
                CustomFadingWidget.box(
                  width: 120,
                  height: 34,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Row 2: Weight + Payment Method
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
                        CustomFadingWidget.line(width: 72, height: 11),
                        const SizedBox(height: 6),
                        CustomFadingWidget.line(width: 96, height: 22),
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
                        CustomFadingWidget.line(width: 64, height: 11),
                        const SizedBox(height: 6),
                        CustomFadingWidget.line(width: 88, height: 22),
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

// ── ProductsListSection skeleton ─────────────────────────────────────────────

class _ProductsListLoadingSection extends StatelessWidget {
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
              CustomFadingWidget.line(width: 110, height: 16),
              CustomFadingWidget.line(width: 64, height: 14),
            ],
          ),
        ),

        const SizedBox(height: 14),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, __) => _ProductLoadingCard(),
        ),
      ],
    );
  }
}

class _ProductLoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3BC577).withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon placeholder
          CustomFadingWidget.box(
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 12),
          // Name + sub
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFadingWidget.line(width: 100, height: 14),
                const SizedBox(height: 6),
                CustomFadingWidget.line(width: 70, height: 11),
              ],
            ),
          ),
          // Value
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomFadingWidget.line(width: 72, height: 16),
              const SizedBox(height: 6),
              CustomFadingWidget.line(width: 48, height: 11),
            ],
          ),
        ],
      ),
    );
  }
}

// ── CollectionDetailsCard skeleton ───────────────────────────────────────────

class _CollectionDetailsLoadingCard extends StatelessWidget {
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
            // Header: icon + title + status badge
            Row(
              children: [
                CustomFadingWidget.box(
                  width: 32,
                  height: 32,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 8),
                CustomFadingWidget.line(width: 96, height: 14),
                const Spacer(),
                CustomFadingWidget.box(
                  width: 88,
                  height: 26,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Amount + Payment Method container
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFadingWidget.line(width: 110, height: 11),
                      const SizedBox(height: 6),
                      CustomFadingWidget.line(width: 140, height: 30),
                      const SizedBox(height: 4),
                      CustomFadingWidget.line(width: 72, height: 11),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFadingWidget.line(width: 80, height: 11),
                      const SizedBox(height: 6),
                      CustomFadingWidget.line(width: 64, height: 16),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Images Row
            Row(
              children: [
                Expanded(
                  child: CustomFadingWidget.box(
                    height: 100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomFadingWidget.box(
                    height: 100,
                    borderRadius: BorderRadius.circular(10),
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

// ── ExportReceiptButton skeleton ─────────────────────────────────────────────

class _ExportReceiptLoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget.box(
      width: double.infinity,
      height: 52,
      borderRadius: BorderRadius.circular(kButtonBorderRadius),
    );
  }
}
