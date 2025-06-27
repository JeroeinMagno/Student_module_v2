import 'package:get_it/get_it.dart';
import '../data/datasources/datasources.dart';
import '../data/repositories/repositories.dart';
import '../services/data_service.dart';
import '../services/api/api_services.dart' as api;

final GetIt serviceLocator = GetIt.instance;

/// Initialize all services and dependencies
void initializeServices({bool useMockData = true}) {
  // Register base API service for data layer (datasources)
  if (useMockData) {
    serviceLocator.registerLazySingleton<BaseApiService>(() => MockApiService());
  } else {
    serviceLocator.registerLazySingleton<BaseApiService>(() => DioApiService());
  }

  // Register base API service for service layer (DataService dependencies)
  if (useMockData) {
    serviceLocator.registerLazySingleton<api.BaseApiService>(() => api.MockApiService());
  } else {
    serviceLocator.registerLazySingleton<api.BaseApiService>(() => api.DioApiService());
  }
  
  // Register datasource API services (for repositories)
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

  // Register service layer API services (for DataService)
  serviceLocator.registerLazySingleton<api.StudentApiService>(
    () => api.StudentApiService(serviceLocator<api.BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<api.CourseApiService>(
    () => api.CourseApiService(serviceLocator<api.BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<api.AssessmentApiService>(
    () => api.AssessmentApiService(serviceLocator<api.BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<api.AnalyticsApiService>(
    () => api.AnalyticsApiService(serviceLocator<api.BaseApiService>()),
  );
  
  serviceLocator.registerLazySingleton<api.CareerApiService>(
    () => api.CareerApiService(serviceLocator<api.BaseApiService>()),
  );
  
  // Register Auth API service for service layer (for AuthViewModel)
  if (useMockData) {
    serviceLocator.registerLazySingleton<api.AuthApiService>(() => api.MockAuthApiService());
  } else {
    serviceLocator.registerLazySingleton<api.AuthApiService>(() => api.AuthApiServiceImpl());
  }
  
  // Register Auth datasource (for repositories)
  if (useMockData) {
    serviceLocator.registerLazySingleton<AuthApiService>(() => MockAuthApiService());
  } else {
    serviceLocator.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());
  }

  // Register DataService (coordinator service)
  serviceLocator.registerLazySingleton<DataService>(
    () => DataService(
      studentApi: serviceLocator<api.StudentApiService>(),
      courseApi: serviceLocator<api.CourseApiService>(),
      assessmentApi: serviceLocator<api.AssessmentApiService>(),
      analyticsApi: serviceLocator<api.AnalyticsApiService>(),
      careerApi: serviceLocator<api.CareerApiService>(),
    ),
  );
  
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
