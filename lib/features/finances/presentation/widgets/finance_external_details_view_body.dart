import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/entities/transaction_model.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/collection_details_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/export_receipt_button.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/product_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/products_list_section.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/shipment_hero_card.dart';

class FinanceExternalDetailsViewBody extends StatelessWidget {
  const FinanceExternalDetailsViewBody({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      'تفاصيل المعاملة',
                      textDirection: TextDirection.rtl,
                      style: AppStyles.styleBold20(
                        context,
                      ).copyWith(color: Colors.white),
                    ),

                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Content ──
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ShipmentHeroCard(transaction: transaction),
                      const SizedBox(height: 16),
                      ProductsListSection(products: dummyProducts),
                      const SizedBox(height: 16),
                      CollectionDetailsCard(transaction: transaction),
                      const SizedBox(height: 20),
                      ExportReceiptButton(transaction: transaction),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
