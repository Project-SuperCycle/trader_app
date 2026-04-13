import 'package:flutter/material.dart';
import 'package:trader_app/features/Contracted_Fiance/presentation/widgets/financial_collection_card.dart';
import 'package:trader_app/features/Contracted_Fiance/presentation/widgets/shipments_list_section.dart';
import 'package:trader_app/features/Financial_transactions/data/models/transaction_model.dart';

class ContractedFianceDetailsViewBody extends StatelessWidget {
  const ContractedFianceDetailsViewBody ({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //decoration: const BoxDecoration(gradient: kGradientBackground),
        color: Colors.grey.shade300,
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
                          color: Colors.green,
                          size: 18,
                        ),
                      ),
                    ),

                    // Title
                    const Text(
                      'تفاصيل المعاملة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.green,
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
                          color: Colors.green,
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
                          FinancialCollectionCard(transaction: transaction),
                          const SizedBox(height: 16),
                          ShipmentsListSection(),
                          const SizedBox(height: 16),

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
