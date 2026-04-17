import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/cubits/get_finances_summary/get_finances_summary_cubit.dart';
import 'package:trader_app/features/finances/data/entities/finance_summary_entity.dart';
import 'package:trader_app/features/finances/data/models/summary/finance_summary_model.dart';
import 'package:trader_app/features/finances/presentation/loading/finance_summary_loading_card.dart';

class FinanceSummaryCard extends StatefulWidget {
  const FinanceSummaryCard({super.key, required this.isPending}); // 👈

  final bool isPending;

  @override
  State<FinanceSummaryCard> createState() => _FinanceSummaryCardState();
}

class _FinanceSummaryCardState extends State<FinanceSummaryCard> {
  FinanceSummaryEntity summary = FinanceSummaryEntity(
    amount: 0.0,
    shipments: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetFinancesSummaryCubit>(
      context,
    ).getFinancesSummary(type: 'external');
  }

  @override
  void didUpdateWidget(covariant FinanceSummaryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void getFinancesSummary(FinanceSummaryModel data) {
    String type = widget.isPending ? 'pending' : 'paid';

    switch (type) {
      case 'pending':
        FinanceSummaryEntity summary = FinanceSummaryEntity(
          amount: data.pending.amount,
          shipments: data.pending.shipments,
        );
        this.summary = summary;
        break;
      case 'paid':
        FinanceSummaryEntity summary = FinanceSummaryEntity(
          amount: data.paid.amount,
          shipments: data.paid.shipments,
        );
        this.summary = summary;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFinancesSummaryCubit, GetFinancesSummaryState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetFinancesSummarySuccess) {
          getFinancesSummary(state.summary);
        }

        if (state is GetFinancesSummaryFailure) {
          CustomSnackBar.showError(context, state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is GetFinancesSummaryLoading) {
          return FinanceSummaryLoadingCard();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إجمالي الرصيد',
                            textDirection: TextDirection.rtl,
                            style: AppStyles.styleSemiBold14(
                              context,
                            ).copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 6),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Text(
                                  summary.amount.toString(),
                                  textDirection: TextDirection.ltr,
                                  style: AppStyles.styleBold24(
                                    context,
                                  ).copyWith(color: Colors.white, fontSize: 40),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'جنيه',
                                  style: AppStyles.styleSemiBold16(
                                    context,
                                  ).copyWith(color: Colors.white60),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.25),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 14),

                  // Footer Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Current Month
                          FinanceStateColumn(
                            title: 'الشهر الحالي',
                            value: getArabicMonthYear(),
                          ),

                          const SizedBox(width: 32),

                          // Shipments Count
                          FinanceStateColumn(
                            title: 'عدد الشحنات',
                            value: '${summary.shipments} شحنة',
                          ),
                        ],
                      ),

                      // Shipping Icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FinanceStateColumn extends StatelessWidget {
  final String title;
  final String value;

  const FinanceStateColumn({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: AppStyles.styleSemiBold12(
            context,
          ).copyWith(color: Colors.white60),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          textDirection: TextDirection.rtl,
          style: AppStyles.styleBold16(context).copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

String getArabicMonthYear() {
  final now = DateTime.now();

  const arabicMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  final month = arabicMonths[now.month - 1];
  final year = now.year;

  return '$month $year';
}
