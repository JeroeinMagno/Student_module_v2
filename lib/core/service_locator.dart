import 'package:get_it/get_it.dart';
import '../services/data_service.dart';
import '../services/api/api_services.dart';

final GetIt serviceLocator = GetIt.instance;

/// Initialize all services and dependencies
void initializeServices({bool useMockData = true}) {
  // Register base API service
  if (useMockData) {
    serviceLocator.registerLazySingleton<BaseApiService>(() => MockApiService());
    serviceLocator.registerLazySingleton<AuthApiService>(() => MockAuthApiService());
  } else {
    serviceLocator.registerLazySingleton<BaseApiService>(() => DioApiService());
    serviceLocator.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());
  }

  // Register individual API services
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

  // Register DataService
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
