import 'base_api_service.dart';

/// Course-related API service
class CourseApiService {
  final BaseApiService _apiService;
  
  CourseApiService(this._apiService);
  
  /// Get all courses for the current student
  Future<List<Map<String, dynamic>>> getCourses() async {
    return await _apiService.get('/courses');
  }
  
  /// Get course details by ID
  Future<Map<String, dynamic>> getCourseById(String courseId) async {
    return await _apiService.get('/courses/$courseId');
  }
  
  /// Get courses by semester
  Future<List<Map<String, dynamic>>> getCoursesBySemester(String semester) async {
    return await _apiService.get('/courses', params: {'semester': semester});
  }
  
  /// Get course syllabus
  Future<Map<String, dynamic>> getCourseSyllabus(String courseId) async {
    return await _apiService.get('/courses/$courseId/syllabus');
  }
  
  /// Get course progress
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    return await _apiService.get('/courses/$courseId/progress');
  }
}
