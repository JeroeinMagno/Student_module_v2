
import 'package:mobile_app_student_module_v2/src/dashboard/domain/course.dart';

class CourseDto {
  final String id;
  final String code;
  final String name;
  final String description;
  final int credits;

  CourseDto({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.credits,
  });

  factory CourseDto.fromJson(Map<String, dynamic> json) {
    return CourseDto(
      id: json['id'],
      code: json['code'] ?? json['id'], // fallback to id if code not available
      name: json['name'],
      description: json['description'],
      credits: json['credits'] ?? 3, // default to 3 credits
    );
  }

  Course toDomain() {
    return Course(
      id: id,
      code: code,
      name: name,
      description: description,
      credits: credits,
    );
  }
}
