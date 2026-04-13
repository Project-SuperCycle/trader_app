import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/drawer/custom_drawer.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/Financial_transactions/presentation/widgets/financial_transaction_view_body.dart';

class FinancialTransactionView extends StatefulWidget {
  const FinancialTransactionView({super.key});

  @override
  State<FinancialTransactionView> createState() =>
      _FinancialTransactionViewState();
}

class _FinancialTransactionViewState extends State<FinancialTransactionView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onDrawerPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: FinancialTransactionViewBody(onDrawerPressed: onDrawerPressed),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: 4,
        navigationKey: _bottomNavigationKey,
      ),
    );
  }
}