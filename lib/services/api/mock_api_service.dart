import 'base_api_service.dart';
import '../../mock_data/mock_data.dart';

/// Mock implementation of API service for development and testing
class MockApiService implements BaseApiService {
  // Simulate network delay
  static const Duration _networkDelay = Duration(milliseconds: 800);
  
  @override
  String get baseUrl => 'https://mock-api.student-module.dev/v1';
  
  @override
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  @override
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params}) async {
    await Future.delayed(_networkDelay);
    return _mockResponse<T>(endpoint, 'GET', params);
  }
  
  @override
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data}) async {
    await Future.delayed(_networkDelay);
    return _mockResponse<T>(endpoint, 'POST', data);
  }
  
  @override
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data}) async {
    await Future.delayed(_networkDelay);
    return _mockResponse<T>(endpoint, 'PUT', data);
  }
  
  @override
  Future<T> delete<T>(String endpoint) async {
    await Future.delayed(_networkDelay);
    return _mockResponse<T>(endpoint, 'DELETE');
  }
  
  T _mockResponse<T>(String endpoint, String method, [Map<String, dynamic>? data]) {
    // Route mock responses based on endpoint
    switch (endpoint) {
      case '/student/profile':
        return MockStudentData.studentInfo as T;
      
      case '/student/program':
        return MockStudentData.programInfo as T;
      
      case '/courses':
        return MockCourseData.courses as T;
      
      case '/assessments':
        // Combine assessments and exams for the general assessments endpoint
        final assessments = List<Map<String, dynamic>>.from(MockAssessmentData.assessments);
        final exams = List<Map<String, dynamic>>.from(MockExamData.exams);
        assessments.addAll(exams);
        return assessments as T;
      
      case '/assessments/recent':
        // Combine and return recent assessments and exams
        final assessments = List<Map<String, dynamic>>.from(MockAssessmentData.assessments);
        final exams = List<Map<String, dynamic>>.from(MockExamData.exams);
        assessments.addAll(exams);
        assessments.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
        final limit = data?['limit'] ?? 5;
        return assessments.take(limit).toList() as T;
      
      case '/assessments/overview':
        return MockAssessmentData.assessmentOverview as T;
      
      case '/charts/grade-trends':
        return MockChartData.gradeTrends as T;
      
      case '/charts/performance-distribution':
        return MockChartData.performanceDistribution as T;
      
      case '/charts/subject-performance':
        return MockChartData.subjectPerformance as T;
      
      case '/charts/skills-progress':
        return MockChartData.skillsProgress as T;
      
      case '/career/skills':
        return MockCareerData.skills as T;
      
      case '/career/opportunities':
        return MockCareerData.careerOpportunities as T;
      
      case '/career/profile':
        return MockCareerData.careerProfile as T;
      
      case '/career/overview':
        return MockCareerData.careerOverview as T;
      
      default:
        // Handle course-specific endpoints
        if (endpoint.startsWith('/courses/')) {
          final courseId = endpoint.split('/')[2];
          return MockCourseData.getCourseById(courseId) as T;
        }
        
        if (endpoint.startsWith('/assessments/course/')) {
          final courseId = endpoint.split('/')[3];
          final assessments = MockAssessmentData.getAssessmentsByCourse(courseId);
          final exams = MockExamData.getExamsByCourse(courseId);
          assessments.addAll(exams);
          return assessments as T;
        }
        
        throw Exception('Mock endpoint not implemented: $endpoint');
    }
  }
}
