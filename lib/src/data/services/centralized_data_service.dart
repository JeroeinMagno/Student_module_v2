import '../mock/centralized_mock_data.dart';

/// Centralized Data Service for Student Module
/// This service provides a single point of access to all student data
/// It currently uses mock data but can be easily switched to API calls
/// when the backend is ready

class CentralizedDataService {
  // Singleton pattern for centralized access
  static final CentralizedDataService _instance = CentralizedDataService._internal();
  factory CentralizedDataService() => _instance;
  CentralizedDataService._internal();

  // Current data source flag - can be switched to API when ready
  bool _useApiData = false;
  
  // Test user flag - when true, always returns test user data
  bool _useTestUser = true;

  // Configuration methods
  void enableApiData() => _useApiData = true;
  void enableMockData() => _useApiData = false;
  void enableTestUser() => _useTestUser = true;
  void disableTestUser() => _useTestUser = false;
  void resetConfiguration() {
    _useApiData = false;
    _useTestUser = true;
  }

  // Current configuration getters
  bool get isUsingApiData => _useApiData;
  bool get isUsingTestUser => _useTestUser;
  String get currentUserId => _useTestUser ? CentralizedMockData.testUserId : 'current_user';

  /// Student Information
  Future<Map<String, dynamic>> getStudentInfo() async {
    await _simulateNetworkDelay();
    
    if (_useApiData) {
      // TODO: Replace with actual API call when backend is ready
      // return await apiService.getStudentInfo();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUserInfo();
  }

  /// Course Data
  Future<List<Map<String, dynamic>>> getCourses() async {
    await _simulateNetworkDelay();
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getCourses();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUserCourses();
  }

  Future<Map<String, dynamic>?> getCourseById(String courseId) async {
    await _simulateNetworkDelay(milliseconds: 300);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getCourseById(courseId);
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getCourseById(courseId);
  }

  /// Assessment Data
  Future<List<Map<String, dynamic>>> getRecentAssessments() async {
    await _simulateNetworkDelay(milliseconds: 600);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getRecentAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getRecentAssessments();
  }

  Future<List<Map<String, dynamic>>> getAllAssessments() async {
    await _simulateNetworkDelay(milliseconds: 600);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAllAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUserAssessments();
  }

  Future<List<Map<String, dynamic>>> getCompletedAssessments() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getCompletedAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getCompletedAssessments();
  }

  Future<List<Map<String, dynamic>>> getUpcomingAssessments() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getUpcomingAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUpcomingAssessments();
  }

  Future<List<Map<String, dynamic>>> getMissedAssessments() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getMissedAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getMissedAssessments();
  }

  Future<List<Map<String, dynamic>>> getUIFormattedAssessments() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getUIFormattedAssessments();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUIFormattedAssessments();
  }

  Future<Map<String, dynamic>> getAssessmentOverview() async {
    await _simulateNetworkDelay(milliseconds: 500);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAssessmentOverview();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getAssessmentOverview();
  }

  Future<List<Map<String, dynamic>>> getAssessmentsByCourse(String courseId) async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAssessmentsByCourse(courseId);
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getAssessmentsByCourse(courseId);
  }

  Future<List<Map<String, dynamic>>> getAllExams() async {
    await _simulateNetworkDelay(milliseconds: 500);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAllExams();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getAllExams();
  }

  /// Performance Analytics
  Future<Map<String, double>> getPerformanceDistribution() async {
    await _simulateNetworkDelay(milliseconds: 300);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getPerformanceDistribution();
      throw UnimplementedError('API not yet implemented');
    }
      final data = CentralizedMockData.getUserPerformance()['distribution'] as Map<String, dynamic>;
    return data.map<String, double>((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  Future<List<Map<String, dynamic>>> getGradeTrends() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getGradeTrends();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUserPerformance()['gradeTrends'].cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getChartData() async {
    await _simulateNetworkDelay(milliseconds: 400);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getChartData();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getUserPerformance()['monthlyScores'].cast<Map<String, dynamic>>();
  }

  /// Learning Outcomes and Topics
  Future<List<Map<String, dynamic>>> getCourseTopics() async {
    await _simulateNetworkDelay(milliseconds: 350);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getCourseTopics();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getCourseTopics();
  }

  Future<List<Map<String, dynamic>>> getLearningOutcomes() async {
    await _simulateNetworkDelay(milliseconds: 300);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getLearningOutcomes();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getLearningOutcomes();
  }

  Future<List<Map<String, dynamic>>> getAssessmentCriteria() async {
    await _simulateNetworkDelay(milliseconds: 250);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAssessmentCriteria();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getAssessmentCriteria();
  }

  /// Career Guidance
  Future<List<Map<String, dynamic>>> getCareerPaths() async {
    await _simulateNetworkDelay(milliseconds: 450);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getCareerPaths();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getCareerPaths();
  }

  /// Utility Methods
  
  /// Get all user data at once (useful for testing)
  Future<Map<String, dynamic>> getAllUserData() async {
    await _simulateNetworkDelay(milliseconds: 800);
    
    if (_useApiData) {
      // TODO: Replace with actual API call
      // return await apiService.getAllUserData();
      throw UnimplementedError('API not yet implemented');
    }
    
    return CentralizedMockData.getAllUserData();
  }

  /// Simulate network delay for realistic testing
  Future<void> _simulateNetworkDelay({int milliseconds = 500}) async {
    if (!_useApiData) {
      await Future.delayed(Duration(milliseconds: milliseconds));
    }
  }

  /// Data validation methods
  bool validateStudentData(Map<String, dynamic> data) {
    final requiredFields = ['id', 'name', 'srCode', 'email'];
    for (final field in requiredFields) {
      if (!data.containsKey(field) || data[field] == null || data[field].toString().isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool validateCourseData(Map<String, dynamic> data) {
    final requiredFields = ['id', 'code', 'title', 'instructor'];
    return requiredFields.every((field) => data.containsKey(field) && data[field] != null);
  }

  bool validateAssessmentData(Map<String, dynamic> data) {
    final requiredFields = ['id', 'courseId', 'type', 'date', 'status'];
    return requiredFields.every((field) => data.containsKey(field) && data[field] != null);
  }

  /// Debug methods
  void printCurrentConfiguration() {
    print('=== Centralized Data Service Configuration ===');
    print('API Data: $_useApiData');
    print('Test User: $_useTestUser');
    print('Current User ID: $currentUserId');
    print('==============================================');
  }
}
