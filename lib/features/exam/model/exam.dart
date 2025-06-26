import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final String id;
  final String courseId;
  final String courseCode;
  final String courseName;
  final String type;
  final String title;
  final DateTime date;
  final DateTime dueDate;
  final double? score;
  final double maxScore;
  final double? percentage;
  final String status; // 'completed', 'upcoming', 'missing'
  final double? grade;
  final int weight;

  const Exam({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.type,
    required this.title,
    required this.date,
    required this.dueDate,
    this.score,
    required this.maxScore,
    this.percentage,
    required this.status,
    this.grade,
    required this.weight,
  });

  @override
  List<Object?> get props => [
        id,
        courseId,
        courseCode,
        courseName,
        type,
        title,
        date,
        dueDate,
        score,
        maxScore,
        percentage,
        status,
        grade,
        weight,
      ];

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] ?? '',
      courseId: json['courseId'] ?? '',
      courseCode: json['courseCode'] ?? '',
      courseName: json['courseName'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] is DateTime ? json['date'] : DateTime.parse(json['date'].toString()),
      dueDate: json['dueDate'] is DateTime ? json['dueDate'] : DateTime.parse(json['dueDate'].toString()),
      score: json['score']?.toDouble(),
      maxScore: (json['maxScore'] ?? 100).toDouble(),
      percentage: json['percentage']?.toDouble(),
      status: json['status'] ?? 'upcoming',
      grade: json['grade']?.toDouble(),
      weight: json['weight'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'courseCode': courseCode,
      'courseName': courseName,
      'type': type,
      'title': title,
      'date': date.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'score': score,
      'maxScore': maxScore,
      'percentage': percentage,
      'status': status,
      'grade': grade,
      'weight': weight,
    };
  }

  Exam copyWith({
    String? id,
    String? courseId,
    String? courseCode,
    String? courseName,
    String? type,
    String? title,
    DateTime? date,
    DateTime? dueDate,
    double? score,
    double? maxScore,
    double? percentage,
    String? status,
    double? grade,
    int? weight,
  }) {
    return Exam(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      type: type ?? this.type,
      title: title ?? this.title,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      percentage: percentage ?? this.percentage,
      status: status ?? this.status,
      grade: grade ?? this.grade,
      weight: weight ?? this.weight,
    );
  }

  /// Get formatted date string
  String get formattedDate {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Get formatted due date string
  String get formattedDueDate {
    return '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}';
  }

  /// Check if exam is overdue
  bool get isOverdue {
    return DateTime.now().isAfter(dueDate) && status == 'upcoming';
  }

  /// Get exam status color
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'green';
      case 'upcoming':
        return isOverdue ? 'red' : 'blue';
      case 'missing':
        return 'red';
      default:
        return 'grey';
    }
  }
}
