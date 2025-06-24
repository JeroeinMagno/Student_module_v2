
import 'package:mobile_app_student_module_v2/src/dashboard/domain/course.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/exam.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/student.dart';

abstract class DashboardRepository {
  Future<List<Course>> getCourses();
  Future<List<Exam>> getExams();
  Future<Student> getStudent(String id);
}
