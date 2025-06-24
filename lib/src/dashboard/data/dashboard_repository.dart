
import 'package:mobile_app_student_module_v2/src/dashboard/data/dashboard_api_service.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/course.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/dashboard_repository.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/exam.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/student.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService apiService;

  DashboardRepositoryImpl({required this.apiService});

  @override
  Future<List<Course>> getCourses() async {
    final courseDtos = await apiService.getCourses();
    return courseDtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Exam>> getExams() async {
    final examDtos = await apiService.getExams();
    return examDtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<Student> getStudent(String id) async {
    final studentDto = await apiService.getStudent(id);
    return studentDto.toDomain();
  }
}
