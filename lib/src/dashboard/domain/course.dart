
import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.credits,
    this.progress = 0.0,
    this.currentGrade,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final int credits;
  final double progress;
  final String? currentGrade;

  @override
  List<Object?> get props => [id, code, name, description, credits, progress, currentGrade];
}
