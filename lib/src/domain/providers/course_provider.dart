import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course.dart';
import '../../data/repositories/course_repository.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final repository = ref.watch(courseRepositoryProvider);
  return repository.getCourses();
});

final selectedCourseProvider = StateProvider<Course?>((ref) => null);
