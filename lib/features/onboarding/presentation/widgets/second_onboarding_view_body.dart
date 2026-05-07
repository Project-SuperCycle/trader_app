import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_assets.dart';
import 'package:trader_app/core/utils/app_colors.dart' show AppColors;
import 'package:trader_app/core/utils/app_styles.dart' show AppStyles;
import 'package:trader_app/features/onboarding/presentation/widgets/partial_circle_border_painter.dart';
import 'package:trader_app/generated/l10n.dart' show S;

class SecondOnboardingViewBody extends StatelessWidget {
  const SecondOnboardingViewBody({super.key});

  Future<void> _skipOnboarding(BuildContext context) async {
    await StorageServices.storeData("hasSeenOnboarding", "true");
    await StorageServices.storeData("isUser", "true");

    if (context.mounted) {
      context.go(EndPoints.homeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => _skipOnboarding(context),
                child: Text(
                  S.of(context).skip,
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: AppColors.primary),
                ),
              ),
            ),
          ),
          Text(
            "بيع",
            style: AppStyles.styleBold24(
              context,
            ).copyWith(fontSize: 36, color: AppColors.primary),
          ),
          const SizedBox(height: 30),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              child: Image.asset(AppAssets.onboarding2, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "عرض الكرتون اللي عندك بخطوات بسيطة، وحدد الكمية والمكان",
              style: AppStyles.styleSemiBold18(
                context,
              ).copyWith(color: AppColors.primary, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          CustomPaint(
            painter: PartialCircleBorderPainter(
              color: AppColors.primary,
              strokeWidth: 4,
              percentage: 0.50,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  context.push(EndPoints.thirdOnboardingView);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
