import '../../domain/entities/course_entity.dart';

/// Data Transfer Object for Course
/// This handles the conversion between API/Database format and Domain entities
class CourseDto {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final int totalLessons;
  final int completedLessons;
  final double progressPercentage;
  final String startDate;
  final String endDate;
  final List<String> tags;
  final String status;
  final String difficulty;

  const CourseDto({
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

  /// Convert from JSON
  factory CourseDto.fromJson(Map<String, dynamic> json) {
    return CourseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructor: json['instructor'] as String,
      totalLessons: json['totalLessons'] as int,
      completedLessons: json['completedLessons'] as int,
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      tags: List<String>.from(json['tags'] as List),
      status: json['status'] as String,
      difficulty: json['difficulty'] as String,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'progressPercentage': progressPercentage,
      'startDate': startDate,
      'endDate': endDate,
      'tags': tags,
      'status': status,
      'difficulty': difficulty,
    };
  }

  /// Convert to domain entity
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      title: title,
      description: description,
      instructor: instructor,
      totalLessons: totalLessons,
      completedLessons: completedLessons,
      progressPercentage: progressPercentage,
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      tags: tags,
      status: _parseStatus(status),
      difficulty: _parseDifficulty(difficulty),
    );
  }

  /// Convert from domain entity
  factory CourseDto.fromEntity(CourseEntity entity) {
    return CourseDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      instructor: entity.instructor,
      totalLessons: entity.totalLessons,
      completedLessons: entity.completedLessons,
      progressPercentage: entity.progressPercentage,
      startDate: entity.startDate.toIso8601String(),
      endDate: entity.endDate.toIso8601String(),
      tags: entity.tags,
      status: entity.status.name,
      difficulty: entity.difficulty.name,
    );
  }

  CourseStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'enrolled':
        return CourseStatus.enrolled;
      case 'completed':
        return CourseStatus.completed;
      case 'inprogress':
        return CourseStatus.inProgress;
      case 'notstarted':
        return CourseStatus.notStarted;
      default:
        return CourseStatus.notStarted;
    }
  }

  CourseDifficulty _parseDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return CourseDifficulty.beginner;
      case 'intermediate':
        return CourseDifficulty.intermediate;
      case 'advanced':
        return CourseDifficulty.advanced;
      default:
        return CourseDifficulty.beginner;
    }
  }
}
