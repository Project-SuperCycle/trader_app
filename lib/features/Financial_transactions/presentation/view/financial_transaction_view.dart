import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/financial_transaction_view_body.dart';

class FinancialTransactionView extends StatelessWidget {
  const FinancialTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FinancialTransactionViewBody(onDrawerPressed: () {  },),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 4),
    );
  }
}
