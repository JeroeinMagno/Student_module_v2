/// Course related models

class CourseModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final int credits;
  final String professor;
  final String schedule;
  final String room;
  final double progress;
  final double? grade;
  final String status;
  final int color;

  CourseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.credits,
    required this.professor,
    required this.schedule,
    required this.room,
    required this.progress,
    this.grade,
    required this.status,
    required this.color,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      credits: json['credits'],
      professor: json['professor'],
      schedule: json['schedule'],
      room: json['room'],
      progress: json['progress'].toDouble(),
      grade: json['grade']?.toDouble(),
      status: json['status'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'credits': credits,
      'professor': professor,
      'schedule': schedule,
      'room': room,
      'progress': progress,
      'grade': grade,
      'status': status,
      'color': color,
    };
  }

  CourseModel copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    int? credits,
    String? professor,
    String? schedule,
    String? room,
    double? progress,
    double? grade,
    String? status,
    int? color,
  }) {
    return CourseModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      credits: credits ?? this.credits,
      professor: professor ?? this.professor,
      schedule: schedule ?? this.schedule,
      room: room ?? this.room,
      progress: progress ?? this.progress,
      grade: grade ?? this.grade,
      status: status ?? this.status,
      color: color ?? this.color,
    );
  }
}
