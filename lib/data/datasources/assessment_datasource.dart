import '../models/assessment_models.dart';
import 'base_datasource.dart';

/// Assessment data source interface
abstract class AssessmentDataSource {
  /// Get all assessments
  Future<List<AssessmentModel>> getAssessments();
  
  /// Get recent assessments
  Future<List<AssessmentModel>> getRecentAssessments({int limit = 5});
  
  /// Get assessments by course
  Future<List<AssessmentModel>> getAssessmentsByCourse(String courseId);
  
  /// Get assessment overview/statistics
  Future<AssessmentOverview> getAssessmentOverview();
  
  /// Get assessment details by ID
  Future<AssessmentModel> getAssessmentById(String assessmentId);
  
  /// Submit assessment result
  Future<Map<String, dynamic>> submitAssessmentResult(
    String assessmentId, 
    Map<String, dynamic> result,
  );
}

/// Assessment API service implementation
class AssessmentApiService implements AssessmentDataSource {
  final BaseApiService _apiService;
  
  AssessmentApiService(this._apiService);
  
  @override
  Future<List<AssessmentModel>> getAssessments() async {
    final response = await _apiService.get<List<dynamic>>('/assessments');
    return response.map((json) => AssessmentModel.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<List<AssessmentModel>> getRecentAssessments({int limit = 5}) async {
    final response = await _apiService.get<List<dynamic>>('/assessments/recent', params: {'limit': limit});
    return response.map((json) => AssessmentModel.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<List<AssessmentModel>> getAssessmentsByCourse(String courseId) async {
    final response = await _apiService.get<List<dynamic>>('/assessments/course/$courseId');
    return response.map((json) => AssessmentModel.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<AssessmentOverview> getAssessmentOverview() async {
    final response = await _apiService.get<Map<String, dynamic>>('/assessments/overview');
    return AssessmentOverview.fromJson(response);
  }
  
  @override
  Future<AssessmentModel> getAssessmentById(String assessmentId) async {
    final response = await _apiService.get<Map<String, dynamic>>('/assessments/$assessmentId');
    return AssessmentModel.fromJson(response);
  }
  
  @override
  Future<Map<String, dynamic>> submitAssessmentResult(
    String assessmentId, 
    Map<String, dynamic> result,
  ) async {
    return await _apiService.post<Map<String, dynamic>>('/assessments/$assessmentId/submit', data: result);
  }
}

/// Mock assessment data source for development
class MockAssessmentDataSource implements AssessmentDataSource {
  static const Duration _mockDelay = Duration(milliseconds: 500);
  
  static final List<AssessmentModel> _mockAssessments = [
    AssessmentModel(
      id: 'assess_001',
      courseId: 'cs101',
      courseCode: 'CS101',
      courseName: 'Introduction to Programming',
      type: 'Quiz',
      title: 'Variables and Data Types Quiz',
      date: DateTime.now().subtract(const Duration(days: 2)),
      dueDate: DateTime.now().add(const Duration(days: 1)),
      score: 85,
      maxScore: 100,
      percentage: 85.0,
      status: 'Completed',
      grade: 1.75,
      weight: 15,
    ),
    AssessmentModel(
      id: 'assess_002',
      courseId: 'math201',
      courseCode: 'MATH201',
      courseName: 'Calculus II',
      type: 'Exam',
      title: 'Midterm Examination',
      date: DateTime.now().subtract(const Duration(days: 5)),
      dueDate: DateTime.now().subtract(const Duration(days: 3)),
      score: 92,
      maxScore: 100,
      percentage: 92.0,
      status: 'Completed',
      grade: 1.50,
      weight: 30,
    ),
    AssessmentModel(
      id: 'assess_003',
      courseId: 'phys101',
      courseCode: 'PHYS101',
      courseName: 'Physics for Engineers',
      type: 'Assignment',
      title: 'Problem Set 3',
      date: DateTime.now().add(const Duration(days: 2)),
      dueDate: DateTime.now().add(const Duration(days: 5)),
      maxScore: 50,
      status: 'Pending',
      weight: 20,
    ),
  ];
  
  @override
  Future<List<AssessmentModel>> getAssessments() async {
    await Future.delayed(_mockDelay);
    return List.from(_mockAssessments);
  }
  
  @override
  Future<List<AssessmentModel>> getRecentAssessments({int limit = 5}) async {
    await Future.delayed(_mockDelay);
    
    final sorted = List<AssessmentModel>.from(_mockAssessments)
      ..sort((a, b) => b.date.compareTo(a.date));
    
    return sorted.take(limit).toList();
  }
  
  @override
  Future<List<AssessmentModel>> getAssessmentsByCourse(String courseId) async {
    await Future.delayed(_mockDelay);
    
    return _mockAssessments.where((assessment) => assessment.courseId == courseId).toList();
  }
  
  @override
  Future<AssessmentOverview> getAssessmentOverview() async {
    await Future.delayed(_mockDelay);
    
    final completed = _mockAssessments.where((a) => a.status == 'Completed').length;
    final pending = _mockAssessments.where((a) => a.status == 'Pending').length;
    final completedAssessments = _mockAssessments.where((a) => a.score != null);
    
    final averageScore = completedAssessments.isNotEmpty 
        ? completedAssessments.map((a) => a.percentage!).reduce((a, b) => a + b) / completedAssessments.length
        : 0.0;
    
    final highestScore = completedAssessments.isNotEmpty 
        ? completedAssessments.map((a) => a.percentage!).reduce((a, b) => a > b ? a : b)
        : 0.0;
    
    final lowestScore = completedAssessments.isNotEmpty 
        ? completedAssessments.map((a) => a.percentage!).reduce((a, b) => a < b ? a : b)
        : 0.0;
    
    return AssessmentOverview(
      totalAssessments: _mockAssessments.length,
      completedAssessments: completed,
      upcomingAssessments: pending,
      averageScore: averageScore,
      highestScore: highestScore,
      lowestScore: lowestScore,
    );
  }
  
  @override
  Future<AssessmentModel> getAssessmentById(String assessmentId) async {
    await Future.delayed(_mockDelay);
    
    final assessment = _mockAssessments.firstWhere(
      (assessment) => assessment.id == assessmentId,
      orElse: () => throw ApiException('Assessment not found: $assessmentId'),
    );
    
    return assessment;
  }
  
  @override
  Future<Map<String, dynamic>> submitAssessmentResult(
    String assessmentId, 
    Map<String, dynamic> result,
  ) async {
    await Future.delayed(_mockDelay);
    
    return {
      'success': true,
      'assessmentId': assessmentId,
      'submittedAt': DateTime.now().toIso8601String(),
      'score': result['score'],
      'maxScore': result['maxScore'],
      'percentage': (result['score'] / result['maxScore'] * 100).toDouble(),
    };
  }
}
