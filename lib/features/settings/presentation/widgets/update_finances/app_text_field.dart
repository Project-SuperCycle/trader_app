import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextDirection inputDirection;
  final TextInputType keyboardType;

  const AppTextField({
    required this.controller,
    required this.hint,
    this.inputDirection = TextDirection.rtl,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: inputDirection,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: inputDirection == TextDirection.ltr
            ? TextAlign.left
            : TextAlign.right,
        style: AppStyles.styleRegular14(context),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1B7A4A), width: 0.5),
          ),
        ),
      ),
    );
  }
}
