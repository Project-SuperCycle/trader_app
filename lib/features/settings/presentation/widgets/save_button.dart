import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/custom_button.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onSave;

  const SaveButton({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPress: onSave,
      title: 'حفظ التغييرات',
      borderRadius: 12,
    );
  }
}
