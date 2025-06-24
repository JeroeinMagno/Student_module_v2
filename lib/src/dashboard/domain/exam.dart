
import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  const Exam({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.title,
    required this.name,
    required this.type,
    required this.date,
    this.score,
  });

  final String id;
  final String courseId;
  final String courseCode;
  final String title;
  final String name;
  final String type;
  final DateTime date;
  final double? score;

  @override
  List<Object?> get props => [id, courseId, courseCode, title, name, type, date, score];
}
