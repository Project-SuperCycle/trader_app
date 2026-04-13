import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:trader_app/features/settings/presentation/widgets/update_profile/update_profile_view_body.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateProfileViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(currentIndex: 2),
    );
  }
}
