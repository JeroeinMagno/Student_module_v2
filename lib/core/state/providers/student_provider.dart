import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../../error/error_handler.dart';
import '../../error/result.dart';
import '../../storage/storage_service.dart';

/// Student data model
class StudentData {
  final Map<String, dynamic> profile;
  final Map<String, dynamic> programInfo;
  final DateTime lastUpdated;

  const StudentData({
    required this.profile,
    required this.programInfo,
    required this.lastUpdated,
  });

  StudentData copyWith({
    Map<String, dynamic>? profile,
    Map<String, dynamic>? programInfo,
    DateTime? lastUpdated,
  }) {
    return StudentData(
      profile: profile ?? this.profile,
      programInfo: programInfo ?? this.programInfo,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// Student data notifier
class StudentDataNotifier extends StateNotifier<AsyncValue<StudentData>> {
  StudentDataNotifier(this._dataService, this._storageService) 
      : super(const AsyncLoading<StudentData>());

  final DataService _dataService;
  final StorageService _storageService;

  /// Load student data with offline support
  Future<void> loadStudentData({bool forceRefresh = false}) async {
    // Don't reload if already loading
    if (state.isLoading && !forceRefresh) return;

    state = const AsyncValue.loading();

    try {
      // Try to load from cache first if not forcing refresh
      if (!forceRefresh) {
        final cachedResult = _storageService.getStudentData();
        if (cachedResult.isSuccess && cachedResult.dataOrNull != null) {
          final cached = cachedResult.dataOrNull!;
          final programResult = _storageService.getCache<Map<String, dynamic>>('program_info');
          
          if (programResult.isSuccess && programResult.dataOrNull != null) {
            state = AsyncValue.data(StudentData(
              profile: cached,
              programInfo: programResult.dataOrNull!,
              lastUpdated: DateTime.now(),
            ));
            
            // Load fresh data in background
            _loadFreshData();
            return;
          }
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
      final profileFuture = _dataService.getStudentData();
      final programFuture = _dataService.getProgramInfo();
      
      final results = await Future.wait([profileFuture, programFuture]);
      final profile = results[0];
      final programInfo = results[1];

      // Cache the data
      await _storageService.storeStudentData(profile);
      await _storageService.storeCache('program_info', programInfo, 
          expiration: const Duration(hours: 24));

      return StudentData(
        profile: profile,
        programInfo: programInfo,
        lastUpdated: DateTime.now(),
      );
    });

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }

  /// Refresh student data
  Future<void> refresh() => loadStudentData(forceRefresh: true);

  /// Update student profile locally
  void updateProfile(Map<String, dynamic> updates) {
    state.whenData((currentData) {
      final updatedProfile = {...currentData.profile, ...updates};
      
      state = AsyncValue.data(currentData.copyWith(
        profile: updatedProfile,
        lastUpdated: DateTime.now(),
      ));

      // Store updated data
      _storageService.storeStudentData(updatedProfile);
    });
  }
}

/// Provider for storage service
final storageServiceProvider = Provider<StorageService>((ref) {
  final service = StorageService();
  // Initialize storage service
  service.initialize();
  return service;
});

/// Provider for student data
final studentDataProvider = StateNotifierProvider<StudentDataNotifier, AsyncValue<StudentData>>((ref) {
  final dataService = serviceLocator<DataService>();
  final storageService = ref.watch(storageServiceProvider);
  
  final notifier = StudentDataNotifier(dataService, storageService);
  
  // Load data on initialization
  Future.microtask(() => notifier.loadStudentData());
  
  return notifier;
});

/// Provider for student profile only
final studentProfileProvider = Provider<Map<String, dynamic>?>((ref) {
  final studentData = ref.watch(studentDataProvider);
  return studentData.valueOrNull?.profile;
});

/// Provider for program info only
final programInfoProvider = Provider<Map<String, dynamic>?>((ref) {
  final studentData = ref.watch(studentDataProvider);
  return studentData.valueOrNull?.programInfo;
});
