import 'base_api_service.dart';

/// Analytics and chart data API service
class AnalyticsApiService {
  final BaseApiService _apiService;
  
  AnalyticsApiService(this._apiService);
  
  /// Get grade trends over time
  Future<List<Map<String, dynamic>>> getGradeTrends() async {
    return await _apiService.get('/charts/grade-trends');
  }
  
  /// Get performance distribution
  Future<Map<String, double>> getPerformanceDistribution() async {
    return await _apiService.get('/charts/performance-distribution');
  }
  
  /// Get subject performance data
  Future<List<Map<String, dynamic>>> getSubjectPerformance() async {
    return await _apiService.get('/charts/subject-performance');
  }
  
  /// Get monthly progress data
  Future<List<Map<String, dynamic>>> getMonthlyProgress() async {
    return await _apiService.get('/charts/monthly-progress');
  }
  
  /// Get assessment type distribution
  Future<Map<String, dynamic>> getAssessmentTypeDistribution() async {
    return await _apiService.get('/charts/assessment-distribution');
  }
  
  /// Get skills progress data
  Future<List<Map<String, dynamic>>> getSkillsProgress() async {
    return await _apiService.get('/charts/skills-progress');
  }
  
  /// Get comprehensive dashboard data
  Future<Map<String, dynamic>> getDashboardData() async {
    return await _apiService.get('/analytics/dashboard');
  }
}
