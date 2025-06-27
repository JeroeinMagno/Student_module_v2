import 'package:hive_flutter/hive_flutter.dart';
import '../error/result.dart';
import '../error/failures.dart';

/// Local storage service using Hive for offline data persistence
class StorageService {
  static const String _studentDataBoxName = 'student_data';
  static const String _coursesBoxName = 'courses_data';
  static const String _assessmentsBoxName = 'assessments_data';
  static const String _settingsBoxName = 'settings_data';
  static const String _cacheBoxName = 'cache_data';

  Box<dynamic>? _studentBox;
  Box<dynamic>? _coursesBox;
  Box<dynamic>? _assessmentsBox;
  Box<dynamic>? _settingsBox;
  Box<dynamic>? _cacheBox;

  /// Initialize the storage service
  Future<Result<void>> initialize() async {
    try {
      await Hive.initFlutter();
      
      _studentBox = await Hive.openBox(_studentDataBoxName);
      _coursesBox = await Hive.openBox(_coursesBoxName);
      _assessmentsBox = await Hive.openBox(_assessmentsBoxName);
      _settingsBox = await Hive.openBox(_settingsBoxName);
      _cacheBox = await Hive.openBox(_cacheBoxName);
      
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to initialize storage: ${error.toString()}',
      ));
    }
  }

  /// Store student data
  Future<Result<void>> storeStudentData(Map<String, dynamic> data) async {
    try {
      await _studentBox?.put('profile', data);
      await _studentBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to store student data: ${error.toString()}',
      ));
    }
  }

  /// Get student data
  Result<Map<String, dynamic>?> getStudentData() {
    try {
      final data = _studentBox?.get('profile');
      if (data is Map) {
        return Result.success(Map<String, dynamic>.from(data));
      }
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to retrieve student data: ${error.toString()}',
      ));
    }
  }

  /// Store courses data
  Future<Result<void>> storeCourses(List<Map<String, dynamic>> courses) async {
    try {
      await _coursesBox?.put('courses', courses);
      await _coursesBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to store courses data: ${error.toString()}',
      ));
    }
  }

  /// Get courses data
  Result<List<Map<String, dynamic>>?> getCourses() {
    try {
      final data = _coursesBox?.get('courses');
      if (data is List) {
        return Result.success(data.cast<Map<String, dynamic>>());
      }
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to retrieve courses data: ${error.toString()}',
      ));
    }
  }

  /// Store assessments data
  Future<Result<void>> storeAssessments(List<Map<String, dynamic>> assessments) async {
    try {
      await _assessmentsBox?.put('assessments', assessments);
      await _assessmentsBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to store assessments data: ${error.toString()}',
      ));
    }
  }

  /// Get assessments data
  Result<List<Map<String, dynamic>>?> getAssessments() {
    try {
      final data = _assessmentsBox?.get('assessments');
      if (data is List) {
        return Result.success(data.cast<Map<String, dynamic>>());
      }
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to retrieve assessments data: ${error.toString()}',
      ));
    }
  }

  /// Store generic cache data
  Future<Result<void>> storeCache<T>(String key, T data, {Duration? expiry}) async {
    try {
      final cacheEntry = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiry': expiry?.inMilliseconds,
      };
      await _cacheBox?.put(key, cacheEntry);
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to store cache data: ${error.toString()}',
      ));
    }
  }

  /// Get generic cache data
  Result<T?> getCache<T>(String key) {
    try {
      final cacheEntry = _cacheBox?.get(key);
      if (cacheEntry is Map) {
        final timestamp = cacheEntry['timestamp'] as int?;
        final expiry = cacheEntry['expiry'] as int?;
        
        // Check if cache is expired
        if (expiry != null && timestamp != null) {
          final expirationTime = timestamp + expiry;
          if (DateTime.now().millisecondsSinceEpoch > expirationTime) {
            return const Result.success(null); // Cache expired
          }
        }
        
        return Result.success(cacheEntry['data'] as T?);
      }
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to retrieve cache data: ${error.toString()}',
      ));
    }
  }

  /// Clear all cache
  Future<Result<void>> clearAllCache() async {
    try {
      await _cacheBox?.clear();
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to clear cache: ${error.toString()}',
      ));
    }
  }

  /// Store a setting
  Future<Result<void>> storeSetting<T>(String key, T value) async {
    try {
      await _settingsBox?.put(key, value);
      return const Result.success(null);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to store setting: ${error.toString()}',
      ));
    }
  }

  /// Get a setting
  Result<T?> getSetting<T>(String key) {
    try {
      final value = _settingsBox?.get(key) as T?;
      return Result.success(value);
    } catch (error) {
      return Result.failure(CacheFailure(
        'Failed to get setting: ${error.toString()}',
      ));
    }
  }

  /// Check if student data cache is valid (not older than specified duration)
  bool isStudentDataCacheValid({Duration maxAge = const Duration(hours: 1)}) {
    try {
      final lastUpdated = _studentBox?.get('lastUpdated') as int?;
      if (lastUpdated == null) return false;
      
      final age = DateTime.now().millisecondsSinceEpoch - lastUpdated;
      return age < maxAge.inMilliseconds;
    } catch (e) {
      return false;
    }
  }

  /// Check if courses data cache is valid
  bool isCoursesCacheValid({Duration maxAge = const Duration(hours: 1)}) {
    try {
      final lastUpdated = _coursesBox?.get('lastUpdated') as int?;
      if (lastUpdated == null) return false;
      
      final age = DateTime.now().millisecondsSinceEpoch - lastUpdated;
      return age < maxAge.inMilliseconds;
    } catch (e) {
      return false;
    }
  }

  /// Check if assessments data cache is valid
  bool isAssessmentsCacheValid({Duration maxAge = const Duration(hours: 1)}) {
    try {
      final lastUpdated = _assessmentsBox?.get('lastUpdated') as int?;
      if (lastUpdated == null) return false;
      
      final age = DateTime.now().millisecondsSinceEpoch - lastUpdated;
      return age < maxAge.inMilliseconds;
    } catch (e) {
      return false;
    }
  }

  /// Close all boxes (call this when app is closing)
  Future<void> close() async {
    await _studentBox?.close();
    await _coursesBox?.close();
    await _assessmentsBox?.close();
    await _settingsBox?.close();
    await _cacheBox?.close();
  }
}
