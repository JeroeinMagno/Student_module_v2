import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants/constants.dart';

/// Widget displaying GWA trend chart over semesters
class GWATrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> gradeTrends;

  const GWATrendChart({
    super.key,
    required this.gradeTrends,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate improvement percentage
    final firstGwa = gradeTrends.first['gwa'] as double;
    final lastGwa = gradeTrends.last['gwa'] as double;
    final improvement = ((firstGwa - lastGwa) / firstGwa * 100).abs();
    final isImproving = lastGwa <= firstGwa; // Lower GWA is better
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        border: Border.all(
          color: const Color(0xFF2A3441),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GWA Trend',
                    style: AppTextStyles.heading6.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Across all semesters',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSM,
                  vertical: AppDimensions.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isImproving ? Icons.trending_up : Icons.trending_down,
                      color: isImproving ? const Color(0xFF22C55E) : Colors.red,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${isImproving ? 'Improved' : 'Declined'} by ${improvement.toStringAsFixed(2)}%',
                      style: AppTextStyles.caption.copyWith(
                        color: isImproving ? const Color(0xFF22C55E) : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingLG),
          SizedBox(
            height: 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 0.5,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF2A3441),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40.w,
                      interval: 0.5,
                      getTitlesWidget: (value, meta) {
                        // Invert the displayed value so it shows correct GWA (1.0 at top, 3.0 at bottom)
                        final actualGwa = 4.0 - value;
                        return Text(
                          actualGwa.toStringAsFixed(1),
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50.h,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < gradeTrends.length) {
                          final semester = gradeTrends[index]['semester'];
                          // Split the semester name for better display
                          final parts = semester.split(' ');
                          if (parts.length >= 3) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${parts[0]} ${parts[1]}\n${parts[2]} ${parts.length > 3 ? parts[3] : ''}',
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return Text(
                            semester,
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: gradeTrends.asMap().entries.map((entry) {
                      // Invert the GWA values so 1.0 appears at top and 3.0 at bottom
                      final invertedGwa = 4.0 - entry.value['gwa'].toDouble();
                      return FlSpot(entry.key.toDouble(), invertedGwa);
                    }).toList(),
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: const Color(0xFF3B82F6),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: const Color(0xFF3B82F6),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                minY: 1.0,
                maxY: 3.0,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.paddingMD),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: const Color(0xFF22C55E),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'GWA improving',
                style: AppTextStyles.bodySmall.copyWith(
                  color: const Color(0xFF22C55E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Lower GWA means higher academic standing',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
