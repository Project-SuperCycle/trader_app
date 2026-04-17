import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class FinanceInternalDetailsView extends StatefulWidget {
  const FinanceInternalDetailsView({super.key});

  @override
  State<FinanceInternalDetailsView> createState() =>
      _FinancialTransactionViewState();
}

class _FinancialTransactionViewState extends State<FinanceInternalDetailsView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onDrawerPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
