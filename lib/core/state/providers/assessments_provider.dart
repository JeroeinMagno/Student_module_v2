import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../../error/error_handler.dart';
import '../../error/result.dart';
import '../../storage/storage_service.dart';
import 'student_provider.dart';

/// Assessment data model
class Assessment {
  final String id;
  final String courseId;
  final String title;
  final String type; // quiz, exam, assignment, project
  final String description;
  final DateTime dueDate;
  final DateTime? submissionDate;
  final double totalPoints;
  final double? earnedPoints;
  final String status; // pending, submitted, graded, overdue
  final String? feedback;
  final List<String> attachments;

  const Assessment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.type,
    required this.description,
    required this.dueDate,
    this.submissionDate,
    required this.totalPoints,
    this.earnedPoints,
    required this.status,
    this.feedback,
    this.attachments = const [],
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      type: json['type'] as String? ?? 'assignment',
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['due_date'] as String),
      submissionDate: json['submission_date'] != null 
          ? DateTime.parse(json['submission_date'] as String)
          : null,
      totalPoints: (json['total_points'] as num?)?.toDouble() ?? 0.0,
      earnedPoints: (json['earned_points'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'pending',
      feedback: json['feedback'] as String?,
      attachments: (json['attachments'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      'type': type,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'submission_date': submissionDate?.toIso8601String(),
      'total_points': totalPoints,
      'earned_points': earnedPoints,
      'status': status,
      'feedback': feedback,
      'attachments': attachments,
    };
  }

  Assessment copyWith({
    String? id,
    String? courseId,
    String? title,
    String? type,
    String? description,
    DateTime? dueDate,
    DateTime? submissionDate,
    double? totalPoints,
    double? earnedPoints,
    String? status,
    String? feedback,
    List<String>? attachments,
  }) {
    return Assessment(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      submissionDate: submissionDate ?? this.submissionDate,
      totalPoints: totalPoints ?? this.totalPoints,
      earnedPoints: earnedPoints ?? this.earnedPoints,
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      attachments: attachments ?? this.attachments,
    );
  }

  /// Check if assessment is overdue
  bool get isOverdue {
    if (status == 'submitted' || status == 'graded') return false;
    return DateTime.now().isAfter(dueDate);
  }

  /// Get grade percentage
  double? get gradePercentage {
    if (earnedPoints == null || totalPoints == 0) return null;
    return (earnedPoints! / totalPoints) * 100;
  }
}

/// Assessments notifier
class AssessmentsNotifier extends StateNotifier<AsyncValue<List<Assessment>>> {
  AssessmentsNotifier(this._dataService, this._storageService) 
      : super(const AsyncValue.loading());

  final DataService _dataService;
  final StorageService _storageService;

  /// Load assessments with offline support
  Future<void> loadAssessments({bool forceRefresh = false}) async {
    if (state.isLoading && !forceRefresh) return;

    state = const AsyncValue.loading();

    try {
      // Try to load from cache first if not forcing refresh
      if (!forceRefresh) {
        final cachedResult = _storageService.getCache<List<dynamic>>('assessments');
        if (cachedResult.isSuccess && cachedResult.dataOrNull != null) {
          final cached = cachedResult.dataOrNull!;
          final assessments = cached
              .cast<Map<String, dynamic>>()
              .map((json) => Assessment.fromJson(json))
              .toList();
          
          state = AsyncValue.data(assessments);
          
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
      final assessmentsData = await _dataService.getAssessments();
      final assessments = (assessmentsData as List)
          .cast<Map<String, dynamic>>()
          .map((json) => Assessment.fromJson(json))
          .toList();

      // Cache the data
      await _storageService.storeCache(
        'assessments', 
        assessments.map((a) => a.toJson()).toList(),
        expiration: const Duration(hours: 2),
      );

      return assessments;
    });

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }

  /// Refresh assessments
  Future<void> refresh() => loadAssessments(forceRefresh: true);

  /// Get assessment by ID
  Assessment? getAssessmentById(String id) {
    return state.valueOrNull?.firstWhere(
      (assessment) => assessment.id == id,
      orElse: () => throw StateError('Assessment not found'),
    );
  }

  /// Get assessments by course ID
  List<Assessment> getAssessmentsByCourse(String courseId) {
    return state.valueOrNull
        ?.where((assessment) => assessment.courseId == courseId)
        .toList() ?? [];
  }

  /// Get assessments by status
  List<Assessment> getAssessmentsByStatus(String status) {
    return state.valueOrNull
        ?.where((assessment) => assessment.status == status)
        .toList() ?? [];
  }

  /// Submit assessment
  Future<void> submitAssessment(String assessmentId) async {
    state.whenData((assessments) {
      final updatedAssessments = assessments.map((assessment) {
        if (assessment.id == assessmentId) {
          return assessment.copyWith(
            status: 'submitted',
            submissionDate: DateTime.now(),
          );
        }
        return assessment;
      }).toList();

      state = AsyncValue.data(updatedAssessments);

      // Update cache
      _storageService.storeCache(
        'assessments',
        updatedAssessments.map((a) => a.toJson()).toList(),
        expiration: const Duration(hours: 2),
      );
    });
  }

  /// Update assessment grade
  void updateAssessmentGrade(String assessmentId, double earnedPoints, String? feedback) {
    state.whenData((assessments) {
      final updatedAssessments = assessments.map((assessment) {
        if (assessment.id == assessmentId) {
          return assessment.copyWith(
            earnedPoints: earnedPoints,
            feedback: feedback,
            status: 'graded',
          );
        }
        return assessment;
      }).toList();

      state = AsyncValue.data(updatedAssessments);

      // Update cache
      _storageService.storeCache(
        'assessments',
        updatedAssessments.map((a) => a.toJson()).toList(),
        expiration: const Duration(hours: 2),
      );
    });
  }
}

/// Provider for assessments
final assessmentsProvider = StateNotifierProvider<AssessmentsNotifier, AsyncValue<List<Assessment>>>((ref) {
  final dataService = serviceLocator<DataService>();
  final storageService = ref.watch(storageServiceProvider);
  
  final notifier = AssessmentsNotifier(dataService, storageService);
  
  // Load data on initialization
  Future.microtask(() => notifier.loadAssessments());
  
  return notifier;
});

/// Provider for pending assessments
final pendingAssessmentsProvider = Provider<List<Assessment>>((ref) {
  final assessments = ref.watch(assessmentsProvider);
  return assessments.valueOrNull
      ?.where((assessment) => assessment.status == 'pending')
      .toList() ?? [];
});

/// Provider for overdue assessments
final overdueAssessmentsProvider = Provider<List<Assessment>>((ref) {
  final assessments = ref.watch(assessmentsProvider);
  return assessments.valueOrNull
      ?.where((assessment) => assessment.isOverdue)
      .toList() ?? [];
});

/// Provider for upcoming assessments (due in next 7 days)
final upcomingAssessmentsProvider = Provider<List<Assessment>>((ref) {
  final assessments = ref.watch(assessmentsProvider);
  final now = DateTime.now();
  final weekFromNow = now.add(const Duration(days: 7));
  
  return assessments.valueOrNull
      ?.where((assessment) => 
          assessment.status == 'pending' &&
          assessment.dueDate.isAfter(now) &&
          assessment.dueDate.isBefore(weekFromNow))
      .toList() ?? [];
});

/// Provider for completed assessments
final completedAssessmentsProvider = Provider<List<Assessment>>((ref) {
  final assessments = ref.watch(assessmentsProvider);
  return assessments.valueOrNull
      ?.where((assessment) => 
          assessment.status == 'submitted' || assessment.status == 'graded')
      .toList() ?? [];
});

/// Provider for course assessments
final courseAssessmentsProvider = Provider.family<List<Assessment>, String>((ref, courseId) {
  final assessments = ref.watch(assessmentsProvider);
  return assessments.valueOrNull
      ?.where((assessment) => assessment.courseId == courseId)
      .toList() ?? [];
});
