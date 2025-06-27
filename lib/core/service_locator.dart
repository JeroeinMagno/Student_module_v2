import 'package:get_it/get_it.dart';
import '../data/datasources/datasources.dart';
import '../data/repositories/repositories.dart';

final GetIt serviceLocator = GetIt.instance;

/// Initialize all services and dependencies
void initializeServices({bool useMockData = true}) {
  // Register base API service
  if (useMockData) {
    serviceLocator.registerLazySingleton<BaseApiService>(() => MockApiService());
  } else {
    serviceLocator.registerLazySingleton<BaseApiService>(() => DioApiService());
  }
  
  // Register datasources
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
  
  // Register Auth datasource
  if (useMockData) {
    serviceLocator.registerLazySingleton<AuthApiService>(() => MockAuthApiService());
  } else {
    serviceLocator.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());
  }
  
  // Register repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => useMockData 
        ? MockAuthRepository()
        : AuthRepositoryImpl(serviceLocator<AuthApiService>()),
  );
  
  serviceLocator.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(serviceLocator<StudentApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(serviceLocator<CourseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(serviceLocator<AssessmentApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(serviceLocator<AnalyticsApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CareerRepository>(
    () => CareerRepositoryImpl(serviceLocator<CareerApiService>()),
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
  // Unregister and re-register datasources that depend on BaseApiService
  serviceLocator.unregister<StudentApiService>();
  serviceLocator.unregister<CourseApiService>();
  serviceLocator.unregister<AssessmentApiService>();
  serviceLocator.unregister<AnalyticsApiService>();
  serviceLocator.unregister<CareerApiService>();
  
  // Unregister repositories
  serviceLocator.unregister<StudentRepository>();
  serviceLocator.unregister<CourseRepository>();
  serviceLocator.unregister<AssessmentRepository>();
  serviceLocator.unregister<AnalyticsRepository>();
  serviceLocator.unregister<CareerRepository>();
  
  // Re-register datasources with new BaseApiService
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
  
  // Re-register repositories
  serviceLocator.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(serviceLocator<StudentApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(serviceLocator<CourseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(serviceLocator<AssessmentApiService>()),
  );
  
  serviceLocator.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(serviceLocator<AnalyticsApiService>()),
  );
  
  serviceLocator.registerLazySingleton<CareerRepository>(
    () => CareerRepositoryImpl(serviceLocator<CareerApiService>()),
  );
}
