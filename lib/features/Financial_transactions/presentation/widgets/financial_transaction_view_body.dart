import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/collection_toggle.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/financial_card.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/pagination_footer.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/transactions_list_section.dart';

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
                  const Text(
                    'المعاملات المالية',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Placeholder لتوازن الـ Row
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: [
                      FinancialCard(),
                      const SizedBox(height: 20),
                      CollectionToggle(
                        onChanged: (isPending) {
                          // isPending = true  → منتظر التحصيل
                          // isPending = false → تم التحصيل
                        },
                      ),
                      const SizedBox(height: 20),
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
                  )
              ),
            ),


          ],
        ),
      ),
    );
  }
}