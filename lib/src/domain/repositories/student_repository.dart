import '../entities/student.dart';
import '../entities/course.dart';
import '../entities/chart_data.dart';
import '../entities/assessment.dart';

abstract class StudentRepository {
  Future<Student> getStudentInfo();
  Future<List<Course>> getCourses();
  Future<Course> getCourseById(String id);
  Future<List<ChartData>> getChartData();
  Future<List<Assessment>> getRecentAssessments();
  Future<Map<String, double>> getPerformanceDistribution();
  Future<List<Map<String, dynamic>>> getGradeTrends();
  Future<List<Map<String, dynamic>>> getAllExams();
}
