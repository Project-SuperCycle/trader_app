import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class EnvironmentalImpactInfoCard extends StatelessWidget {
  const EnvironmentalImpactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: kGradientContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.favorite, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'هل تعلم؟',
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'كل طن من الورق المعاد تدويره ينقذ 17 شجرة، يوفر 26,500 لتر ماء، ويقلل انبعاثات الكربون بمقدار 2.5 طن. أنت تصنع فرقًا حقيقيًا! 🌱',
                  style: AppStyles.styleSemiBold14(
                    context,
                  ).copyWith(color: Color(0xFFD1FAE5), height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
