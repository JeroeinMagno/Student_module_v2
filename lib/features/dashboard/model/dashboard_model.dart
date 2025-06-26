/// Dashboard feature model - represents student performance data
class DashboardModel {
  final StudentInfo studentInfo;
  final ProgramInfo programInfo;
  final List<CourseModel> courses;
  final List<AssessmentModel> recentAssessments;
  final AssessmentOverview assessmentOverview;
  final List<GradeTrend> gradeTrends;

  DashboardModel({
    required this.studentInfo,
    required this.programInfo,
    required this.courses,
    required this.recentAssessments,
    required this.assessmentOverview,
    required this.gradeTrends,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      studentInfo: StudentInfo.fromJson(json['studentInfo']),
      programInfo: ProgramInfo.fromJson(json['programInfo']),
      courses: (json['courses'] as List)
          .map((course) => CourseModel.fromJson(course))
          .toList(),
      recentAssessments: (json['recentAssessments'] as List)
          .map((assessment) => AssessmentModel.fromJson(assessment))
          .toList(),
      assessmentOverview: AssessmentOverview.fromJson(json['assessmentOverview']),
      gradeTrends: (json['gradeTrends'] as List)
          .map((trend) => GradeTrend.fromJson(trend))
          .toList(),
    );
  }
}

class StudentInfo {
  final String id;
  final String name;
  final String email;
  final String studentNumber;
  final String program;
  final int yearLevel;
  final String semester;
  final String academicYear;
  final int units;
  final double gwa;
  final String status;

  StudentInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.studentNumber,
    required this.program,
    required this.yearLevel,
    required this.semester,
    required this.academicYear,
    required this.units,
    required this.gwa,
    required this.status,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      studentNumber: json['studentNumber'],
      program: json['program'],
      yearLevel: json['yearLevel'],
      semester: json['semester'],
      academicYear: json['academicYear'],
      units: json['units'],
      gwa: json['gwa'].toDouble(),
      status: json['status'],
    );
  }
}

class ProgramInfo {
  final String name;
  final String code;
  final String college;
  final int totalUnits;
  final int completedUnits;
  final int remainingUnits;
  final String expectedGraduation;

  ProgramInfo({
    required this.name,
    required this.code,
    required this.college,
    required this.totalUnits,
    required this.completedUnits,
    required this.remainingUnits,
    required this.expectedGraduation,
  });

  factory ProgramInfo.fromJson(Map<String, dynamic> json) {
    return ProgramInfo(
      name: json['name'],
      code: json['code'],
      college: json['college'],
      totalUnits: json['totalUnits'],
      completedUnits: json['completedUnits'],
      remainingUnits: json['remainingUnits'],
      expectedGraduation: json['expectedGraduation'],
    );
  }
}

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
}

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
}
