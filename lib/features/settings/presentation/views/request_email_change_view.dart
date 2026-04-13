import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/request_change/request_email_change_view_body.dart';

class RequestEmailChangeView extends StatelessWidget {
  const RequestEmailChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestEmailChangeViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
