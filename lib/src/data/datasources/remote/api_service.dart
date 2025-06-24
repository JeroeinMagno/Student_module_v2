import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> getStudentInfo() async {
    try {
      final response = await _dio.get('/students');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch student info: $e');
    }
  }

  Future<List<dynamic>> getCourses() async {
    try {
      final response = await _dio.get('/courses');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch courses: $e');
    }
  }

  Future<Map<String, dynamic>> getCourseById(String id) async {
    try {
      final response = await _dio.get('/courses/$id');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch course: $e');
    }
  }
  Future<List<dynamic>> getChartData() async {
    try {
      // Mock data for now, replace with actual API endpoint
      return [
        {"month": "January", "desktop": 186},
        {"month": "February", "desktop": 305},
        {"month": "March", "desktop": 237},
        {"month": "April", "desktop": 73},
        {"month": "May", "desktop": 209},
        {"month": "June", "desktop": 214},
      ];
    } catch (e) {
      throw Exception('Failed to fetch chart data: $e');
    }
  }

  Future<List<dynamic>> getRecentAssessments() async {
    try {
      // Mock data for now, replace with actual API endpoint
      return [
        {
          "id": "1",
          "name": "Midterm Exam",
          "course": "CS 101",
          "date": "2024-03-15",
          "score": 85,
          "maxScore": 100,
          "status": "completed"
        },
        {
          "id": "2",
          "name": "Quiz 1",
          "course": "MATH 201",
          "date": "2024-03-10",
          "score": 92,
          "maxScore": 100,
          "status": "completed"
        }
      ];
    } catch (e) {
      throw Exception('Failed to fetch recent assessments: $e');
    }
  }

  Future<Map<String, dynamic>> getPerformanceDistribution() async {
    try {
      // Mock data for now
      return {
        "excellent": 25.0,
        "good": 35.0,
        "average": 30.0,
        "below_average": 10.0
      };
    } catch (e) {
      throw Exception('Failed to fetch performance distribution: $e');
    }
  }

  Future<List<dynamic>> getGradeTrends() async {
    try {
      // Mock data for now
      return [
        {"month": "January", "grade": 85},
        {"month": "February", "grade": 88},
        {"month": "March", "grade": 90},
        {"month": "April", "grade": 87},
        {"month": "May", "grade": 91},
        {"month": "June", "grade": 89},
      ];
    } catch (e) {
      throw Exception('Failed to fetch grade trends: $e');
    }
  }

  Future<List<dynamic>> getAllExams() async {
    try {
      // Mock data for now
      return [
        {
          "id": "1",
          "title": "Midterm Exam",
          "course": "CS 101",
          "date": "2024-03-15",
          "status": "completed",
          "score": 85
        },
        {
          "id": "2",
          "title": "Final Exam",
          "course": "CS 101",
          "date": "2024-05-20",
          "status": "upcoming",
          "score": null
        }
      ];
    } catch (e) {
      throw Exception('Failed to fetch all exams: $e');
    }
  }
}
