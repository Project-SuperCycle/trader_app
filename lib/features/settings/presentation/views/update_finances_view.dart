import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_finances/update_finances_view_body.dart';

class UpdateFinancesView extends StatelessWidget {
  const UpdateFinancesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateFinancesViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
