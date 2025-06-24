import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/service_locator.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/chart_data.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/student_repository.dart';

// Repository provider
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return sl<StudentRepository>();
});

// Student info provider
final studentInfoProvider = FutureProvider<Student>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getStudentInfo();
});

// Courses provider
final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getCourses();
});

// Chart data provider
final chartDataProvider = FutureProvider<List<ChartData>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getChartData();
});

// Recent assessments provider
final recentAssessmentsProvider = FutureProvider<List<Assessment>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getRecentAssessments();
});

// Performance distribution provider
final performanceDistributionProvider = FutureProvider<Map<String, double>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getPerformanceDistribution();
});

// Grade trends provider
final gradeTrendsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getGradeTrends();
});

// All exams provider
final allExamsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getAllExams();
});

// Course by ID provider
final courseByIdProvider = FutureProvider.family<Course, String>((ref, courseId) async {
  final repository = ref.watch(studentRepositoryProvider);
  return await repository.getCourseById(courseId);
});

// Theme mode provider
final themeModeProvider = StateProvider<bool>((ref) => false); // false = light, true = dark
