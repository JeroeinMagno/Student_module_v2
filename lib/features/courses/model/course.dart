import 'package:flutter/material.dart';

class Course {
  final String id;
  final String name;
  final String code;
  final double progress;
  final Color color;
  final String professor;
  final String description;
  final String semester;
  final String academicYear;
  final int units;
  final double? grade;
  final String? status;
  final DateTime? enrollmentDate;
  final List<String>? prerequisites;
  final String? schedule;
  final String? room;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.progress,
    required this.color,
    required this.professor,
    required this.description,
    required this.semester,
    required this.academicYear,
    required this.units,
    this.grade,
    this.status,
    this.enrollmentDate,
    this.prerequisites,
    this.schedule,
    this.room,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Course',
      code: json['code']?.toString() ?? 'N/A',
      progress: json['progress'] != null ? (json['progress'] as num).toDouble() : 0.0,
      color: Color(json['color'] as int? ?? 0xFF2196F3),
      professor: json['professor']?.toString() ?? 'TBD',
      description: json['description']?.toString() ?? 'No description available',
      semester: json['semester']?.toString() ?? 'N/A',
      academicYear: json['academicYear']?.toString() ?? 'N/A',
      units: json['units'] as int? ?? 3,
      grade: json['grade'] != null ? (json['grade'] as num).toDouble() : null,
      status: json['status']?.toString(),
      enrollmentDate: json['enrollmentDate'] != null 
          ? DateTime.parse(json['enrollmentDate']) 
          : null,
      prerequisites: json['prerequisites'] != null
          ? List<String>.from(json['prerequisites'])
          : null,
      schedule: json['schedule']?.toString(),
      room: json['room']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'progress': progress,
      'color': color.value,
      'professor': professor,
      'description': description,
      'semester': semester,
      'academicYear': academicYear,
      'units': units,
      'grade': grade,
      'status': status,
      'enrollmentDate': enrollmentDate?.toIso8601String(),
      'prerequisites': prerequisites,
      'schedule': schedule,
      'room': room,
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? code,
    double? progress,
    Color? color,
    String? professor,
    String? description,
    String? semester,
    String? academicYear,
    int? units,
    double? grade,
    String? status,
    DateTime? enrollmentDate,
    List<String>? prerequisites,
    String? schedule,
    String? room,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      progress: progress ?? this.progress,
      color: color ?? this.color,
      professor: professor ?? this.professor,
      description: description ?? this.description,
      semester: semester ?? this.semester,
      academicYear: academicYear ?? this.academicYear,
      units: units ?? this.units,
      grade: grade ?? this.grade,
      status: status ?? this.status,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      prerequisites: prerequisites ?? this.prerequisites,
      schedule: schedule ?? this.schedule,
      room: room ?? this.room,
    );
  }

  // Helper getters
  bool get isCompleted => progress >= 1.0;
  bool get isInProgress => progress > 0.0 && progress < 1.0;
  bool get isNotStarted => progress == 0.0;
  
  String get progressPercentage => '${(progress * 100).toInt()}%';
  
  String get gradeDisplay {
    if (grade == null) return 'N/A';
    return grade!.toStringAsFixed(1);
  }
  
  String get statusDisplay {
    if (status != null) return status!;
    if (isCompleted) return 'Completed';
    if (isInProgress) return 'In Progress';
    return 'Not Started';
  }
}
