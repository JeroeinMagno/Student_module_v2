import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'course_progress_bar.dart';

class StudentPerformanceContent extends StatelessWidget {
  const StudentPerformanceContent({super.key});

  @override  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF1A2C3E) : Colors.white;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnrolledUnitsCard(context),
            SizedBox(height: 16.h),
            _buildCurriculumCard(context),
            SizedBox(height: 16.h),
            _buildCourseProgressOverview(context),
            SizedBox(height: 16.h),
            _buildAssessmentTracker(context),
            SizedBox(height: 16.h),
            _buildAssessmentTable(context),
            SizedBox(height: 16.h),
            _buildGWATrendCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required Widget child,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDarkMode ? const Color(0xFF1A2C3E) : Colors.white,
      elevation: isDarkMode ? 0 : 2,
      shadowColor: Colors.black.withOpacity(0.12), // Slightly increased shadow
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.12)  // Increased from 0.1
              : Colors.black.withOpacity(0.05),  // Reduced for subtlety in light mode
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: child,
      ),
    );
  }

  Widget _buildEnrolledUnitsCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enrolled Units',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  '21',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'You are currently taking\n21 units this semester.',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curriculum',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  '27/47',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12.w),
                const Expanded(
                  child: Text(
                    'You completed 57% of your curriculum.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            const Text(
              '8 completed, 3 in progress',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseProgressOverview(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Progress Overview',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            CourseProgressBar(courseCode: 'CS 101', progress: 0.9),
            SizedBox(height: 12.h),
            CourseProgressBar(courseCode: 'MATH 201', progress: 0.7),
            SizedBox(height: 12.h),
            CourseProgressBar(courseCode: 'IT 310', progress: 0.85),
            SizedBox(height: 12.h),
            CourseProgressBar(courseCode: 'ENG 102', progress: 0.75),
            SizedBox(height: 12.h),
            CourseProgressBar(courseCode: 'PHYS 110', progress: 0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentTracker(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assessment Tracker',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            const Text(
              'Track real-time progress in your enrolled courses',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: SizedBox(
                height: 160.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 160.h,
                      child: CircularProgressIndicator(
                        value: 11 / 14, // 11 out of total 14
                        strokeWidth: 12.w,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '11',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Total Assessments',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentTable(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Recent Assessments',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20.w,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Course Code',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Assessment',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Score',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
                rows: [
                  _buildAssessmentRow('CS101', 'Finals', 'Jun 28, 2025', 'Upcoming', '-'),
                  _buildAssessmentRow('MATH123', 'Midterms', 'Jun 15, 2025', 'Completed', '84%'),
                  _buildAssessmentRow('HIST200', 'Prelims', 'Jun 10, 2025', 'Missing', '-'),
                  _buildAssessmentRow('CS101', 'Quiz', 'Jun 8, 2025', 'Completed', '92%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildAssessmentRow(
    String courseCode,
    String assessment,
    String date,
    String status,
    String score,
  ) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'upcoming':
        statusColor = Colors.blue;
        break;
      case 'missing':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.white70;
    }

    return DataRow(
      cells: [
        DataCell(Text(courseCode, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(assessment, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(date, style: const TextStyle(color: Colors.white70))),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),  // Increased from 0.1 for better visibility
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor),
            ),
          ),
        ),
        DataCell(Text(score, style: const TextStyle(color: Colors.white70))),
      ],
    );
  }

  Widget _buildGWATrendCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GWA Trend',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Across all semesters',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 200.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1.7),
                        FlSpot(1, 1.8),
                        FlSpot(2, 1.6),
                        FlSpot(3, 1.9),
                        FlSpot(4, 1.5),
                        FlSpot(5, 1.7),
                      ],
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.red.withOpacity(0.15),  // Increased from 0.1
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
