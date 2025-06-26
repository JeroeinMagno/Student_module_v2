import 'package:get_it/get_it.dart';
import '../services/api/api_services.dart';
import '../services/data_service.dart';

final GetIt serviceLocator = GetIt.instance;

/// Initialize all services and dependencies
void initializeServices({bool useMockData = true}) {
  // Register base API service
  if (useMockData) {
    serviceLocator.registerLazySingleton<BaseApiService>(() => MockApiService());
  } else {
    serviceLocator.registerLazySingleton<BaseApiService>(() => DioApiService());
  }
  
  // Register specific API services
  serviceLocator.registerLazySingleton<StudentApiService>(
    () => StudentApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CourseApiService>(
    () => CourseApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AssessmentApiService>(
    () => AssessmentApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AnalyticsApiService>(
    () => AnalyticsApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CareerApiService>(
    () => CareerApiService(serviceLocator<BaseApiService>()),
  );
  
  // Register Auth API service (doesn't follow the same pattern as others)
  if (useMockData) {
    serviceLocator.registerLazySingleton<AuthApiService>(() => MockAuthApiService());
  } else {
    // TODO: Implement real auth API service
    serviceLocator.registerLazySingleton<AuthApiService>(() => MockAuthApiService());
  }
  
  // Register centralized data service
  serviceLocator.registerLazySingleton<DataService>(
    () => DataService(
      studentApi: serviceLocator<StudentApiService>(),
      courseApi: serviceLocator<CourseApiService>(),
      assessmentApi: serviceLocator<AssessmentApiService>(),
      analyticsApi: serviceLocator<AnalyticsApiService>(),
      careerApi: serviceLocator<CareerApiService>(),
    ),
  );
}

/// Get a service instance
T getService<T extends Object>() => serviceLocator<T>();

/// Check if a service is registered
bool isServiceRegistered<T extends Object>() => serviceLocator.isRegistered<T>();

/// Reset all services (useful for testing)
void resetServices() => serviceLocator.reset();

/// Switch between mock and real API
void switchToMockData() {
  serviceLocator.unregister<BaseApiService>();
  serviceLocator.registerLazySingleton<BaseApiService>(() => MockApiService());
  _refreshDependentServices();
}

void switchToRealData() {
  serviceLocator.unregister<BaseApiService>();
  serviceLocator.registerLazySingleton<BaseApiService>(() => DioApiService());
  _refreshDependentServices();
}

void _refreshDependentServices() {
  // Unregister and re-register services that depend on BaseApiService
  serviceLocator.unregister<StudentApiService>();
  serviceLocator.unregister<CourseApiService>();
  serviceLocator.unregister<AssessmentApiService>();
  serviceLocator.unregister<AnalyticsApiService>();
  serviceLocator.unregister<CareerApiService>();
  serviceLocator.unregister<DataService>();
  
  // Re-register with new BaseApiService
  serviceLocator.registerLazySingleton<StudentApiService>(
    () => StudentApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CourseApiService>(
    () => CourseApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AssessmentApiService>(
    () => AssessmentApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AnalyticsApiService>(
    () => AnalyticsApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CareerApiService>(
    () => CareerApiService(serviceLocator<BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<DataService>(
    () => DataService(
      studentApi: serviceLocator<StudentApiService>(),
      courseApi: serviceLocator<CourseApiService>(),
      assessmentApi: serviceLocator<AssessmentApiService>(),
      analyticsApi: serviceLocator<AnalyticsApiService>(),
      careerApi: serviceLocator<CareerApiService>(),
    ),
  );
}
