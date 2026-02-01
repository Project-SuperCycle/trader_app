import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/models/trader_branch_model.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class TraderBranchsChart extends StatefulWidget {
  final List<TraderBranchModel> branches;

  const TraderBranchsChart({super.key, required this.branches});

  @override
  State<TraderBranchsChart> createState() => _TraderBranchsChartState();
}

class _TraderBranchsChartState extends State<TraderBranchsChart> {
  @override
  Widget build(BuildContext context) {
    final branches = widget.branches;
    if (branches.isEmpty) {
      return _buildEmptyState();
    }

    final maxVolume = branches
        .map((b) => b.deliveryVolume)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();

    final totalVolume = branches.fold(0.0, (sum, b) => sum + b.deliveryVolume);
    final avgVolume = totalVolume / branches.length;

    // FIX: لو كل الفروع قيمتها صفر نحط fallback عشان horizontalInterval متكونش صفر
    final effectiveMax = maxVolume == 0 ? 100.0 : maxVolume;
    final chartMaxY = effectiveMax * 1.3;
    final gridInterval = chartMaxY / 5;

    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ───────────────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withAlpha(200),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withAlpha(150),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أداء الفروع",
                        style: AppStyles.styleSemiBold20(
                          context,
                        ).copyWith(color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${branches.length} فرع • ${totalVolume.toInt()} كجم إجمالي",
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Chart ────────────────────────────────────────
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceEvenly,
                  maxY: chartMaxY,
                  minY: 0,

                  // ── Touch & Tooltip ─────────────────────────
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => const Color(0xFF1E1E2E),
                      tooltipRoundedRadius: 16,
                      tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      tooltipMargin: 12,
                      maxContentWidth: 200,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      direction: TooltipDirection.auto,
                      rotateAngle: 0,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final branch = branches[group.x.toInt()];
                        // FIX: لو totalVolume صفر نحط النسبة صفر عشان متحصلش division by zero
                        final percentage = totalVolume == 0
                            ? 0.0
                            : (branch.deliveryVolume / totalVolume * 100);

                        return BarTooltipItem(
                          '',
                          const TextStyle(),
                          children: [
                            TextSpan(
                              text: '${branch.branchName}\n',
                              style: AppStyles.styleBold14(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                            TextSpan(
                              text: '━━━━━━━━━━\n',
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: const Color(0xFF404060)),
                            ),
                            TextSpan(
                              text: '📦  ',
                              style: AppStyles.styleBold14(context),
                            ),
                            TextSpan(
                              text: '${branch.deliveryVolume.toInt()}',
                              style: AppStyles.styleBold16(
                                context,
                              ).copyWith(color: const Color(0xFF6C63FF)),
                            ),
                            TextSpan(
                              text: ' كجم\n',
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: const Color(0xFF9B9BAA)),
                            ),
                            TextSpan(
                              text: '📊  ',
                              style: AppStyles.styleBold14(context),
                            ),
                            TextSpan(
                              text: '${percentage.toStringAsFixed(1)}%',
                              style: AppStyles.styleBold14(
                                context,
                              ).copyWith(color: const Color(0xFF2ECC71)),
                            ),
                            TextSpan(
                              text: ' من الإجمالي',
                              style: AppStyles.styleMedium12(
                                context,
                              ).copyWith(color: const Color(0xFF9B9BAA)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // ── Borders ─────────────────────────────────
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade300, width: 2),
                      bottom: BorderSide(color: Colors.grey.shade300, width: 2),
                    ),
                  ),

                  // ── Grid ────────────────────────────────────
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: gridInterval,
                    getDrawingHorizontalLine: (value) {
                      final isAvgLine =
                          (value - avgVolume).abs() < (gridInterval * 0.01);
                      return FlLine(
                        color: isAvgLine
                            ? AppColors.primaryColor.withAlpha(150)
                            : Colors.grey.shade200,
                        strokeWidth: isAvgLine ? 2 : 0.5,
                        dashArray: isAvgLine ? [8, 4] : null,
                      );
                    },
                  ),

                  // ── Titles ──────────────────────────────────
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'الكمية (كجم)',
                          style: AppStyles.styleSemiBold12(
                            context,
                          ).copyWith(color: Colors.grey.shade700),
                        ),
                      ),
                      axisNameSize: 40,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: gridInterval,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const SizedBox();

                          String text;
                          if (value >= 1000000) {
                            text = '${(value / 1000000).toStringAsFixed(1)}M';
                          } else if (value >= 1000) {
                            text = '${(value / 1000).toStringAsFixed(1)}K';
                          } else {
                            text = value.toInt().toString();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              text,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  // ── Bar Groups ──────────────────────────────
                  barGroups: List.generate(branches.length, (index) {
                    final branch = branches[index];
                    // FIX: لو effectiveMax صفر نحط normalizedValue صفر
                    final isHighest =
                        effectiveMax > 0 &&
                        branch.deliveryVolume == maxVolume &&
                        maxVolume > 0;
                    final normalizedValue = effectiveMax > 0
                        ? branch.deliveryVolume / effectiveMax
                        : 0.0;

                    return BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                          toY: branch.deliveryVolume.toDouble(),
                          width: 20,
                          // FIX: fixed the double-dot typo (..) و fixed withAlpha values
                          gradient: LinearGradient(
                            colors: isHighest
                                ? [
                                    AppColors.primaryColor,
                                    AppColors.primaryColor.withAlpha(200),
                                    AppColors.primaryColor.withAlpha(150),
                                  ]
                                : [
                                    AppColors.primaryColor.withAlpha(
                                      (150 + (normalizedValue * 80))
                                          .toInt()
                                          .clamp(0, 255),
                                    ),
                                    AppColors.primaryColor.withAlpha(
                                      (120 + (normalizedValue * 80))
                                          .toInt()
                                          .clamp(0, 255),
                                    ),
                                    AppColors.primaryColor.withAlpha(
                                      (90 + (normalizedValue * 80))
                                          .toInt()
                                          .clamp(0, 255),
                                    ),
                                  ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                      ],
                    );
                  }),

                  // ── Extra Lines (خط المتوسط) ───────────────
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      if (avgVolume > 0)
                        HorizontalLine(
                          y: avgVolume,
                          color: AppColors.primaryColor.withAlpha(200),
                          strokeWidth: 2,
                          dashArray: [10, 5],
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 8, bottom: 4),
                            style: AppStyles.styleSemiBold12(context).copyWith(
                              fontSize: 10,
                              color: AppColors.primaryColor,
                              backgroundColor: Colors.white,
                            ),
                            labelResolver: (line) =>
                                'متوسط: ${avgVolume.toInt()}',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ─── Hint ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withAlpha(25),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.primaryColor.withAlpha(100),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "اضغط على الفرع لعرض التفاصيل الكاملة والنسبة المئوية",
                      style: AppStyles.styleSemiBold12(
                        context,
                      ).copyWith(color: Colors.grey.shade700),
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

  // ─── Empty State ────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade50, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20),
                ],
              ),
              child: Icon(
                Icons.insert_chart_outlined_rounded,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "لا توجد بيانات للفروع",
              style: AppStyles.styleSemiBold16(
                context,
              ).copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
