import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/features/Financial_transactions/data/models/transaction_model.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/transaction_card.dart';

// ======== Dummy Data ========
final List<TransactionModel> dummyTransactions = [
  const TransactionModel(
    id: 'U22b8',
    date: '20 مايو 2026 • 10:30 ص',
    isPending: true,
    totalWeight: 10.5,
    paymentMethod: 'بنكي',
    paymentMethodIcon: '🏦',
    totalAmount: 50000,
  ),
  const TransactionModel(
    id: 'U24c9',
    date: '18 مايو 2026 • 02:15 م',
    isPending: false,
    totalWeight: 7.2,
    paymentMethod: 'نقدي',
    paymentMethodIcon: '💵',
    totalAmount: 35250,
  ),
  const TransactionModel(
    id: 'U31d4',
    date: '15 مايو 2026 • 09:00 ص',
    isPending: false,
    totalWeight: 5.8,
    paymentMethod: 'بنكي',
    paymentMethodIcon: '🏦',
    totalAmount: 28000,
  ),
];

// ======== Transactions List Section ========
class TransactionsListSection extends StatelessWidget {
  const TransactionsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Section Header ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'أحدث المعاملات',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'تصفية الكل',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ── Cards List ──
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dummyTransactions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              TransactionCard(transaction: dummyTransactions[index]),
        ),
      ],
    );
  }
}