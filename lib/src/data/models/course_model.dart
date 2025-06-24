import '../../domain/entities/course.dart';
import '../../domain/entities/exam.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.code,
    required super.title,
    required super.description,
    required super.instructor,
    required super.progress,
    required super.exams,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      instructor: json['instructor'] ?? '',
      progress: json['progress'] ?? 0,
      exams: (json['exams'] as List<dynamic>?)
              ?.map((examJson) => Exam.fromJson(examJson))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'instructor': instructor,
      'progress': progress,
      'exams': exams.map((exam) => exam.toJson()).toList(),
    };
  }

  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
      id: course.id,
      code: course.code,
      title: course.title,
      description: course.description,
      instructor: course.instructor,
      progress: course.progress,
      exams: course.exams,
    );
  }
}
