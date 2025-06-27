/// Dashboard aggregate model combining all dashboard-related data
import 'student_info_models.dart';
import 'course_models.dart';
import 'assessment_models.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'studentInfo': studentInfo.toJson(),
      'programInfo': programInfo.toJson(),
      'courses': courses.map((course) => course.toJson()).toList(),
      'recentAssessments': recentAssessments.map((assessment) => assessment.toJson()).toList(),
      'assessmentOverview': assessmentOverview.toJson(),
      'gradeTrends': gradeTrends.map((trend) => trend.toJson()).toList(),
    };
  }
}
