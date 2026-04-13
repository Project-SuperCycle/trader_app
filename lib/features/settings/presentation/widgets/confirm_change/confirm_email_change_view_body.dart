import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/widgets/shipment/shipment_logo.dart';
import 'package:trader_app/features/settings/presentation/widgets/confirm_change/confirm_email_change_widget.dart';

class ConfirmEmailChangeViewBody extends StatelessWidget {
  const ConfirmEmailChangeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: kGradientBackground),
      child: Column(
        children: [
          Column(children: [const SizedBox(height: 30), const ShipmentLogo()]),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(32),
                  child: ConfirmEmailChangeWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
