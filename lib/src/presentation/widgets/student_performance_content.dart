import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'course_progress_bar.dart';
import '../../data/services/centralized_data_service.dart';

class StudentPerformanceContent extends StatefulWidget {
  const StudentPerformanceContent({super.key});

  @override
  State<StudentPerformanceContent> createState() => _StudentPerformanceContentState();
}

class _StudentPerformanceContentState extends State<StudentPerformanceContent> {
  final CentralizedDataService _dataService = CentralizedDataService();
  
  Map<String, dynamic>? _studentInfo;
  Map<String, dynamic>? _programInfo;
  List<Map<String, dynamic>> _courses = [];
  List<Map<String, dynamic>> _recentAssessments = [];
  Map<String, dynamic>? _assessmentOverview;
  List<Map<String, dynamic>> _gradeTrends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _dataService.getStudentInfo(),
        _dataService.getProgramInfo(),
        _dataService.getCourses(),
        _dataService.getUIFormattedAssessments(),
        _dataService.getAssessmentOverview(),
        _dataService.getGradeTrends(),
      ]);

      setState(() {
        _studentInfo = results[0] as Map<String, dynamic>;
        _programInfo = results[1] as Map<String, dynamic>;
        _courses = results[2] as List<Map<String, dynamic>>;
        _recentAssessments = results[3] as List<Map<String, dynamic>>;
        _assessmentOverview = results[4] as Map<String, dynamic>;
        _gradeTrends = results[5] as List<Map<String, dynamic>>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
      debugPrint('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required Widget child,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;    return Card(
      color: isDarkMode ? const Color(0xFF1A2C3E) : Colors.white,
      elevation: isDarkMode ? 0 : 2,
      shadowColor: Colors.black.withValues(alpha: 0.12), // Slightly increased shadow
      child: Container(        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.12)  // Increased from 0.1
              : Colors.black.withValues(alpha: 0.05),  // Reduced for subtlety in light mode
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
    
    final units = _studentInfo?['units'] ?? 0;

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
                  '$units',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'You are currently taking\n$units units this semester.',
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
  }  Widget _buildCurriculumCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black87;

    // Get curriculum data from centralized program info
    final totalCurriculumCourses = _programInfo?['totalRequiredCourses'] ?? 47;
    final currentCourses = _programInfo?['currentCourses'] ?? _courses.length;
    final completedCourses = _programInfo?['completedCourses'] ?? 0;
    final totalCourses = completedCourses + currentCourses;
    final progressPercentage = _programInfo?['courseProgressPercentage'] ?? 
        ((totalCourses / totalCurriculumCourses) * 100).round();

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
                  '$totalCourses/$totalCurriculumCourses',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'You completed $progressPercentage% of your curriculum.',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),            SizedBox(height: 8.h),            
            Text(
              '$completedCourses completed, $currentCourses in progress',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }  Widget _buildCourseProgressOverview(BuildContext context) {
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
              'Course Progress Overview',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            ..._courses.map((course) {
              final progress = (course['progress'] ?? 0) / 100.0;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CourseProgressBar(
                  courseCode: course['code'] ?? 'Unknown',
                  progress: progress,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
  Widget _buildAssessmentTracker(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;
    final progressBackgroundColor = isDarkMode ? Colors.white10 : Colors.black.withValues(alpha: 0.1);    final totalAssessments = _assessmentOverview?['totalAssessments'] ?? 0;
    final completedAssessments = _assessmentOverview?['completed'] ?? 0;
    final progress = totalAssessments > 0 ? completedAssessments / totalAssessments : 0.0;

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
            Text(
              'Track real-time progress in your enrolled courses',
              style: TextStyle(
                color: secondaryTextColor,
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
                        value: progress,
                        strokeWidth: 12.w,
                        backgroundColor: progressBackgroundColor,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$completedAssessments',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Total Assessments',
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
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAssessmentTable(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A1C1E) : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,                physics: const AlwaysScrollableScrollPhysics(),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: isDarkMode ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
                    dataTableTheme: DataTableThemeData(
                      headingTextStyle: TextStyle(
                        color: textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),                  child: DataTable(
                    columnSpacing: 32.w,
                    horizontalMargin: 16.w,
                    headingRowHeight: 48.h,
                    dataRowMinHeight: 52.h,
                    dataRowMaxHeight: 52.h,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Course Code',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Assessment',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Score',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],                    rows: _recentAssessments.take(4).map((assessment) => 
                      _buildAssessmentRow(
                        assessment['courseCode'] ?? 'Unknown',
                        assessment['title'] ?? 'Unknown',
                        assessment['dueDate'] ?? 'Unknown',
                        assessment['status'] ?? 'Unknown',
                        assessment['score'] != null ? '${assessment['score']}%' : '—',
                      )
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }  DataRow _buildAssessmentRow(String courseCode, String assessment, String date, String status, String score) {
    Color statusBgColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusBgColor = const Color(0xFF00875A);
        break;
      case 'upcoming':
        statusBgColor = const Color(0xFF0052CC);
        break;
      case 'missing':        statusBgColor = const Color(0xFFDE350B);
        break;
      default:
        statusBgColor = Colors.grey.withValues(alpha: 0.3);
    }

    return DataRow(
      cells: [
        DataCell(Text(courseCode, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
        DataCell(Text(assessment, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
        DataCell(Text(date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DataCell(
          Text(
            score,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }  Widget _buildGWATrendCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;    // Convert grade trends data to chart spots
    // Invert the Y-axis: transform GWA values so 1.0 appears at top, 3.0 at bottom
    final spots = _gradeTrends.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final trend = entry.value;
      final gwa = (trend['gpa'] ?? 0.0) as double; // Changed from 'gwa' to 'gpa'
      // Invert the scale: map 1.0->3.0, 1.5->2.5, 2.0->2.0, 2.5->1.5, 3.0->1.0
      final invertedGwa = 4.0 - gwa; // This inverts the scale
      return FlSpot(index, invertedGwa);
    }).toList();    // Debug: Print data to verify it's loaded
    if (_gradeTrends.isNotEmpty) {
      debugPrint('GWA Trends loaded: ${_gradeTrends.length} entries');
      debugPrint('First trend: ${_gradeTrends.first}');
      final latestGwa = _gradeTrends.last['gpa'] as double;
      debugPrint('Latest GWA: $latestGwa (lower = better, chart shows this inverted with 1.0 at top)');
    } else {
      debugPrint('GWA Trends is empty, using fallback data');
    }

    return _buildCard(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            Text(
              'GWA Trend',
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Across all semesters (Lower is better: 1.0 = Excellent, 3.0 = Passing)',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 200.h,              child: LineChart(
                LineChartData(
                  minY: 1.0, // Bottom of chart (corresponds to GWA 3.0 - lowest passing)
                  maxY: 3.0, // Top of chart (corresponds to GWA 1.0 - highest grade)
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 0.5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: isDarkMode ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < _gradeTrends.length) {
                            final month = _gradeTrends[value.toInt()]['month'] ?? '';
                            return Text(
                              month.toString().substring(0, 3), // Show first 3 letters
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 10.sp,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        interval: 0.5, // Show increments of 0.5 for GWA scale
                        getTitlesWidget: (value, meta) {
                          // Convert inverted chart value back to actual GWA value for labels
                          final actualGwa = 4.0 - value;
                          
                          // Show GWA values with proper labeling
                          if (actualGwa >= 1.0 && actualGwa <= 3.0) {
                            String label = actualGwa.toStringAsFixed(1);
                            // Add grade descriptors for key values
                            if (actualGwa == 1.0) label = '1.0\n(Excellent)';
                            else if (actualGwa == 1.5) label = '1.5\n(Very Good)';
                            else if (actualGwa == 2.0) label = '2.0\n(Good)';
                            else if (actualGwa == 2.5) label = '2.5\n(Fair)';
                            else if (actualGwa == 3.0) label = '3.0\n(Passing)';
                            
                            return Text(
                              label,
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 9.sp,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(                      spots: spots.isNotEmpty ? spots : [
                        const FlSpot(0, 2.2), // Inverted: Original 1.8 -> 4.0-1.8 = 2.2
                        const FlSpot(1, 2.5), // Inverted: Original 1.5 -> 4.0-1.5 = 2.5
                        const FlSpot(2, 2.1), // Inverted: Original 1.9 -> 4.0-1.9 = 2.1
                        const FlSpot(3, 2.8), // Inverted: Original 1.2 -> 4.0-1.2 = 2.8
                        const FlSpot(4, 2.6), // Inverted: Original 1.4 -> 4.0-1.4 = 2.6
                        const FlSpot(5, 2.9), // Inverted: Original 1.1 -> 4.0-1.1 = 2.9
                      ],isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          // Convert inverted chart value back to actual GWA for color logic
                          final actualGwa = 4.0 - spot.y;
                          
                          // Color dots based on actual GWA performance (lower = better)
                          Color dotColor;
                          if (actualGwa <= 1.25) {
                            dotColor = Colors.green; // Excellent performance
                          } else if (actualGwa <= 1.75) {
                            dotColor = Colors.blue; // Very good performance
                          } else if (actualGwa <= 2.25) {
                            dotColor = Colors.orange; // Good performance
                          } else {
                            dotColor = Colors.red; // Needs improvement
                          }
                          return FlDotCirclePainter(
                            radius: 4,
                            color: dotColor,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.green.withValues(alpha: 0.3), // Top (shows GWA 1.0) - Excellent
                            Colors.orange.withValues(alpha: 0.1), // Bottom (shows GWA 3.0) - Passing
                          ],
                        ),
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
