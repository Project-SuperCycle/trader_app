import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/collection_toggle.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/finance_summary_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/pagination_footer.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/transactions_list_section.dart';

class FinancialTransactionViewBody extends StatefulWidget {
  const FinancialTransactionViewBody({
    super.key,
    required this.onDrawerPressed,
  });

  final VoidCallback onDrawerPressed;

  @override
  State<FinancialTransactionViewBody> createState() =>
      _FinancialTransactionViewBodyState();
}

int _currentPage = 1;
int _totalPages = 10;

class _FinancialTransactionViewBodyState
    extends State<FinancialTransactionViewBody> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kGradientBackground),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drawer Button
                  GestureDetector(
                    onTap: widget.onDrawerPressed,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  // Title
                  Text(
                    'المعاملات المالية',
                    textDirection: TextDirection.rtl,
                    style: AppStyles.styleBold20(
                      context,
                    ).copyWith(color: Colors.white),
                  ),

                  // Placeholder لتوازن الـ Row
                  Flexible(child: const SizedBox(width: 40)),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    FinanceSummaryCard(status: status),
                    const SizedBox(height: 20),
                    CollectionToggle(
                      onChanged: (value) {
                        setState(() => status = value);
                      },
                    ),
                    const SizedBox(height: 24),
                    const TransactionsListSection(),
                    const SizedBox(height: 20),
                    PaginationFooter(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                      onPageChanged: (page) {
                        setState(() => _currentPage = page);
                        // هنا تعمل fetch للداتا بتاعة الصفحة دي
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
