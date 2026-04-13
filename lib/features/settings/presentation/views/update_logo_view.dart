import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_logo/update_logo_view_body.dart';

class UpdateLogoView extends StatelessWidget {
  const UpdateLogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateLogoViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
