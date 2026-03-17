import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_fading_widget.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/features/environment/data/cubits/eco_cubit/eco_cubit.dart';

class EnvironmentLoadingIndicator extends StatelessWidget {
  const EnvironmentLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EcoCubit, EcoState>(
        listener: (context, state) {
          if (state is GetEcoDataSuccess) {
            (state.ecoInfoModel.isEcoParticiapant == true)
                ? GoRouter.of(
                    context,
                  ).pushReplacement(EndPoints.environmentalImpactView)
                : GoRouter.of(
                    context,
                  ).pushReplacement(EndPoints.environmentalDefaultView);
          }
        },
        child: CustomScrollView(
          slivers: [
            // ======== Header Shimmer ========
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: kGradientContainer,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ----- Nav row: icon+title col + back button -----
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Eco icon container
                                CustomFadingWidget.box(
                                  width: 48,
                                  height: 48,
                                  borderRadius: BorderRadius.circular(12),
                                ),

                                const SizedBox(width: 12),

                                // Title + subtitle
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomFadingWidget(
                                      duration: const Duration(
                                        milliseconds: 900,
                                      ),
                                      child: CustomFadingWidget.line(
                                        width: 110,
                                        height: 22,
                                        radius: 6,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomFadingWidget(
                                      duration: const Duration(
                                        milliseconds: 950,
                                      ),
                                      child: CustomFadingWidget.line(
                                        width: 130,
                                        height: 14,
                                        radius: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Back button placeholder
                            CustomFadingWidget.circle(radius: 16),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ----- Stats container -----
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(20),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              // Stat 1
                              Expanded(child: _buildStatShimmer(delay: 0)),

                              const SizedBox(width: 16),

                              // Stat 2
                              Expanded(child: _buildStatShimmer(delay: 120)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ======== TabBar + Content Shimmer ========
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // ----- Tab bar shimmer -----
                  _buildTabBarShimmer(),

                  // ----- Tab content shimmer -----
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Big card placeholder
                          CustomFadingWidget.box(
                            height: 160,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          const SizedBox(height: 16),

                          // Two cards row
                          Row(
                            children: [
                              Expanded(
                                child: CustomFadingWidget(
                                  duration: const Duration(milliseconds: 950),
                                  child: CustomFadingWidget.box(
                                    height: 100,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomFadingWidget(
                                  duration: const Duration(milliseconds: 1000),
                                  child: CustomFadingWidget.box(
                                    height: 100,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // List items
                          ...List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CustomFadingWidget(
                                duration: Duration(
                                  milliseconds: 1000 + (index * 80),
                                ),
                                child: CustomFadingWidget.box(
                                  height: 70,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stat shimmer ──────────────────────────────────────────────────────────
  Widget _buildStatShimmer({required int delay}) {
    return Column(
      children: [
        CustomFadingWidget(
          duration: Duration(milliseconds: 900 + delay),
          child: CustomFadingWidget.line(width: 50, height: 24, radius: 6),
        ),
        const SizedBox(height: 8),
        CustomFadingWidget(
          duration: Duration(milliseconds: 950 + delay),
          child: CustomFadingWidget.line(width: 80, height: 12, radius: 4),
        ),
      ],
    );
  }

  // ── TabBar shimmer ────────────────────────────────────────────────────────
  Widget _buildTabBarShimmer() {
    // نفس الـ 5 tabs بنفس الأحجام التقريبية
    const tabWidths = [90.0, 100.0, 72.0, 76.0, 68.0];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabWidths.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomFadingWidget(
                duration: Duration(milliseconds: 880 + (index * 60)),
                child: CustomFadingWidget.box(
                  width: tabWidths[index],
                  height: 36,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
