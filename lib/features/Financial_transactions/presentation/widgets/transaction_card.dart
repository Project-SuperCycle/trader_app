import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/features/Financial_transactions/data/models/transaction_model.dart';
import 'package:trader_app/features/financial_transaction_details/presentation/widgets/financial_transaction_details_view_body.dart';

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

// ======== Transaction Card ========
class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final isPending = transaction.isPending;

    return
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FinancialTransactionDetailsViewBody(
              transaction: transaction,
            ),
          ),
        ),
        child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3BC577).withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              // ── Row 1: Status + ID + Icon ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
        
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3BC577).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isPending
                          ? Icons.receipt_long_outlined
                          : Icons.check_circle_outline_rounded,
                      color: const Color(0xFF3BC577),
                      size: 22,
                    ),
                  ),
        
                  const SizedBox(width: 10),
        
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.id,
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          transaction.date,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(width: 10),
        
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPending
                          ? Colors.orange.withOpacity(0.12)
                          : const Color(0xFF3BC577).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPending ? 'منتظر' : 'تم التحصيل',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: isPending
                            ? Colors.orange.shade700
                            : const Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        
                ],
              ),
        
              const SizedBox(height: 12),
              Divider(color: Colors.grey.shade200, thickness: 0.5),
              const SizedBox(height: 10),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Payment Method
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طريقة التحصيل',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              transaction.paymentMethodIcon,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              transaction.paymentMethod,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        
                  // Total Weight
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الوزن الإجمالي',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'طن',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${transaction.totalWeight}',
                            style: const TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        
              const SizedBox(height: 10),
        
              // ── Row 3: Total Amount ──
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF3BC577).withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF3BC577).withOpacity(0.15),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          transaction.totalAmount
                              .toStringAsFixed(0)
                              .replaceAllMapped(
                            RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                (m) => ',',
                          ),
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'جنيه',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'إجمالي المبلغ',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
            ),
      );
  }
}