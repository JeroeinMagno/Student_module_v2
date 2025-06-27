import '../datasources/course_datasource.dart';
import '../models/course_models.dart';
import 'base_repository.dart';

/// Course repository interface
abstract class CourseRepository {
  /// Get all courses for the current student
  Future<RepositoryResult<List<CourseModel>>> getCourses();
  
  /// Get course details by ID
  Future<RepositoryResult<CourseModel>> getCourseById(String courseId);
  
  /// Get courses by semester
  Future<RepositoryResult<List<CourseModel>>> getCoursesBySemester(String semester);
  
  /// Get course syllabus
  Future<RepositoryResult<Map<String, dynamic>>> getCourseSyllabus(String courseId);
  
  /// Get course progress
  Future<RepositoryResult<Map<String, dynamic>>> getCourseProgress(String courseId);
}

/// Implementation of CourseRepository
class CourseRepositoryImpl implements CourseRepository {
  final CourseApiService _courseDataSource;
  
  CourseRepositoryImpl(this._courseDataSource);
  
  @override
  Future<RepositoryResult<List<CourseModel>>> getCourses() async {
    try {
      final courses = await _courseDataSource.getCourses();
      return RepositoryResult.success(courses);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch courses: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<CourseModel>> getCourseById(String courseId) async {
    try {
      final course = await _courseDataSource.getCourseById(courseId);
      return RepositoryResult.success(course);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch course: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<CourseModel>>> getCoursesBySemester(String semester) async {
    try {
      final courses = await _courseDataSource.getCoursesBySemester(semester);
      return RepositoryResult.success(courses);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch courses by semester: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCourseSyllabus(String courseId) async {
    try {
      final data = await _courseDataSource.getCourseSyllabus(courseId);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch course syllabus: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCourseProgress(String courseId) async {
    try {
      final data = await _courseDataSource.getCourseProgress(courseId);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch course progress: ${e.toString()}');
    }
  }
}

/// Mock implementation of CourseRepository for testing
class MockCourseRepository implements CourseRepository {
  @override
  Future<RepositoryResult<List<CourseModel>>> getCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final mockCourses = [
      CourseModel(
        id: 'CS101',
        code: 'CS-101',
        name: 'Introduction to Computer Science',
        description: 'Basic concepts of computer science and programming.',
        credits: 3,
        professor: 'Dr. John Smith',
        schedule: 'MWF 10:00-11:00 AM',
        room: 'Room 101',
        status: 'active',
        progress: 75.0,
        color: 0xFF4CAF50,
      ),
      CourseModel(
        id: 'MATH201',
        code: 'MATH-201',
        name: 'Calculus II',
        description: 'Integral calculus and its applications.',
        credits: 4,
        professor: 'Prof. Jane Doe',
        schedule: 'TTh 2:00-3:30 PM',
        room: 'Room 205',
        status: 'active',
        progress: 82.5,
        color: 0xFF2196F3,
      ),
    ];
    
    return RepositoryResult.success(mockCourses);
  }
  
  @override
  Future<RepositoryResult<CourseModel>> getCourseById(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final course = CourseModel(
      id: courseId,
      code: 'CS-101',
      name: 'Introduction to Computer Science',
      description: 'Basic concepts of computer science and programming.',
      credits: 3,
      professor: 'Dr. John Smith',
      schedule: 'MWF 10:00-11:00 AM',
      room: 'Room 101',
      status: 'active',
      progress: 75.0,
      color: 0xFF4CAF50,
    );
    
    return RepositoryResult.success(course);
  }
  
  @override
  Future<RepositoryResult<List<CourseModel>>> getCoursesBySemester(String semester) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final courses = await getCourses();
    if (courses.isSuccess) {
      // For mock data, just return all courses since CourseModel doesn't have semester
      return RepositoryResult.success(courses.data!);
    }
    
    return RepositoryResult.failure(courses.error!);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCourseSyllabus(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return RepositoryResult.success({
      'courseId': courseId,
      'title': 'Course Syllabus',
      'description': 'This is the syllabus for the course.',
      'topics': ['Introduction', 'Basic Concepts', 'Advanced Topics'],
      'requirements': ['Attendance', 'Assignments', 'Exams'],
    });
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCourseProgress(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return RepositoryResult.success({
      'courseId': courseId,
      'overallProgress': 75.0,
      'completedModules': 8,
      'totalModules': 12,
      'nextDeadline': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
    });
  }
}
