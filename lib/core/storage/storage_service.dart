import 'package:hive_flutter/hive_flutter.dart';
import '../error/app_error.dart';
import '../error/result.dart';

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
      
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to initialize storage',
        code: 'STORAGE_INIT_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Store student data
  Future<Result<void>> storeStudentData(Map<String, dynamic> data) async {
    try {
      await _studentBox?.put('profile', data);
      await _studentBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to store student data',
        code: 'STORE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Get student data
  Result<Map<String, dynamic>?> getStudentData() {
    try {
      final data = _studentBox?.get('profile');
      if (data is Map) {
        return Success(Map<String, dynamic>.from(data));
      }
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to retrieve student data',
        code: 'RETRIEVE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Store courses data
  Future<Result<void>> storeCourses(List<Map<String, dynamic>> courses) async {
    try {
      await _coursesBox?.put('courses', courses);
      await _coursesBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to store courses data',
        code: 'STORE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Get courses data
  Result<List<Map<String, dynamic>>?> getCourses() {
    try {
      final data = _coursesBox?.get('courses');
      if (data is List) {
        return Success(data.cast<Map<String, dynamic>>());
      }
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to retrieve courses data',
        code: 'RETRIEVE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Store assessments data
  Future<Result<void>> storeAssessments(List<Map<String, dynamic>> assessments) async {
    try {
      await _assessmentsBox?.put('assessments', assessments);
      await _assessmentsBox?.put('lastUpdated', DateTime.now().millisecondsSinceEpoch);
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to store assessments data',
        code: 'STORE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Get assessments data
  Result<List<Map<String, dynamic>>?> getAssessments() {
    try {
      final data = _assessmentsBox?.get('assessments');
      if (data is List) {
        return Success(data.cast<Map<String, dynamic>>());
      }
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to retrieve assessments data',
        code: 'RETRIEVE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Store generic cache data with expiration
  Future<Result<void>> storeCache(String key, dynamic data, {Duration? expiration}) async {
    try {
      final cacheData = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'expiration': expiration?.inMilliseconds,
      };
      await _cacheBox?.put(key, cacheData);
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to store cache data',
        code: 'STORE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Get cache data with expiration check
  Result<T?> getCache<T>(String key) {
    try {
      final cacheData = _cacheBox?.get(key);
      if (cacheData is Map) {
        final timestamp = cacheData['timestamp'] as int?;
        final expiration = cacheData['expiration'] as int?;
        
        if (timestamp != null && expiration != null) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - timestamp > expiration) {
            // Cache expired, remove it
            _cacheBox?.delete(key);
            return const Success(null);
          }
        }
        
        return Success(cacheData['data'] as T?);
      }
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to retrieve cache data',
        code: 'RETRIEVE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Clear all cached data
  Future<Result<void>> clearAllCache() async {
    try {
      await _cacheBox?.clear();
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to clear cache',
        code: 'CLEAR_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Check if data is stale (older than specified duration)
  bool isDataStale(String boxName, String key, Duration maxAge) {
    try {
      Box<dynamic>? box = switch (boxName) {
        _studentDataBoxName => _studentBox,
        _coursesBoxName => _coursesBox,
        _assessmentsBoxName => _assessmentsBox,
        _ => null,
      };

      final lastUpdated = box?.get('lastUpdated') as int?;
      if (lastUpdated == null) return true;

      final now = DateTime.now().millisecondsSinceEpoch;
      return (now - lastUpdated) > maxAge.inMilliseconds;
    } catch (error) {
      return true; // Assume stale if error occurs
    }
  }

  /// Store app settings
  Future<Result<void>> storeSetting(String key, dynamic value) async {
    try {
      await _settingsBox?.put(key, value);
      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to store setting',
        code: 'STORE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Get app setting
  Result<T?> getSetting<T>(String key) {
    try {
      final value = _settingsBox?.get(key);
      return Success(value as T?);
    } catch (error, stackTrace) {
      return Failure(CacheError(
        message: 'Failed to retrieve setting',
        code: 'RETRIEVE_ERROR',
        originalError: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _studentBox?.close();
    await _coursesBox?.close();
    await _assessmentsBox?.close();
    await _settingsBox?.close();
    await _cacheBox?.close();
  }
}
