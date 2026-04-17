import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class AlternateActionLink extends StatelessWidget {
  const AlternateActionLink({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("الايميل غير صحيح؟", style: AppStyles.styleRegular16(context)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'إرسال إلى إيميل مختلف',
              style: AppStyles.styleSemiBold16(context).copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
