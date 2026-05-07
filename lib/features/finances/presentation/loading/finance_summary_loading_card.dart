import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';

class FinanceSummaryLoadingCard extends StatelessWidget {
  const FinanceSummaryLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header Row ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Amount placeholders
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFadingWidget.line(width: 100, height: 14),
                      const SizedBox(height: 10),
                      CustomFadingWidget.line(width: 160, height: 36),
                    ],
                  ),

                  // Icon placeholder
                  CustomFadingWidget.box(
                    width: 48,
                    height: 48,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(
                color: Colors.white.withValues(alpha: 0.25),
                thickness: 0.5,
              ),
              const SizedBox(height: 14),

              // ── Footer Row ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Current Month placeholder
                      _LoadingStateColumn(),

                      const SizedBox(width: 32),

                      // Shipments Count placeholder
                      _LoadingStateColumn(),
                    ],
                  ),

                  // Shipping icon placeholder
                  CustomFadingWidget.box(
                    width: 44,
                    height: 44,
                    borderRadius: BorderRadius.circular(12),
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

// ── نسخة loading من FinanceStateColumn ──────────────────────────────────────
class _LoadingStateColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFadingWidget.line(width: 72, height: 12),
        const SizedBox(height: 6),
        CustomFadingWidget.line(width: 88, height: 16),
      ],
    );
  }
}
