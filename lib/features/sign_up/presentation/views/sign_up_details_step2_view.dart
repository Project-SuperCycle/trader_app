import 'package:flutter/material.dart';
import 'package:trader_app/features/sign_up/data/models/business_information_model.dart';
import 'package:trader_app/features/sign_up/presentation/widgets/sign_up_details_step2_view_body.dart';

class SignUpDetailsStep2View extends StatelessWidget {
  final BusinessInformationModel businessInfo;

  const SignUpDetailsStep2View({super.key, required this.businessInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpDetailsStep2ViewBody(businessInfo: businessInfo),
    );
  }
}
