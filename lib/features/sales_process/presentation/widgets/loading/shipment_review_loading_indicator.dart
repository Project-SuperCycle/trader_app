import 'package:flutter/material.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';
import 'package:trader_app/core/utils/app_colors.dart';

class ShipmentReviewLoadingIndicator extends StatelessWidget {
  const ShipmentReviewLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    final isMedium = size.width >= 360 && size.width < 600;

    final dialogWidth = size.width >= 600
        ? 700.0
        : isMedium
        ? size.width * 0.92
        : size.width * 0.95;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 12,
        vertical: size.height < 700 ? 16 : 24,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(maxHeight: size.height * 0.9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ======== Header ========
              _buildHeaderShimmer(isSmall),

              // ======== Scrollable Content ========
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(isSmall ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ----- Delivery time section -----
                      _buildDeliveryTimeSectionShimmer(),

                      const SizedBox(height: 16),

                      // ----- Products header -----
                      _buildProductsHeaderShimmer(),

                      const SizedBox(height: 16),

                      // ----- Product cards -----
                      _buildProductCardShimmer(
                        index: 0,
                        isSmall: isSmall,
                        isMedium: isMedium,
                      ),

                      // ----- Address section -----
                      _buildAddressSectionShimmer(),
                    ],
                  ),
                ),
              ),

              // ======== Footer ========
              _buildFooterShimmer(isSmall),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeaderShimmer(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: isSmall ? 16 : 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withAlpha(400),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Row(
        children: [
          // Close button placeholder
          CustomFadingWidget.box(
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(12),
          ),

          // Title placeholder
          Expanded(
            child: Center(
              child: CustomFadingWidget(
                duration: const Duration(milliseconds: 920),
                child: CustomFadingWidget.line(
                  width: 160,
                  height: 18,
                  radius: 6,
                ),
              ),
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ── Delivery Time Section ─────────────────────────────────────────────────
  Widget _buildDeliveryTimeSectionShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          // Clock icon container
          CustomFadingWidget.box(
            width: 44,
            height: 44,
            borderRadius: BorderRadius.circular(12),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFadingWidget.line(width: 80, height: 13, radius: 4),
                const SizedBox(height: 6),
                CustomFadingWidget(
                  duration: const Duration(milliseconds: 950),
                  child: CustomFadingWidget.line(
                    width: 160,
                    height: 16,
                    radius: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Products Header ───────────────────────────────────────────────────────
  Widget _buildProductsHeaderShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withAlpha(50),
            AppColors.primaryColor.withAlpha(25),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          CustomFadingWidget.box(
            width: 36,
            height: 36,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(width: 12),

          // Title
          CustomFadingWidget(
            duration: const Duration(milliseconds: 930),
            child: CustomFadingWidget.line(width: 100, height: 16, radius: 5),
          ),

          const SizedBox(width: 8),

          // Count badge
          CustomFadingWidget(
            duration: const Duration(milliseconds: 960),
            child: CustomFadingWidget.box(
              width: 30,
              height: 26,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  // ── Product Card ──────────────────────────────────────────────────────────
  Widget _buildProductCardShimmer({
    required int index,
    required bool isSmall,
    required bool isMedium,
  }) {
    final fieldWidth = isSmall
        ? 100.0
        : isMedium
        ? 120.0
        : 140.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ----- Card header: number badge + name + delete -----
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Number badge
                CustomFadingWidget(
                  duration: Duration(milliseconds: 900 + (index * 80)),
                  child: CustomFadingWidget.box(
                    width: 40,
                    height: 40,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                const SizedBox(width: 12),

                // Item name
                Expanded(
                  child: CustomFadingWidget(
                    duration: Duration(milliseconds: 930 + (index * 80)),
                    child: CustomFadingWidget.line(height: 16, radius: 5),
                  ),
                ),

                const SizedBox(width: 12),

                // Delete button
                CustomFadingWidget(
                  duration: Duration(milliseconds: 950 + (index * 80)),
                  child: CustomFadingWidget.box(
                    width: 38,
                    height: 38,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),

          // ----- Card body: qty + unit + price -----
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(3, (rowIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon + label
                      Row(
                        children: [
                          CustomFadingWidget(
                            duration: Duration(
                              milliseconds:
                                  960 + (index * 80) + (rowIndex * 40),
                            ),
                            child: CustomFadingWidget.box(
                              width: 36,
                              height: 36,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CustomFadingWidget(
                            duration: Duration(
                              milliseconds:
                                  980 + (index * 80) + (rowIndex * 40),
                            ),
                            child: CustomFadingWidget.line(
                              width: 40,
                              height: 14,
                              radius: 4,
                            ),
                          ),
                        ],
                      ),

                      // Value field
                      CustomFadingWidget(
                        duration: Duration(
                          milliseconds: 1000 + (index * 80) + (rowIndex * 40),
                        ),
                        child: CustomFadingWidget.box(
                          width: fieldWidth,
                          height: 36,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ── Address Section ───────────────────────────────────────────────────────
  Widget _buildAddressSectionShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.orange.shade100],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomFadingWidget.box(
                width: 44,
                height: 44,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(width: 12),
              CustomFadingWidget(
                duration: const Duration(milliseconds: 940),
                child: CustomFadingWidget.line(
                  width: 100,
                  height: 16,
                  radius: 5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Address text box
          CustomFadingWidget(
            duration: const Duration(milliseconds: 970),
            child: CustomFadingWidget.box(
              height: 60,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────
  Widget _buildFooterShimmer(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          // Confirm button placeholder
          Expanded(
            flex: 1,
            child: CustomFadingWidget(
              duration: const Duration(milliseconds: 900),
              child: CustomFadingWidget.box(
                height: 52,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Cancel button placeholder
          Expanded(
            child: CustomFadingWidget(
              duration: const Duration(milliseconds: 940),
              child: CustomFadingWidget.box(
                height: 52,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
