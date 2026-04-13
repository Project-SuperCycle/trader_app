import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/features/Financial_transactions/data/models/transaction_model.dart';
import 'package:trader_app/features/financial_transaction_details/presentation/widgets/collection_details_card.dart';
import 'package:trader_app/features/financial_transaction_details/presentation/widgets/export_receipt_button.dart';
import 'package:trader_app/features/financial_transaction_details/presentation/widgets/product_card.dart';
import 'package:trader_app/features/financial_transaction_details/presentation/widgets/shipment_hero_card.dart';

class FinancialTransactionDetailsViewBody extends StatelessWidget {
  const FinancialTransactionDetailsViewBody({super.key, required this.transaction});

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
                    horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),

                    // Title
                    const Text(
                      'تفاصيل المعاملة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 20,
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
                      ExportReceiptButton(transaction: transaction,),
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
