import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/confirm_change/confirm_email_change_view_body.dart';

class ConfirmEmailChangeView extends StatelessWidget {
  const ConfirmEmailChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmEmailChangeViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
