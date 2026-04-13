import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback? onCancel;

  const CancelButton({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        backgroundColor: Colors.grey.withValues(alpha: 0.3),
      ),
      onPressed: onCancel,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text("إلغاء", style: AppStyles.styleBold16(context)),
      ),
    );
  }
}
