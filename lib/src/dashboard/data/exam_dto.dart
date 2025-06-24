
import 'package:mobile_app_student_module_v2/src/dashboard/domain/exam.dart';

class ExamDto {
  final String id;
  final String courseId;
  final String courseCode;
  final String title;
  final String name;
  final String type;
  final String date;
  final double? score;

  ExamDto({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.title,
    required this.name,
    required this.type,
    required this.date,
    this.score,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) {
    return ExamDto(
      id: json['id'],
      courseId: json['courseId'],
      courseCode: json['courseCode'] ?? '',
      title: json['title'] ?? json['name'],
      name: json['name'],
      type: json['type'] ?? 'Exam',
      date: json['date'],
      score: json['score']?.toDouble(),
    );
  }

  Exam toDomain() {
    return Exam(
      id: id,
      courseId: courseId,
      courseCode: courseCode,
      title: title,
      name: name,
      type: type,
      date: DateTime.parse(date),
      score: score,
    );
  }
}
