import '../models/course_models.dart';
import 'base_datasource.dart';

/// Course data source interface
abstract class CourseDataSource {
  /// Get all courses for the current student
  Future<List<CourseModel>> getCourses();
  
  /// Get course details by ID
  Future<CourseModel> getCourseById(String courseId);
  
  /// Get courses by semester
  Future<List<CourseModel>> getCoursesBySemester(String semester);
  
  /// Get course syllabus
  Future<Map<String, dynamic>> getCourseSyllabus(String courseId);
  
  /// Get course progress
  Future<Map<String, dynamic>> getCourseProgress(String courseId);
}

/// Course API service implementation
class CourseApiService implements CourseDataSource {
  final BaseApiService _apiService;
  
  CourseApiService(this._apiService);
  
  @override
  Future<List<CourseModel>> getCourses() async {
    final response = await _apiService.get<List<dynamic>>('/courses');
    return response.map((json) => CourseModel.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<CourseModel> getCourseById(String courseId) async {
    final response = await _apiService.get<Map<String, dynamic>>('/courses/$courseId');
    return CourseModel.fromJson(response);
  }
  
  @override
  Future<List<CourseModel>> getCoursesBySemester(String semester) async {
    final response = await _apiService.get<List<dynamic>>('/courses', params: {'semester': semester});
    return response.map((json) => CourseModel.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<Map<String, dynamic>> getCourseSyllabus(String courseId) async {
    return await _apiService.get<Map<String, dynamic>>('/courses/$courseId/syllabus');
  }
  
  @override
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    return await _apiService.get<Map<String, dynamic>>('/courses/$courseId/progress');
  }
}

/// Mock course data source for development
class MockCourseDataSource implements CourseDataSource {
  static const Duration _mockDelay = Duration(milliseconds: 500);
  
  static final List<CourseModel> _mockCourses = [
    CourseModel(
      id: 'cs101',
      code: 'CS101',
      name: 'Introduction to Programming',
      description: 'Basic programming concepts and problem-solving techniques',
      credits: 3,
      professor: 'Dr. Smith',
      schedule: 'MWF 9:00-10:00 AM',
      room: 'Room 201',
      progress: 85.0,
      grade: 1.75,
      status: 'In Progress',
      color: 0xFF2196F3,
    ),
    CourseModel(
      id: 'math201',
      code: 'MATH201',
      name: 'Calculus II',
      description: 'Advanced calculus concepts and applications',
      credits: 4,
      professor: 'Dr. Johnson',
      schedule: 'TTH 10:30-12:00 PM',
      room: 'Room 305',
      progress: 92.0,
      grade: 1.50,
      status: 'In Progress',
      color: 0xFF4CAF50,
    ),
    CourseModel(
      id: 'phys101',
      code: 'PHYS101',
      name: 'Physics for Engineers',
      description: 'Fundamental physics principles for engineering students',
      credits: 4,
      professor: 'Dr. Wilson',
      schedule: 'MWF 2:00-3:30 PM',
      room: 'Lab 102',
      progress: 78.0,
      grade: 2.00,
      status: 'In Progress',
      color: 0xFFFF9800,
    ),
  ];
  
  @override
  Future<List<CourseModel>> getCourses() async {
    await Future.delayed(_mockDelay);
    return List.from(_mockCourses);
  }
  
  @override
  Future<CourseModel> getCourseById(String courseId) async {
    await Future.delayed(_mockDelay);
    
    final course = _mockCourses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw ApiException('Course not found: $courseId'),
    );
    
    return course;
  }
  
  @override
  Future<List<CourseModel>> getCoursesBySemester(String semester) async {
    await Future.delayed(_mockDelay);
    
    // For mock data, return all courses regardless of semester
    return List.from(_mockCourses);
  }
  
  @override
  Future<Map<String, dynamic>> getCourseSyllabus(String courseId) async {
    await Future.delayed(_mockDelay);
    
    return {
      'courseId': courseId,
      'syllabus': {
        'week1': 'Introduction and Overview',
        'week2': 'Basic Concepts',
        'week3': 'Advanced Topics',
        'week4': 'Practical Applications',
        'week5': 'Review and Assessment',
      },
      'requirements': [
        'Attendance: 10%',
        'Assignments: 30%',
        'Midterm Exam: 25%',
        'Final Exam: 35%',
      ],
    };
  }
  
  @override
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    await Future.delayed(_mockDelay);
    
    final course = _mockCourses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw ApiException('Course not found: $courseId'),
    );
    
    return {
      'courseId': courseId,
      'progress': course.progress,
      'completedModules': 8,
      'totalModules': 12,
      'lastActivity': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      'upcomingDeadlines': [
        {
          'title': 'Assignment 3',
          'dueDate': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
        },
        {
          'title': 'Quiz 2',
          'dueDate': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        },
      ],
    };
  }
}
