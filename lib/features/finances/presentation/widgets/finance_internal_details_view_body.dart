import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/entities/transaction_model.dart';
import 'package:trader_app/features/finances/presentation/widgets/internal/financial_collection_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/internal/shipments_list_section.dart';

class FinanceInternalDetailsViewBody extends StatelessWidget {
  const FinanceInternalDetailsViewBody({super.key, required this.transaction});

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
