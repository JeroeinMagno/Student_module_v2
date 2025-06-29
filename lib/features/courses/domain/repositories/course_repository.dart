import '../../../../core/error/result.dart';
import '../entities/course_entity.dart';

/// Repository interface for course data operations
/// This defines the contract for data access without specifying implementation
abstract class CourseRepository {
  /// Get all courses for the current student
  Future<Result<List<CourseEntity>>> getCourses();
  
  /// Get a specific course by ID
  Future<Result<CourseEntity>> getCourseById(String courseId);
  
  /// Get enrolled courses
  Future<Result<List<CourseEntity>>> getEnrolledCourses();
  
  /// Get completed courses
  Future<Result<List<CourseEntity>>> getCompletedCourses();
  
  /// Get courses in progress
  Future<Result<List<CourseEntity>>> getCoursesInProgress();
  
  /// Search courses by query
  Future<Result<List<CourseEntity>>> searchCourses(String query);
  
  /// Enroll in a course
  Future<Result<void>> enrollInCourse(String courseId);
  
  /// Update course progress
  Future<Result<void>> updateCourseProgress(String courseId, double progress);
  
  /// Get courses by difficulty
  Future<Result<List<CourseEntity>>> getCoursesByDifficulty(CourseDifficulty difficulty);
  
  /// Get recommended courses
  Future<Result<List<CourseEntity>>> getRecommendedCourses();
}
