import '../datasources/assessment_datasource.dart';
import '../models/assessment_models.dart';
import 'base_repository.dart';

/// Assessment repository interface
abstract class AssessmentRepository {
  /// Get all assessments
  Future<RepositoryResult<List<AssessmentModel>>> getAssessments();
  
  /// Get recent assessments with optional limit
  Future<RepositoryResult<List<AssessmentModel>>> getRecentAssessments({int limit = 5});
  
  /// Get assessments by course
  Future<RepositoryResult<List<AssessmentModel>>> getAssessmentsByCourse(String courseId);
  
  /// Get assessment overview/statistics
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentOverview();
  
  /// Get assessment details by ID
  Future<RepositoryResult<AssessmentModel>> getAssessmentById(String assessmentId);
  
  /// Submit assessment
  Future<RepositoryResult<Map<String, dynamic>>> submitAssessmentResult(String assessmentId, Map<String, dynamic> result);
}

/// Implementation of AssessmentRepository
class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentApiService _assessmentDataSource;
  
  AssessmentRepositoryImpl(this._assessmentDataSource);
  
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getAssessments() async {
    try {
      final assessments = await _assessmentDataSource.getAssessments();
      return RepositoryResult.success(assessments);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch assessments: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getRecentAssessments({int limit = 5}) async {
    try {
      final assessments = await _assessmentDataSource.getRecentAssessments(limit: limit);
      return RepositoryResult.success(assessments);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch recent assessments: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getAssessmentsByCourse(String courseId) async {
    try {
      final assessments = await _assessmentDataSource.getAssessmentsByCourse(courseId);
      return RepositoryResult.success(assessments);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch assessments by course: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentOverview() async {
    try {
      final overview = await _assessmentDataSource.getAssessmentOverview();
      return RepositoryResult.success(overview.toJson());
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch assessment overview: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<AssessmentModel>> getAssessmentById(String assessmentId) async {
    try {
      final assessment = await _assessmentDataSource.getAssessmentById(assessmentId);
      return RepositoryResult.success(assessment);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch assessment: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> submitAssessmentResult(String assessmentId, Map<String, dynamic> result) async {
    try {
      final data = await _assessmentDataSource.submitAssessmentResult(assessmentId, result);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to submit assessment: ${e.toString()}');
    }
  }
}

/// Mock implementation of AssessmentRepository for testing
class MockAssessmentRepository implements AssessmentRepository {
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getAssessments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final mockAssessments = [
      AssessmentModel(
        id: 'assess_1',
        title: 'Midterm Exam - Computer Science',
        type: 'exam',
        courseId: 'CS101',
        courseCode: 'CS-101',
        courseName: 'Introduction to Computer Science',
        date: DateTime.now().subtract(const Duration(days: 2)),
        dueDate: DateTime.now().add(const Duration(days: 5)),
        maxScore: 100,
        score: 85,
        status: 'graded',
        weight: 30,
      ),
      AssessmentModel(
        id: 'assess_2',
        title: 'Programming Assignment 3',
        type: 'assignment',
        courseId: 'CS101',
        courseCode: 'CS-101',
        courseName: 'Introduction to Computer Science',
        date: DateTime.now().subtract(const Duration(days: 7)),
        dueDate: DateTime.now().add(const Duration(days: 3)),
        maxScore: 50,
        status: 'pending',
        weight: 20,
      ),
    ];
    
    return RepositoryResult.success(mockAssessments);
  }
  
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getRecentAssessments({int limit = 5}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final allAssessments = await getAssessments();
    if (allAssessments.isSuccess) {
      final recentAssessments = allAssessments.data!.take(limit).toList();
      return RepositoryResult.success(recentAssessments);
    }
    
    return RepositoryResult.failure(allAssessments.error!);
  }
  
  @override
  Future<RepositoryResult<List<AssessmentModel>>> getAssessmentsByCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final allAssessments = await getAssessments();
    if (allAssessments.isSuccess) {
      final courseAssessments = allAssessments.data!.where((assessment) => assessment.courseId == courseId).toList();
      return RepositoryResult.success(courseAssessments);
    }
    
    return RepositoryResult.failure(allAssessments.error!);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentOverview() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return RepositoryResult.success({
      'totalAssessments': 15,
      'completedAssessments': 12,
      'pendingAssessments': 3,
      'averageScore': 86.7,
      'upcomingDeadlines': 2,
    });
  }
  
  @override
  Future<RepositoryResult<AssessmentModel>> getAssessmentById(String assessmentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final assessment = AssessmentModel(
      id: assessmentId,
      title: 'Mock Assessment',
      type: 'exam',
      courseId: 'CS101',
      courseCode: 'CS-101',
      courseName: 'Introduction to Computer Science',
      date: DateTime.now().subtract(const Duration(days: 2)),
      dueDate: DateTime.now().add(const Duration(days: 5)),
      maxScore: 100,
      score: 85,
      status: 'graded',
      weight: 30,
    );
    
    return RepositoryResult.success(assessment);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> submitAssessmentResult(String assessmentId, Map<String, dynamic> result) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return RepositoryResult.success({
      'assessmentId': assessmentId,
      'submissionId': 'sub_${DateTime.now().millisecondsSinceEpoch}',
      'status': 'submitted',
      'submittedAt': DateTime.now().toIso8601String(),
      'message': 'Assessment submitted successfully',
    });
  }
}
