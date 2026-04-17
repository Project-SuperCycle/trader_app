import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/drawer/custom_drawer.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/finances/presentation/widgets/finance_internal_details_view_body.dart';

class FinanceInternalDetailsView extends StatefulWidget {
  const FinanceInternalDetailsView({super.key});

  @override
  State<FinanceInternalDetailsView> createState() =>
      _FinancialTransactionViewState();
}

class _FinancialTransactionViewState extends State<FinanceInternalDetailsView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: FinanceInternalDetailsViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: 4,
        navigationKey: _bottomNavigationKey,
      ),
    );
  }
}
