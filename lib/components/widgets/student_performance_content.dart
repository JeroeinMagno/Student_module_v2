import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';

/// Rich student performance content that matches the original design exactly
class StudentPerformanceContent extends StatefulWidget {
  const StudentPerformanceContent({super.key});

  @override
  State<StudentPerformanceContent> createState() => _StudentPerformanceContentState();
}

class _StudentPerformanceContentState extends State<StudentPerformanceContent> {
  final DataService _dataService = serviceLocator<DataService>();
  
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
      setState(() {
        _isLoading = true;
      });

      // Load comprehensive student data
      final studentData = await _dataService.getStudentData();
      final coursesData = await _dataService.getCoursesData();
      
      // Mock the comprehensive data structure from original
      _studentInfo = {
        'units': 21,
        'name': studentData['name'] ?? 'John Doe',
        'studentId': studentData['studentId'] ?? '2021-12345',
        'program': studentData['program'] ?? 'Computer Science',
        'year': studentData['year'] ?? '3rd Year',
        'semester': studentData['semester'] ?? '1st Semester',
        'gwa': studentData['gwa'] ?? 1.75,
      };

      _programInfo = {
        'totalRequiredCourses': 47,
        'currentCourses': coursesData.length,
        'completedCourses': 28,
        'courseProgressPercentage': 74,
        'programName': 'Bachelor of Science in Computer Science',
        'totalUnits': 141,
        'completedUnits': 104,
      };

      _courses = (coursesData).map<Map<String, dynamic>>((course) => {
        'id': course['id'],
        'code': course['code'],
        'name': course['name'],
        'progress': course['progress'] ?? 0.0,
        'professor': course['instructor'] ?? 'TBD',
        'units': course['units'] ?? 3,
        'color': _getCourseColor(course['id'] ?? ''),
      }).toList();

      _assessmentOverview = {
        'totalAssessments': 24,
        'completed': 18,
        'inProgress': 6,
        'averageScore': 87.5,
        'highestScore': 98.0,
        'lowestScore': 72.0,
      };

      _recentAssessments = _generateRecentAssessments();
      _gradeTrends = _generateGradeTrends();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading student performance data: $e');
    }
  }

  Color _getCourseColor(String courseId) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFF9C27B0),
      const Color(0xFF607D8B),
      const Color(0xFFE91E63),
    ];
    return colors[courseId.hashCode % colors.length];
  }

  List<Map<String, dynamic>> _generateRecentAssessments() {
    return [
      {
        'course': 'CS 301',
        'type': 'Midterm Exam',
        'score': 92.0,
        'maxScore': 100.0,
        'date': 'Nov 15, 2024',
        'status': 'Completed',
      },
      {
        'course': 'MATH 301',
        'type': 'Quiz 3',
        'score': 85.0,
        'maxScore': 100.0,
        'date': 'Nov 12, 2024',
        'status': 'Completed',
      },
      {
        'course': 'ENG 301',
        'type': 'Essay',
        'score': 88.0,
        'maxScore': 100.0,
        'date': 'Nov 10, 2024',
        'status': 'Completed',
      },
      {
        'course': 'CS 302',
        'type': 'Project',
        'score': null,
        'maxScore': 100.0,
        'date': 'Nov 20, 2024',
        'status': 'In Progress',
      },
    ];
  }

  List<Map<String, dynamic>> _generateGradeTrends() {
    return [
      {'semester': '1st Sem 2022', 'gwa': 1.85},
      {'semester': '2nd Sem 2022', 'gwa': 1.78},
      {'semester': '1st Sem 2023', 'gwa': 1.72},
      {'semester': '2nd Sem 2023', 'gwa': 1.69},
      {'semester': '1st Sem 2024', 'gwa': 1.75},
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AppLoading(message: 'Loading performance data...');
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEnrolledUnitsCard(context),
          SizedBox(height: AppDimensions.paddingMD),
          _buildCurriculumCard(context),
          SizedBox(height: AppDimensions.paddingMD),
          _buildCourseProgressOverview(context),
          SizedBox(height: AppDimensions.paddingMD),
          _buildAssessmentTracker(context),
          SizedBox(height: AppDimensions.paddingMD),
          _buildAssessmentTable(context),
          SizedBox(height: AppDimensions.paddingMD),
          _buildGWATrendCard(context),
        ],
      ),
    );
  }

  Widget _buildEnrolledUnitsCard(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final units = _studentInfo?['units'] ?? 0;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enrolled Units',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Text(
                  '$units',
                  style: AppTextStyles.heading1.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    'You are currently taking $units units this semester.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDarkMode 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.7),
                    ),
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
    final totalCurriculumCourses = _programInfo?['totalRequiredCourses'] ?? 47;
    final currentCourses = _programInfo?['currentCourses'] ?? _courses.length;
    final completedCourses = _programInfo?['completedCourses'] ?? 0;
    final totalCourses = completedCourses + currentCourses;
    final progressPercentage = _programInfo?['courseProgressPercentage'] ?? 
        ((totalCourses / totalCurriculumCourses) * 100).round();

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curriculum',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            Row(
              children: [
                Text(
                  '$totalCourses/$totalCurriculumCourses',
                  style: AppTextStyles.heading3.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSM),
                Expanded(
                  child: Text(
                    'You completed $progressPercentage% of your curriculum.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDarkMode 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              '$completedCourses completed, $currentCourses in progress',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseProgressOverview(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Progress Overview',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Track real-time progress in your enrolled courses',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            ..._courses.map((course) {
              final progress = (course['progress'] ?? 0) / 100.0;
              return Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
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
    final progressBackgroundColor = isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.1);
    
    final totalAssessments = _assessmentOverview?['totalAssessments'] ?? 0;
    final completedAssessments = _assessmentOverview?['completed'] ?? 0;
    final progress = totalAssessments > 0 ? completedAssessments / totalAssessments : 0.0;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assessment Tracker',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Completed vs. In Progress',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$totalAssessments',
                          style: AppTextStyles.heading1.copyWith(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 36.sp,
                          ),
                        ),
                        Text(
                          'Total Assessments',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isDarkMode 
                                ? Colors.white.withOpacity(0.7) 
                                : Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Center(
              child: Column(
                children: [
                  Text(
                    '$completedAssessments completed, ${totalAssessments - completedAssessments} in progress',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    'Tracking assessments this semester',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDarkMode 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.7),
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

  Widget _buildAssessmentTable(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Assessments',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Your latest assessment results',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                ),
                columns: [
                  DataColumn(
                    label: Text('Course', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Assessment', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Score', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Date', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: _recentAssessments.map((assessment) {
                  final isCompleted = assessment['status'] == 'Completed';
                  final score = assessment['score'];
                  
                  return DataRow(
                    cells: [
                      DataCell(Text(assessment['course'], style: TextStyle(color: textColor))),
                      DataCell(Text(assessment['type'], style: TextStyle(color: textColor))),
                      DataCell(
                        Text(
                          score != null 
                              ? '${((score / assessment['maxScore']) * 100).toStringAsFixed(1)}%' 
                              : 'TBD',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      DataCell(Text(assessment['date'], style: TextStyle(color: textColor))),
                      DataCell(
                        AppBadge(
                          text: assessment['status'],
                          variant: isCompleted ? BadgeVariant.success : BadgeVariant.warning,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGWATrendCard(BuildContext context) {
    // Calculate improvement percentage
    final firstGwa = _gradeTrends.first['gwa'] as double;
    final lastGwa = _gradeTrends.last['gwa'] as double;
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
                        if (index >= 0 && index < _gradeTrends.length) {
                          final semester = _gradeTrends[index]['semester'];
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
                    spots: _gradeTrends.asMap().entries.map((entry) {
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
