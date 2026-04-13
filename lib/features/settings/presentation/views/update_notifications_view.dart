import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_notifications/update_notifications_view_body.dart';

class UpdateNotificationsView extends StatelessWidget {
  const UpdateNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateNotificationsViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
