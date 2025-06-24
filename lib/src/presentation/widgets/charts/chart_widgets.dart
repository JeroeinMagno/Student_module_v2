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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 300.w;
          final chartHeight = height ?? (isSmallScreen ? 180.h : 200.h);
          final barWidth = isSmallScreen ? 14.w : 20.w;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: isSmallScreen ? 16.sp : 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: isSmallScreen ? 12.sp : 14.sp,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: chartHeight,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: data.isNotEmpty 
                        ? data.map((e) => e.value).reduce((a, b) => a > b ? a : b) * 1.2 
                        : 100,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: theme.colorScheme.surface,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          if (group.x.toInt() < data.length) {
                            return BarTooltipItem(
                              '${data[group.x.toInt()].label}\n${rod.toY.toInt()}',
                              TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 12.sp,
                              ),
                            );
                          }
                          return null;
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
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  data[value.toInt()].label,
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: isSmallScreen ? 10.sp : 12.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }
                            return const Text('');
                          },
                          reservedSize: isSmallScreen ? 32.h : 40.h,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: data.isNotEmpty 
                        ? data.asMap().entries.map((entry) {
                            return BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value.value,
                                  color: barColor ?? AppTheme.chartColors[entry.key % AppTheme.chartColors.length],
                                  width: barWidth,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ],
                            );
                          }).toList()
                        : [],
                    gridData: const FlGridData(show: false),
                  ),
                ),
              ),
            ],
          );
        },
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 200.w;
          final chartSize = size ?? (isSmallScreen ? 120.w : 160.w);
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: isSmallScreen ? 16.sp : 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: isSmallScreen ? 12.sp : 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: SizedBox(
                  height: chartSize,
                  width: chartSize,
                  child: PieChart(
                    PieChartData(
                      sections: data.asMap().entries.map((entry) {
                        return PieChartSectionData(
                          color: entry.value.color,
                          value: entry.value.value,
                          title: '${entry.value.percentage.toStringAsFixed(1)}%',
                          radius: isSmallScreen ? 40.r : 50.r,
                          titleStyle: TextStyle(
                            fontSize: isSmallScreen ? 10.sp : 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: isSmallScreen ? 20.r : 30.r,
                    ),
                  ),
                ),
              ),
              if (data.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  children: data.map((item) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: item.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 10.sp : 12.sp,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<LineChartDataModel> data;
  final double? height;

  const LineChartWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 300.w;
          final chartHeight = height ?? (isSmallScreen ? 160.h : 200.h);
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: isSmallScreen ? 16.sp : 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: isSmallScreen ? 12.sp : 14.sp,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: chartHeight,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: theme.dividerColor.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: theme.dividerColor.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
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
                          reservedSize: isSmallScreen ? 28.h : 32.h,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: isSmallScreen ? 10.sp : 12.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: isSmallScreen ? 32.w : 40.w,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: isSmallScreen ? 10.sp : 12.sp,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    lineBarsData: data.map((lineData) {
                      return LineChartBarData(
                        spots: lineData.points,
                        isCurved: true,
                        color: lineData.color,
                        barWidth: isSmallScreen ? 2 : 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: !isSmallScreen,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 3,
                              color: lineData.color,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: lineData.color.withOpacity(0.1),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Data Models
class ChartDataModel {
  final String label;
  final double value;
  final Color? color;

  ChartDataModel({
    required this.label,
    required this.value,
    this.color,
  });
}

class PieChartDataModel {
  final String label;
  final double value;
  final double percentage;
  final Color color;

  PieChartDataModel({
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });
}

class LineChartDataModel {
  final String label;
  final List<FlSpot> points;
  final Color color;

  LineChartDataModel({
    required this.label,
    required this.points,
    required this.color,
  });
}
