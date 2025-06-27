import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../../../presentation/widgets/dashboard/dashboard_widgets.dart';

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
          EnrolledUnitsCard(
            units: _studentInfo?['units'] ?? 0,
          ),
          SizedBox(height: AppDimensions.paddingMD),
          CurriculumProgressCard(
            totalRequiredCourses: _programInfo?['totalRequiredCourses'] ?? 47,
            completedCourses: _programInfo?['completedCourses'] ?? 0,
            currentCourses: _programInfo?['currentCourses'] ?? _courses.length,
            progressPercentage: _programInfo?['courseProgressPercentage'] ?? 0,
            programName: _programInfo?['programName'],
          ),
          SizedBox(height: AppDimensions.paddingMD),
          CourseProgressOverview(
            courses: _courses,
          ),
          SizedBox(height: AppDimensions.paddingMD),
          AssessmentTracker(
            assessmentOverview: _assessmentOverview ?? {},
          ),
          SizedBox(height: AppDimensions.paddingMD),
          RecentAssessmentsTable(
            recentAssessments: _recentAssessments,
          ),
          SizedBox(height: AppDimensions.paddingMD),
          GWATrendChart(
            gradeTrends: _gradeTrends,
          ),
        ],
      ),
    );
  }
}
