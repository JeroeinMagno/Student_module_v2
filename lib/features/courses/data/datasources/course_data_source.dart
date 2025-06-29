import '../../../../core/error/result.dart';
import '../../domain/entities/course_entity.dart';

/// Abstract data source for remote course operations
abstract class CourseRemoteDataSource {
  Future<Result<List<CourseEntity>>> getCourses();
  Future<Result<CourseEntity>> getCourseById(String courseId);
  Future<Result<List<CourseEntity>>> getEnrolledCourses();
  Future<Result<List<CourseEntity>>> getCompletedCourses();
  Future<Result<List<CourseEntity>>> getCoursesInProgress();
  Future<Result<List<CourseEntity>>> searchCourses(String query);
  Future<Result<void>> enrollInCourse(String courseId);
  Future<Result<void>> updateCourseProgress(String courseId, double progress);
  Future<Result<List<CourseEntity>>> getCoursesByDifficulty(CourseDifficulty difficulty);
  Future<Result<List<CourseEntity>>> getRecommendedCourses();
}

/// Abstract data source for local course operations (caching)
abstract class CourseLocalDataSource {
  Future<Result<List<CourseEntity>>> getCachedCourses();
  Future<Result<CourseEntity>> getCachedCourseById(String courseId);
  Future<Result<void>> cacheCourses(List<CourseEntity> courses);
  Future<Result<void>> cacheCourse(CourseEntity course);
  Future<Result<void>> clearCache();
  Future<Result<bool>> isCacheValid();
}
