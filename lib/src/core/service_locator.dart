import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../domain/repositories/student_repository.dart';
import '../data/repositories/mock_student_repository_impl.dart';
import '../domain/usecases/get_student_info.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  final dio = Dio();
  dio.options.baseUrl = 'http://localhost:3000/api'; // Update with your actual API base URL
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  sl.registerLazySingleton(() => dio);

  // Repositories (using mock implementation for now)
  sl.registerLazySingleton<StudentRepository>(() => MockStudentRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => GetStudentInfo(sl()));
}
