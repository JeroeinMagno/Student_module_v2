import 'package:equatable/equatable.dart';
import 'exam.dart';

class Course extends Equatable {
  final String id;
  final String code;
  final String title;
  final String description;
  final String instructor;
  final int progress;
  final List<Exam> exams;

  const Course({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.instructor,
    required this.progress,
    required this.exams,
  });

  @override
  List<Object?> get props => [id, code, title, description, instructor, progress, exams];

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
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

  Course copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? instructor,
    int? progress,
    List<Exam>? exams,
  }) {
    return Course(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      progress: progress ?? this.progress,
      exams: exams ?? this.exams,
    );
  }
}
