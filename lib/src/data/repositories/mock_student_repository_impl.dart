import '../../domain/entities/student.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/chart_data.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/student_repository.dart';
import '../services/centralized_data_service.dart';

/// Mock Student Repository Implementation
/// Now uses CentralizedDataService for cleaner data management
class MockStudentRepositoryImpl implements StudentRepository {
  final CentralizedDataService _dataService = CentralizedDataService();

  @override
  Future<Student> getStudentInfo() async {
    final data = await _dataService.getStudentInfo();
    return Student(
      name: data['name'],
      srCode: data['srCode'],
      avatar: data['avatar'],
    );
  }

  @override
  Future<List<Course>> getCourses() async {
    final data = await _dataService.getCourses();
    return data.map((courseJson) => Course.fromJson(courseJson)).toList();
  }

  @override
  Future<Course> getCourseById(String id) async {
    final courseData = await _dataService.getCourseById(id);
    if (courseData == null) {
      // Return first course as fallback (maintaining existing behavior)
      final courses = await _dataService.getCourses();
      return Course.fromJson(courses.first);
    }
    return Course.fromJson(courseData);
  }

  @override
  Future<List<ChartData>> getChartData() async {
    final data = await _dataService.getChartData();
    return data.map((item) => ChartData(
      month: item['month'],
      desktop: (item['desktop'] as num).toDouble(),
    )).toList();
  }

  @override
  Future<List<Assessment>> getRecentAssessments() async {
    final data = await _dataService.getRecentAssessments();
    return data.map((assessmentJson) => Assessment.fromJson(assessmentJson)).toList();
  }

  @override
  Future<Map<String, double>> getPerformanceDistribution() async {
    return await _dataService.getPerformanceDistribution();
  }

  @override
  Future<List<Map<String, dynamic>>> getGradeTrends() async {
    return await _dataService.getGradeTrends();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllExams() async {
    return await _dataService.getAllExams();
  }
}
