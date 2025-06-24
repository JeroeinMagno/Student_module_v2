import '../../domain/entities/student.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/chart_data.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/remote/api_service.dart';
import '../models/student_model.dart';
import '../models/course_model.dart';

class StudentRepositoryImpl implements StudentRepository {
  final ApiService apiService;

  StudentRepositoryImpl(this.apiService);

  @override
  Future<Student> getStudentInfo() async {
    try {
      final data = await apiService.getStudentInfo();
      return StudentModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get student info: $e');
    }
  }

  @override
  Future<List<Course>> getCourses() async {
    try {
      final data = await apiService.getCourses();
      return data.map((json) => CourseModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get courses: $e');
    }
  }

  @override
  Future<Course> getCourseById(String id) async {
    try {
      final data = await apiService.getCourseById(id);
      return CourseModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get course: $e');
    }
  }
  @override
  Future<List<ChartData>> getChartData() async {
    try {
      final data = await apiService.getChartData();
      return data.map((json) => ChartData(
        month: json['month'],
        desktop: json['desktop'].toDouble(),
      )).toList();
    } catch (e) {
      throw Exception('Failed to get chart data: $e');
    }
  }

  @override
  Future<List<Assessment>> getRecentAssessments() async {
    try {
      final data = await apiService.getRecentAssessments();
      return data.map((json) => Assessment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get recent assessments: $e');
    }
  }

  @override
  Future<Map<String, double>> getPerformanceDistribution() async {
    try {
      final data = await apiService.getPerformanceDistribution();
      return Map<String, double>.from(data);
    } catch (e) {
      throw Exception('Failed to get performance distribution: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGradeTrends() async {
    try {
      final data = await apiService.getGradeTrends();
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Failed to get grade trends: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllExams() async {
    try {
      final data = await apiService.getAllExams();
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Failed to get all exams: $e');
    }
  }
}
