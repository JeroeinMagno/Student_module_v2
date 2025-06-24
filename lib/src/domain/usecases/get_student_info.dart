import '../entities/student.dart';
import '../repositories/student_repository.dart';

class GetStudentInfo {
  final StudentRepository repository;

  GetStudentInfo(this.repository);

  Future<Student> call() async {
    return await repository.getStudentInfo();
  }
}
