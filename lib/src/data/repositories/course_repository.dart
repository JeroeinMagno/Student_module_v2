import 'package:dio/dio.dart';
import '../../domain/models/course.dart';

class CourseRepository {
  final Dio _dio;
  final String _baseUrl = 'YOUR_API_BASE_URL'; // TODO: Replace with actual API URL

  CourseRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<Course>> getCourses() async {
    try {
      // TODO: Replace with actual API call
      // For now, return mock data
      return [
        const Course(
          id: '1',
          title: 'Mathematics',
          code: 'MATH101',
          instructor: 'Dr. Smith',
          description: 'Introduction to Calculus',
        ),
        const Course(
          id: '2',
          title: 'Physics',
          code: 'PHYS101',
          instructor: 'Dr. Johnson',
          description: 'Classical Mechanics',
        ),
        const Course(
          id: '3',
          title: 'Chemistry',
          code: 'CHEM101',
          instructor: 'Dr. Brown',
          description: 'General Chemistry',
        ),
        const Course(
          id: '4',
          title: 'English',
          code: 'ENG101',
          instructor: 'Prof. Davis',
          description: 'Academic Writing',
        ),
        const Course(
          id: '5',
          title: 'History',
          code: 'HIST101',
          instructor: 'Dr. Wilson',
          description: 'World History',
        ),
        const Course(
          id: '6',
          title: 'Computer Science',
          code: 'CS101',
          instructor: 'Dr. Garcia',
          description: 'Introduction to Programming',
        ),
      ];

      // When ready to implement actual API call:
      // final response = await _dio.get('$_baseUrl/courses');
      // return (response.data as List)
      //     .map((json) => Course.fromJson(json))
      //     .toList();
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  Future<Course> getCourseById(String id) async {
    try {
      // TODO: Replace with actual API call
      final courses = await getCourses();
      return courses.firstWhere(
        (course) => course.id == id,
        orElse: () => throw Exception('Course not found'),
      );

      // When ready to implement actual API call:
      // final response = await _dio.get('$_baseUrl/courses/$id');
      // return Course.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load course: $e');
    }
  }
}
