import 'base_api_service.dart';

/// Student-specific API service
class StudentApiService {
  final BaseApiService _apiService;
  
  StudentApiService(this._apiService);
  
  /// Get student profile information
  Future<Map<String, dynamic>> getStudentProfile() async {
    return await _apiService.get('/student/profile');
  }
  
  /// Get student program information
  Future<Map<String, dynamic>> getStudentProgram() async {
    return await _apiService.get('/student/program');
  }
  
  /// Get student enrollment history
  Future<List<Map<String, dynamic>>> getEnrollmentHistory() async {
    return await _apiService.get('/student/enrollment-history');
  }
  
  /// Update student profile
  Future<Map<String, dynamic>> updateStudentProfile(Map<String, dynamic> data) async {
    return await _apiService.put('/student/profile', data: data);
  }
}
