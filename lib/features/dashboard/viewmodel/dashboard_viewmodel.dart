import 'package:flutter/material.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../model/dashboard_model.dart';

/// Dashboard ViewModel using ChangeNotifier for state management
class DashboardViewModel extends ChangeNotifier {
  final DataService _dataService = serviceLocator<DataService>();

  // State variables
  DashboardModel? _dashboard;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  DashboardModel? get dashboard => _dashboard;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasData => _dashboard != null;

  // Individual data getters for easier access
  StudentInfo? get studentInfo => _dashboard?.studentInfo;
  ProgramInfo? get programInfo => _dashboard?.programInfo;
  List<CourseModel> get courses => _dashboard?.courses ?? [];
  List<AssessmentModel> get recentAssessments => _dashboard?.recentAssessments ?? [];
  AssessmentOverview? get assessmentOverview => _dashboard?.assessmentOverview;
  List<GradeTrend> get gradeTrends => _dashboard?.gradeTrends ?? [];

  /// Load all dashboard data
  Future<void> loadDashboardData() async {
    if (_isLoading) return;

    _setLoading(true);
    _clearError();

    try {
      // Load all required data concurrently
      final futures = await Future.wait([
        _dataService.getStudentInfo(),
        _dataService.getProgramInfo(),
        _dataService.getCourses(),
        _dataService.getRecentAssessments(limit: 5),
        _dataService.getAssessmentOverview(),
        _dataService.getGradeTrends(),
      ]);

      // Parse the results
      final studentInfoJson = futures[0] as Map<String, dynamic>;
      final programInfoJson = futures[1] as Map<String, dynamic>;
      final coursesJson = futures[2] as List<Map<String, dynamic>>;
      final assessmentsJson = futures[3] as List<Map<String, dynamic>>;
      final overviewJson = futures[4] as Map<String, dynamic>;
      final trendsJson = futures[5] as List<Map<String, dynamic>>;

      // Create dashboard model
      _dashboard = DashboardModel(
        studentInfo: StudentInfo.fromJson(studentInfoJson),
        programInfo: ProgramInfo.fromJson(programInfoJson),
        courses: coursesJson.map((course) => CourseModel.fromJson(course)).toList(),
        recentAssessments: assessmentsJson.map((assessment) => AssessmentModel.fromJson(assessment)).toList(),
        assessmentOverview: AssessmentOverview.fromJson(overviewJson),
        gradeTrends: trendsJson.map((trend) => GradeTrend.fromJson(trend)).toList(),
      );

      _setLoading(false);
    } catch (e) {
      _setError('Failed to load dashboard data: ${e.toString()}');
      _setLoading(false);
    }
  }

  /// Refresh dashboard data
  Future<void> refreshData() async {
    await loadDashboardData();
  }

  /// Load student info only
  Future<void> loadStudentInfo() async {
    try {
      final studentInfoJson = await _dataService.getStudentInfo();
      final studentInfo = StudentInfo.fromJson(studentInfoJson);
      
      if (_dashboard != null) {
        _dashboard = DashboardModel(
          studentInfo: studentInfo,
          programInfo: _dashboard!.programInfo,
          courses: _dashboard!.courses,
          recentAssessments: _dashboard!.recentAssessments,
          assessmentOverview: _dashboard!.assessmentOverview,
          gradeTrends: _dashboard!.gradeTrends,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load student info: $e';
    }
  }

  /// Load courses only
  Future<void> loadCourses() async {
    try {
      final coursesJson = await _dataService.getCourses();
      final courses = coursesJson.map((course) => CourseModel.fromJson(course)).toList();
      
      if (_dashboard != null) {
        _dashboard = DashboardModel(
          studentInfo: _dashboard!.studentInfo,
          programInfo: _dashboard!.programInfo,
          courses: courses,
          recentAssessments: _dashboard!.recentAssessments,
          assessmentOverview: _dashboard!.assessmentOverview,
          gradeTrends: _dashboard!.gradeTrends,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load courses: $e';
    }
  }

  /// Calculate overall progress percentage
  double get overallProgress {
    if (_dashboard?.programInfo == null) return 0.0;
    final programInfo = _dashboard!.programInfo;
    return (programInfo.completedUnits / programInfo.totalUnits) * 100;
  }

  /// Get current semester course count
  int get currentSemesterCourseCount => courses.length;

  /// Get completion rate for current assessments
  double get assessmentCompletionRate {
    if (_dashboard?.assessmentOverview == null) return 0.0;
    final overview = _dashboard!.assessmentOverview;
    if (overview.totalAssessments == 0) return 0.0;
    return (overview.completedAssessments / overview.totalAssessments) * 100;
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
