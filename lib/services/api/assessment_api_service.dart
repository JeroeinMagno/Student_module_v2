import 'base_api_service.dart';

/// Assessment and exam related API service
class AssessmentApiService {
  final BaseApiService _apiService;
  
  AssessmentApiService(this._apiService);
  
  /// Get all assessments
  Future<List<Map<String, dynamic>>> getAssessments() async {
    return await _apiService.get('/assessments');
  }
  
  /// Get recent assessments
  Future<List<Map<String, dynamic>>> getRecentAssessments({int limit = 5}) async {
    return await _apiService.get('/assessments/recent', params: {'limit': limit});
  }
  
  /// Get assessments by course
  Future<List<Map<String, dynamic>>> getAssessmentsByCourse(String courseId) async {
    return await _apiService.get('/assessments/course/$courseId');
  }
  
  /// Get assessment overview/statistics
  Future<Map<String, dynamic>> getAssessmentOverview() async {
    return await _apiService.get('/assessments/overview');
  }
  
  /// Get assessment details by ID
  Future<Map<String, dynamic>> getAssessmentById(String assessmentId) async {
    return await _apiService.get('/assessments/$assessmentId');
  }
  
  /// Submit assessment result
  Future<Map<String, dynamic>> submitAssessmentResult(
    String assessmentId, 
    Map<String, dynamic> result,
  ) async {
    return await _apiService.post('/assessments/$assessmentId/submit', data: result);
  }
}
