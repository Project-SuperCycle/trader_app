import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
