import '../../domain/entities/student.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/chart_data.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/student_repository.dart';
import '../mock/mock_data_service.dart';

class MockStudentRepositoryImpl implements StudentRepository {
  @override
  Future<Student> getStudentInfo() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final data = MockDataService.getStudentInfo();
    return Student(
      name: data['name'],
      srCode: data['srCode'],
      avatar: data['avatar'],
    );
  }

  @override
  Future<List<Course>> getCourses() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final data = MockDataService.getCourseData();
    return data.map((courseJson) => Course.fromJson(courseJson)).toList();
  }

  @override
  Future<Course> getCourseById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final courses = MockDataService.getCourseData();
    final courseData = courses.firstWhere(
      (course) => course['id'] == id,
      orElse: () => courses.first,
    );
    
    return Course.fromJson(courseData);
  }

  @override
  Future<List<ChartData>> getChartData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final data = MockDataService.getChartData();
    return data.map((item) => ChartData(
      month: item['month'],
      desktop: item['desktop'],
    )).toList();
  }

  @override
  Future<List<Assessment>> getRecentAssessments() async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final data = MockDataService.getRecentAssessments();
    return data.map((assessmentJson) => Assessment.fromJson(assessmentJson)).toList();
  }
  @override
  Future<Map<String, double>> getPerformanceDistribution() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final data = MockDataService.getPerformanceDistribution();
    return data.map((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  @override
  Future<List<Map<String, dynamic>>> getGradeTrends() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return MockDataService.getGradeTrends();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllExams() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return MockDataService.getAllExams();
  }
}
