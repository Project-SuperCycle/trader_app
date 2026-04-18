import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';

class ExportReceiptButton extends StatelessWidget {
  const ExportReceiptButton({super.key, required this.paymentId});

  final String paymentId;

  Future<void> _exportPdf(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: kGradientButton,
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        child: ElevatedButton(
          onPressed: () => _exportPdf(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonBorderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.picture_as_pdf_outlined,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                'تصدير كـ PDF',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
