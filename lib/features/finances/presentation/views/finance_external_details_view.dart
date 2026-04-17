import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/drawer/custom_drawer.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/finances/presentation/widgets/finances_history_view_body.dart';

class FinanceExternalDetailsView extends StatefulWidget {
  const FinanceExternalDetailsView({super.key});

  @override
  State<FinanceExternalDetailsView> createState() =>
      _FinancialTransactionViewState();
}

class _FinancialTransactionViewState extends State<FinanceExternalDetailsView> {
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
      body: FinancesHistoryViewBody(onDrawerPressed: onDrawerPressed),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: 4,
        navigationKey: _bottomNavigationKey,
      ),
    );
  }
}
