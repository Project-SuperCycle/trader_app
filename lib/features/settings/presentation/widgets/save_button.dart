import 'package:flutter/material.dart';
import 'package:trader_app/core/widgets/custom_button.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onSave;

  final String title;

  const SaveButton({
    super.key,
    required this.onSave,
    this.title = 'حفظ التغييرات',
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(onPress: onSave, title: title, borderRadius: 12);
  }
}
