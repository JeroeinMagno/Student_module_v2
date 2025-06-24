import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../common/app_components.dart';

class HorizontalBarChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ChartDataModel> data;
  final Color? barColor;
  final double? height;

  const HorizontalBarChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    this.barColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: height ?? 200.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: data.map((e) => e.value).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: theme.colorScheme.surface,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${data[group.x.toInt()].label}\n${rod.toY.toInt()}',
                        theme.textTheme.bodySmall ?? const TextStyle(),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Text(
                            data[value.toInt()].label,
                            style: theme.textTheme.bodySmall,
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 40.h,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: data.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value,
                        color: barColor ?? AppTheme.chartColors[entry.key % AppTheme.chartColors.length],
                        width: 20.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ],
                  );
                }).toList(),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadialStackedChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<PieChartDataModel> data;
  final double? size;

  const RadialStackedChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: size ?? 200.h,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40.w,
                sections: data.asMap().entries.map((entry) {
                  final color = AppTheme.chartColors[entry.key % AppTheme.chartColors.length];
                  return PieChartSectionData(
                    color: color,
                    value: entry.value.value,
                    title: '${entry.value.percentage.toStringAsFixed(1)}%',
                    radius: 60.w,
                    titleStyle: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                  enabled: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),          ...data.asMap().entries.map((entry) {
            final color = AppTheme.chartColors[entry.key % AppTheme.chartColors.length];
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    entry.value.label,
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    '${entry.value.percentage.toStringAsFixed(1)}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class LinearChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<LineChartDataModel> data;
  final Color? lineColor;
  final double? height;

  const LinearChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    this.lineColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: height ?? 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Text(
                            data[value.toInt()].label,
                            style: theme.textTheme.bodySmall,
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 40.h,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: theme.textTheme.bodySmall,
                        );
                      },
                      reservedSize: 40.w,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.value);
                    }).toList(),
                    isCurved: true,
                    color: lineColor ?? AppTheme.chartColors[0],
                    barWidth: 3.w,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4.w,
                          color: lineColor ?? AppTheme.chartColors[0],
                          strokeWidth: 2.w,
                          strokeColor: theme.colorScheme.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: (lineColor ?? AppTheme.chartColors[0]).withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: theme.colorScheme.surface,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          '${data[touchedSpot.x.toInt()].label}\n${touchedSpot.y.toInt()}',
                          theme.textTheme.bodySmall ?? const TextStyle(),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String progressLabel;
  final Color? progressColor;

  const ProgressChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressLabel,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 40.h),
          Center(
            child: SizedBox(
              width: 120.w,
              height: 120.h,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8.w,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressColor ?? AppTheme.primaryGreen,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  progressLabel,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data models for charts
class ChartDataModel {
  final String label;
  final double value;

  ChartDataModel({required this.label, required this.value});
}

class PieChartDataModel {
  final String label;
  final double value;
  final double percentage;

  PieChartDataModel({
    required this.label, 
    required this.value, 
    required this.percentage,
  });
}

class LineChartDataModel {
  final String label;
  final double value;

  LineChartDataModel({required this.label, required this.value});
}
