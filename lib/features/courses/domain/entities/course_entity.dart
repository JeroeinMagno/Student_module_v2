import 'package:equatable/equatable.dart';

/// Core business entity for Course
/// This represents the pure business model without any external dependencies
class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final int totalLessons;
  final int completedLessons;
  final double progressPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> tags;
  final CourseStatus status;
  final CourseDifficulty difficulty;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.totalLessons,
    required this.completedLessons,
    required this.progressPercentage,
    required this.startDate,
    required this.endDate,
    required this.tags,
    required this.status,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        instructor,
        totalLessons,
        completedLessons,
        progressPercentage,
        startDate,
        endDate,
        tags,
        status,
        difficulty,
      ];

  CourseEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? instructor,
    int? totalLessons,
    int? completedLessons,
    double? progressPercentage,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tags,
    CourseStatus? status,
    CourseDifficulty? difficulty,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

enum CourseStatus { enrolled, completed, inProgress, notStarted }

enum CourseDifficulty { beginner, intermediate, advanced }
