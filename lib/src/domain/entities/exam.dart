import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final String title;
  final String date;
  final int percentage;
  final String status; // 'completed', 'upcoming', 'missing'

  const Exam({
    required this.title,
    required this.date,
    required this.percentage,
    required this.status,
  });

  @override
  List<Object?> get props => [title, date, percentage, status];

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      percentage: json['percentage'] ?? 0,
      status: json['status'] ?? 'upcoming',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'percentage': percentage,
      'status': status,
    };
  }

  Exam copyWith({
    String? title,
    String? date,
    int? percentage,
    String? status,
  }) {
    return Exam(
      title: title ?? this.title,
      date: date ?? this.date,
      percentage: percentage ?? this.percentage,
      status: status ?? this.status,
    );
  }
}
