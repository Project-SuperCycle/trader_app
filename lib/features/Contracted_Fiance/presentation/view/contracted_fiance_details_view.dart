import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/drawer/custom_drawer.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/Contracted_Fiance/presentation/widgets/contracted_fiance_details_view_body.dart';

class ContractedFianceDetailsView extends StatefulWidget {
  const ContractedFianceDetailsView({super.key});

  @override
  State<ContractedFianceDetailsView> createState() =>
      _FinancialTransactionViewState();
}

class _FinancialTransactionViewState extends State<ContractedFianceDetailsView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onDrawerPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}