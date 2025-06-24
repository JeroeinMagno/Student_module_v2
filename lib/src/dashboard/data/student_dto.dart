
import 'package:mobile_app_student_module_v2/src/dashboard/domain/student.dart';

class StudentDto {
  final String id;
  final String studentId;
  final String name;
  final String email;
  final String? profileImage;

  StudentDto({
    required this.id,
    required this.studentId,
    required this.name,
    required this.email,
    this.profileImage,
  });

  factory StudentDto.fromJson(Map<String, dynamic> json) {
    return StudentDto(
      id: json['id'],
      studentId: json['studentId'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }

  Student toDomain() {
    return Student(
      id: id,
      studentId: studentId,
      name: name,
      email: email,
      profileImage: profileImage,
    );
  }
}
