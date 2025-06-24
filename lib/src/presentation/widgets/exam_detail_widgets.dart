import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_providers.dart';

class ExamTab extends ConsumerStatefulWidget {
  final String courseId;

  const ExamTab({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<ExamTab> createState() => _ExamTabState();
}

class _ExamTabState extends ConsumerState<ExamTab> {
  String selectedExam = 'Midterm';

  @override
  Widget build(BuildContext context) {
    final examsAsync = ref.watch(allExamsProvider);

    return examsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.w,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'Error loading exams',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      data: (exams) {
        if (exams.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.quiz_outlined,
                  size: 64.w,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No exams found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exam Selector
              ExamSelector(
                selectedExam: selectedExam,
                onExamChanged: (exam) => setState(() => selectedExam = exam),
              ),
              SizedBox(height: 24.h),

              // Charts Section
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 1,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                children: [
                  ExamCriteriaChart(selectedExam: selectedExam),
                  ExamPerformanceChart(selectedExam: selectedExam),
                ],
              ),
              SizedBox(height: 24.h),

              // Insights Section
              ExamInsights(selectedExam: selectedExam),
            ],
          ),
        );
      },
    );
  }
}

class ExamSelector extends StatelessWidget {
  final String selectedExam;
  final ValueChanged<String> onExamChanged;

  const ExamSelector({
    super.key,
    required this.selectedExam,
    required this.onExamChanged,
  });

  @override
  Widget build(BuildContext context) {
    final exams = ['Prelim', 'Midterm', 'Semifinal', 'Final'];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Exam',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              children: exams
                  .map((exam) => ChoiceChip(
                        label: Text(exam),
                        selected: selectedExam == exam,
                        onSelected: (selected) {
                          if (selected) onExamChanged(exam);
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCriteriaChart extends StatelessWidget {
  final String selectedExam;

  const ExamCriteriaChart({
    super.key,
    required this.selectedExam,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$selectedExam Criteria Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getCriteriaData(),
                  centerSpaceRadius: 40.w,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getCriteriaData() {
    return [
      PieChartSectionData(
        value: 30,
        title: 'Theory\n30%',
        color: const Color(0xFF6B9B8A),
        radius: 60.w,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: 40,
        title: 'Problem\nSolving\n40%',
        color: const Color(0xFF9BC9B8),
        radius: 60.w,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: 30,
        title: 'Application\n30%',
        color: const Color(0xFFE8A87C),
        radius: 60.w,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}

class ExamPerformanceChart extends StatelessWidget {
  final String selectedExam;

  const ExamPerformanceChart({
    super.key,
    required this.selectedExam,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$selectedExam Performance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
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
                          final titles = ['Theory', 'Problem\nSolving', 'Application'];
                          if (value.toInt() < titles.length) {
                            return Text(
                              titles[value.toInt()],
                              style: TextStyle(fontSize: 10.sp),
                              textAlign: TextAlign.center,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: TextStyle(fontSize: 10.sp),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: _getPerformanceData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _getPerformanceData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 85,
            color: const Color(0xFF6B9B8A),
            width: 16.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 78,
            color: const Color(0xFF9BC9B8),
            width: 16.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 92,
            color: const Color(0xFFE8A87C),
            width: 16.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    ];
  }
}

class ExamInsights extends StatelessWidget {
  final String selectedExam;

  const ExamInsights({
    super.key,
    required this.selectedExam,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$selectedExam Insights',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            _buildInsightItem(
              context,
              Icons.trending_up,
              'Strong Performance',
              'Excellent work in Application section (92%)',
              const Color(0xFF4CAF50),
            ),
            SizedBox(height: 12.h),
            _buildInsightItem(
              context,
              Icons.warning_amber,
              'Improvement Area',
              'Problem Solving needs attention (78%)',
              const Color(0xFFFF9800),
            ),
            SizedBox(height: 12.h),
            _buildInsightItem(
              context,
              Icons.info,
              'Recommendation',
              'Practice more algorithmic problems',
              const Color(0xFF2196F3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 20.w,
            color: color,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
