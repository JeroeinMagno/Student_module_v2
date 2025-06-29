import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_data_source.dart';

/// Implementation of CourseRepository that handles data from multiple sources
class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;
  final CourseLocalDataSource _localDataSource;

  const CourseRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<List<CourseEntity>>> getCourses() async {
    try {
      // Check if cache is valid
      final cacheValidResult = await _localDataSource.isCacheValid();
      
      if (cacheValidResult.isSuccess && cacheValidResult.data == true) {
        // Return cached data if valid
        final cachedResult = await _localDataSource.getCachedCourses();
        if (cachedResult.isSuccess) {
          return cachedResult;
        }
      }

      // Fetch from remote if cache is invalid or failed
      final remoteResult = await _remoteDataSource.getCourses();
      
      if (remoteResult.isSuccess) {
        // Cache the fresh data
        await _localDataSource.cacheCourses(remoteResult.data);
        return remoteResult;
      }

      // If remote fails, try to return cached data as fallback
      final cachedResult = await _localDataSource.getCachedCourses();
      if (cachedResult.isSuccess) {
        return cachedResult;
      }

      // If both fail, return the remote error
      return remoteResult;
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get courses: $e'));
    }
  }

  @override
  Future<Result<CourseEntity>> getCourseById(String courseId) async {
    try {
      // First try to get from cache
      final cachedResult = await _localDataSource.getCachedCourseById(courseId);
      if (cachedResult.isSuccess) {
        return cachedResult;
      }

      // If not in cache, fetch from remote
      final remoteResult = await _remoteDataSource.getCourseById(courseId);
      
      if (remoteResult.isSuccess) {
        // Cache the individual course
        await _localDataSource.cacheCourse(remoteResult.data);
      }

      return remoteResult;
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get course by ID: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> getEnrolledCourses() async {
    try {
      final result = await _remoteDataSource.getEnrolledCourses();
      
      if (result.isSuccess) {
        // Update cache with enrolled courses
        await _localDataSource.cacheCourses(result.data);
      }

      return result;
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get enrolled courses: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> getCompletedCourses() async {
    try {
      return await _remoteDataSource.getCompletedCourses();
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get completed courses: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> getCoursesInProgress() async {
    try {
      return await _remoteDataSource.getCoursesInProgress();
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get courses in progress: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> searchCourses(String query) async {
    try {
      return await _remoteDataSource.searchCourses(query);
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to search courses: $e'));
    }
  }

  @override
  Future<Result<void>> enrollInCourse(String courseId) async {
    try {
      final result = await _remoteDataSource.enrollInCourse(courseId);
      
      if (result.isSuccess) {
        // Clear cache to force refresh on next request
        await _localDataSource.clearCache();
      }

      return result;
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to enroll in course: $e'));
    }
  }

  @override
  Future<Result<void>> updateCourseProgress(String courseId, double progress) async {
    try {
      final result = await _remoteDataSource.updateCourseProgress(courseId, progress);
      
      if (result.isSuccess) {
        // Update cached course if it exists
        final cachedCourseResult = await _localDataSource.getCachedCourseById(courseId);
        if (cachedCourseResult.isSuccess) {
          final updatedCourse = cachedCourseResult.data.copyWith(
            progressPercentage: progress,
            completedLessons: ((progress / 100) * cachedCourseResult.data.totalLessons).round(),
          );
          await _localDataSource.cacheCourse(updatedCourse);
        }
      }

      return result;
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to update course progress: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> getCoursesByDifficulty(CourseDifficulty difficulty) async {
    try {
      return await _remoteDataSource.getCoursesByDifficulty(difficulty);
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get courses by difficulty: $e'));
    }
  }

  @override
  Future<Result<List<CourseEntity>>> getRecommendedCourses() async {
    try {
      return await _remoteDataSource.getRecommendedCourses();
    } catch (e) {
      return Result.failure(NetworkFailure('Failed to get recommended courses: $e'));
    }
  }
}
