/// Assessment and grading related models

class AssessmentModel {
  final String id;
  final String courseId;
  final String courseCode;
  final String courseName;
  final String type;
  final String title;
  final DateTime date;
  final DateTime dueDate;
  final int? score;
  final int maxScore;
  final double? percentage;
  final String status;
  final double? grade;
  final int weight;

  AssessmentModel({
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

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      courseId: json['courseId'],
      courseCode: json['courseCode'],
      courseName: json['courseName'],
      type: json['type'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      dueDate: DateTime.parse(json['dueDate']),
      score: json['score'],
      maxScore: json['maxScore'],
      percentage: json['percentage']?.toDouble(),
      status: json['status'],
      grade: json['grade']?.toDouble(),
      weight: json['weight'],
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
}

class AssessmentOverview {
  final int totalAssessments;
  final int completedAssessments;
  final int upcomingAssessments;
  final double averageScore;
  final double highestScore;
  final double lowestScore;

  AssessmentOverview({
    required this.totalAssessments,
    required this.completedAssessments,
    required this.upcomingAssessments,
    required this.averageScore,
    required this.highestScore,
    required this.lowestScore,
  });

  factory AssessmentOverview.fromJson(Map<String, dynamic> json) {
    return AssessmentOverview(
      totalAssessments: json['totalAssessments'],
      completedAssessments: json['completedAssessments'],
      upcomingAssessments: json['upcomingAssessments'],
      averageScore: json['averageScore'].toDouble(),
      highestScore: json['highestScore'].toDouble(),
      lowestScore: json['lowestScore'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAssessments': totalAssessments,
      'completedAssessments': completedAssessments,
      'upcomingAssessments': upcomingAssessments,
      'averageScore': averageScore,
      'highestScore': highestScore,
      'lowestScore': lowestScore,
    };
  }
}

class GradeTrend {
  final String semester;
  final double gwa;
  final DateTime date;

  GradeTrend({
    required this.semester,
    required this.gwa,
    required this.date,
  });

  factory GradeTrend.fromJson(Map<String, dynamic> json) {
    return GradeTrend(
      semester: json['semester'],
      gwa: json['gwa'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semester': semester,
      'gwa': gwa,
      'date': date.toIso8601String(),
    };
  }
}
