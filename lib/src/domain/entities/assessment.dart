import 'package:equatable/equatable.dart';

class Assessment extends Equatable {
  final String subject;
  final String grade;
  final String score;
  final String date;
  final String type;
  final String courseCode;

  const Assessment({
    required this.subject,
    required this.grade,
    required this.score,
    required this.date,
    required this.type,
    required this.courseCode,
  });

  @override
  List<Object?> get props => [subject, grade, score, date, type, courseCode];

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      subject: json['subject'] ?? '',
      grade: json['grade'] ?? '',
      score: json['score'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
      courseCode: json['courseCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'grade': grade,
      'score': score,
      'date': date,
      'type': type,
      'courseCode': courseCode,
    };
  }

  Assessment copyWith({
    String? subject,
    String? grade,
    String? score,
    String? date,
    String? type,
    String? courseCode,
  }) {
    return Assessment(
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      score: score ?? this.score,
      date: date ?? this.date,
      type: type ?? this.type,
      courseCode: courseCode ?? this.courseCode,
    );
  }
}
