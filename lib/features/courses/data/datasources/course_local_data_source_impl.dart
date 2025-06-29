import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/storage/storage_service.dart';
import '../../domain/entities/course_entity.dart';
import '../models/course_dto.dart';
import 'course_data_source.dart';

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final StorageService _storageService;
  static const String _coursesKey = 'cached_courses';
  static const String _cacheTimestampKey = 'courses_cache_timestamp';
  static const Duration _cacheValidDuration = Duration(hours: 1);

  const CourseLocalDataSourceImpl(this._storageService);

  @override
  Future<Result<List<CourseEntity>>> getCachedCourses() async {
    try {
      final coursesResult = _storageService.getCache<List>(_coursesKey);
      if (coursesResult.isFailure) {
        return Result.failure(coursesResult.failure);
      }

      final coursesData = coursesResult.data;
      if (coursesData == null) {
        return const Result.failure(CacheFailure('No cached courses found'));
      }

      final coursesList = coursesData
          .map((json) => CourseDto.fromJson(json as Map<String, dynamic>))
          .map((dto) => dto.toEntity())
          .toList();

      return Result.success(coursesList);
    } catch (e) {
      return Result.failure(CacheFailure('Failed to get cached courses: $e'));
    }
  }

  @override
  Future<Result<CourseEntity>> getCachedCourseById(String courseId) async {
    try {
      final coursesResult = await getCachedCourses();
      if (coursesResult.isFailure) {
        return Result.failure(coursesResult.failure);
      }

      final courses = coursesResult.data;
      final course = courses.where((c) => c.id == courseId).firstOrNull;
      
      if (course == null) {
        return const Result.failure(NotFoundFailure('Course not found in cache'));
      }

      return Result.success(course);
    } catch (e) {
      return Result.failure(CacheFailure('Failed to get cached course: $e'));
    }
  }

  @override
  Future<Result<void>> cacheCourses(List<CourseEntity> courses) async {
    try {
      final coursesJson = courses
          .map((course) => CourseDto.fromEntity(course))
          .map((dto) => dto.toJson())
          .toList();

      final cacheResult = await _storageService.storeCache(
        _coursesKey, 
        coursesJson, 
        expiry: _cacheValidDuration,
      );
      
      if (cacheResult.isFailure) {
        return Result.failure(cacheResult.failure);
      }

      final timestampResult = await _storageService.storeCache(
        _cacheTimestampKey, 
        DateTime.now().millisecondsSinceEpoch,
      );
      
      return timestampResult;
    } catch (e) {
      return Result.failure(CacheFailure('Failed to cache courses: $e'));
    }
  }

  @override
  Future<Result<void>> cacheCourse(CourseEntity course) async {
    try {
      final coursesResult = await getCachedCourses();
      List<CourseEntity> courses = [];
      
      if (coursesResult.isSuccess) {
        courses = coursesResult.data;
      }

      // Update or add course
      final index = courses.indexWhere((c) => c.id == course.id);
      if (index != -1) {
        courses[index] = course;
      } else {
        courses.add(course);
      }

      return await cacheCourses(courses);
    } catch (e) {
      return Result.failure(CacheFailure('Failed to cache course: $e'));
    }
  }

  @override
  Future<Result<void>> clearCache() async {
    try {
      final result = await _storageService.clearAllCache();
      return result;
    } catch (e) {
      return Result.failure(CacheFailure('Failed to clear cache: $e'));
    }
  }

  @override
  Future<Result<bool>> isCacheValid() async {
    try {
      final timestampResult = _storageService.getCache<int>(_cacheTimestampKey);
      if (timestampResult.isFailure) {
        return const Result.success(false);
      }

      final timestamp = timestampResult.data;
      if (timestamp == null) {
        return const Result.success(false);
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final isValid = DateTime.now().difference(cacheTime) < _cacheValidDuration;
      
      return Result.success(isValid);
    } catch (e) {
      return Result.failure(CacheFailure('Failed to check cache validity: $e'));
    }
  }
}

extension on Iterable<CourseEntity> {
  CourseEntity? get firstOrNull => isEmpty ? null : first;
}
