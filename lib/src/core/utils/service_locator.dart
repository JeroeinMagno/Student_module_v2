import 'package:get_it/get_it.dart';
import 'package:mobile_app_student_module_v2/src/core/providers/theme_provider.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/data/dashboard_api_service.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/data/dashboard_repository.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/dashboard_repository.dart';

final sl = GetIt.instance;

void init() {
  // Providers
  sl.registerLazySingleton(() => ThemeProvider());

  // Api Services
  sl.registerLazySingleton(() => DashboardApiService());

  // Repositories
  sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(apiService: sl()));
}
