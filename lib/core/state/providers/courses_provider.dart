import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../../error/error_handler.dart';
import '../../error/result.dart';
import '../../storage/storage_service.dart';
import 'student_provider.dart';

/// Course data model
class Course {
  final String id;
  final String name;
  final String code;
  final String description;
  final int credits;
  final String instructor;
  final String schedule;
  final double? grade;
  final String status; // enrolled, completed, dropped
  final DateTime? enrollmentDate;
  final DateTime? completionDate;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.credits,
    required this.instructor,
    required this.schedule,
    this.grade,
    required this.status,
    this.enrollmentDate,
    this.completionDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String? ?? '',
      credits: json['credits'] as int? ?? 0,
      instructor: json['instructor'] as String? ?? '',
      schedule: json['schedule'] as String? ?? '',
      grade: json['grade']?.toDouble(),
      status: json['status'] as String? ?? 'enrolled',
      enrollmentDate: json['enrollment_date'] != null 
          ? DateTime.parse(json['enrollment_date'] as String)
          : null,
      completionDate: json['completion_date'] != null 
          ? DateTime.parse(json['completion_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'credits': credits,
      'instructor': instructor,
      'schedule': schedule,
      'grade': grade,
      'status': status,
      'enrollment_date': enrollmentDate?.toIso8601String(),
      'completion_date': completionDate?.toIso8601String(),
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    int? credits,
    String? instructor,
    String? schedule,
    double? grade,
    String? status,
    DateTime? enrollmentDate,
    DateTime? completionDate,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      credits: credits ?? this.credits,
      instructor: instructor ?? this.instructor,
      schedule: schedule ?? this.schedule,
      grade: grade ?? this.grade,
      status: status ?? this.status,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      completionDate: completionDate ?? this.completionDate,
    );
  }
}

/// Courses notifier
class CoursesNotifier extends StateNotifier<AsyncValue<List<Course>>> {
  CoursesNotifier(this._dataService, this._storageService) 
      : super(const AsyncValue.loading());

  final DataService _dataService;
  final StorageService _storageService;

  /// Load courses with offline support
  Future<void> loadCourses({bool forceRefresh = false}) async {
    if (state.isLoading && !forceRefresh) return;

    state = const AsyncValue.loading();

    try {
      // Try to load from cache first if not forcing refresh
      if (!forceRefresh) {
        final cachedResult = _storageService.getCache<List<dynamic>>('courses');
        if (cachedResult.isSuccess && cachedResult.dataOrNull != null) {
          final cached = cachedResult.dataOrNull!;
          final courses = cached
              .cast<Map<String, dynamic>>()
              .map((json) => Course.fromJson(json))
              .toList();
          
          state = AsyncValue.data(courses);
          
          // Load fresh data in background
          _loadFreshData();
          return;
        }
      }

      // Load fresh data
      await _loadFreshData();
    } catch (error, stackTrace) {
      state = AsyncValue.error(ErrorHandler.handleError(error, stackTrace), stackTrace);
    }
  }

  /// Load fresh data from API
  Future<void> _loadFreshData() async {
    final result = await ErrorHandler.safeCall(() async {
      final coursesData = await _dataService.getCourses();
      final courses = (coursesData as List)
          .cast<Map<String, dynamic>>()
          .map((json) => Course.fromJson(json))
          .toList();

      // Cache the data
      await _storageService.storeCache(
        'courses', 
        courses.map((c) => c.toJson()).toList(),
        expiration: const Duration(hours: 6),
      );

      return courses;
    });

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }

  /// Refresh courses
  Future<void> refresh() => loadCourses(forceRefresh: true);

  /// Get course by ID
  Course? getCourseById(String id) {
    return state.valueOrNull?.firstWhere(
      (course) => course.id == id,
      orElse: () => throw StateError('Course not found'),
    );
  }

  /// Get courses by status
  List<Course> getCoursesByStatus(String status) {
    return state.valueOrNull?.where((course) => course.status == status).toList() ?? [];
  }

  /// Update course grade
  void updateCourseGrade(String courseId, double grade) {
    state.whenData((courses) {
      final updatedCourses = courses.map((course) {
        if (course.id == courseId) {
          return course.copyWith(grade: grade);
        }
        return course;
      }).toList();

      state = AsyncValue.data(updatedCourses);

      // Update cache
      _storageService.storeCache(
        'courses',
        updatedCourses.map((c) => c.toJson()).toList(),
        expiration: const Duration(hours: 6),
      );
    });
  }
}

/// Provider for courses
final coursesProvider = StateNotifierProvider<CoursesNotifier, AsyncValue<List<Course>>>((ref) {
  final dataService = serviceLocator<DataService>();
  final storageService = ref.watch(storageServiceProvider);
  
  final notifier = CoursesNotifier(dataService, storageService);
  
  // Load data on initialization
  Future.microtask(() => notifier.loadCourses());
  
  return notifier;
});

/// Provider for current courses (enrolled)
final currentCoursesProvider = Provider<List<Course>>((ref) {
  final courses = ref.watch(coursesProvider);
  return courses.valueOrNull?.where((course) => course.status == 'enrolled').toList() ?? [];
});

/// Provider for completed courses
final completedCoursesProvider = Provider<List<Course>>((ref) {
  final courses = ref.watch(coursesProvider);
  return courses.valueOrNull?.where((course) => course.status == 'completed').toList() ?? [];
});

/// Provider for GPA calculation
final gpaProvider = Provider<double>((ref) {
  final completedCourses = ref.watch(completedCoursesProvider);
  
  if (completedCourses.isEmpty) return 0.0;
  
  double totalPoints = 0;
  int totalCredits = 0;
  
  for (final course in completedCourses) {
    if (course.grade != null) {
      totalPoints += course.grade! * course.credits;
      totalCredits += course.credits;
    }
  }
  
  return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
});

/// Provider for total completed credits
final completedCreditsProvider = Provider<int>((ref) {
  final completedCourses = ref.watch(completedCoursesProvider);
  return completedCourses.fold(0, (total, course) => total + course.credits);
});
