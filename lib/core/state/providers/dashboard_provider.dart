import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'student_provider.dart';
import 'courses_provider.dart';
import 'assessments_provider.dart';
import 'connectivity_provider.dart';

/// Dashboard summary data
class DashboardSummary {
  final StudentData? studentData;
  final List<Course> currentCourses;
  final List<Course> completedCourses;
  final List<Assessment> pendingAssessments;
  final List<Assessment> overdueAssessments;
  final List<Assessment> upcomingAssessments;
  final double gpa;
  final int completedCredits;
  final bool isOnline;
  final DateTime lastUpdated;

  const DashboardSummary({
    required this.studentData,
    required this.currentCourses,
    required this.completedCourses,
    required this.pendingAssessments,
    required this.overdueAssessments,
    required this.upcomingAssessments,
    required this.gpa,
    required this.completedCredits,
    required this.isOnline,
    required this.lastUpdated,
  });

  /// Get total enrolled credits
  int get totalEnrolledCredits {
    return currentCourses.fold(0, (total, course) => total + course.credits);
  }

  /// Get completion percentage based on program requirements
  double get completionPercentage {
    // Assuming 120 credits for a degree (this could be from program info)
    const totalRequiredCredits = 120;
    return (completedCredits / totalRequiredCredits * 100).clamp(0, 100);
  }

  /// Get academic status based on GPA
  String get academicStatus {
    if (gpa >= 3.5) return 'Dean\'s List';
    if (gpa >= 3.0) return 'Good Standing';
    if (gpa >= 2.0) return 'Satisfactory';
    return 'Academic Probation';
  }

  /// Check if student is on track
  bool get isOnTrack {
    return overdueAssessments.isEmpty && gpa >= 2.0;
  }

  /// Get priority alerts
  List<String> get alerts {
    final alerts = <String>[];
    
    if (!isOnline) {
      alerts.add('No internet connection - some data may be outdated');
    }
    
    if (overdueAssessments.isNotEmpty) {
      alerts.add('${overdueAssessments.length} overdue assignment(s)');
    }
    
    if (upcomingAssessments.isNotEmpty) {
      alerts.add('${upcomingAssessments.length} assignment(s) due this week');
    }
    
    if (gpa < 2.0) {
      alerts.add('GPA below minimum requirement');
    }
    
    return alerts;
  }
}

/// Dashboard provider that combines all relevant data
final dashboardProvider = Provider<AsyncValue<DashboardSummary>>((ref) {
  final studentData = ref.watch(studentDataProvider);
  final courses = ref.watch(coursesProvider);
  final assessments = ref.watch(assessmentsProvider);
  final networkStatus = ref.watch(currentNetworkStatusProvider);

  // If any provider is loading, return loading state
  if (studentData.isLoading || courses.isLoading || assessments.isLoading) {
    return const AsyncValue.loading();
  }

  // If any provider has error, return error state
  final errors = [
    if (studentData.hasError) studentData.error!,
    if (courses.hasError) courses.error!,
    if (assessments.hasError) assessments.error!,
  ];

  if (errors.isNotEmpty) {
    return AsyncValue.error(errors.first, StackTrace.current);
  }

  // Combine all data
  final currentCourses = ref.watch(currentCoursesProvider);
  final completedCourses = ref.watch(completedCoursesProvider);
  final pendingAssessments = ref.watch(pendingAssessmentsProvider);
  final overdueAssessments = ref.watch(overdueAssessmentsProvider);
  final upcomingAssessments = ref.watch(upcomingAssessmentsProvider);
  final gpa = ref.watch(gpaProvider);
  final completedCredits = ref.watch(completedCreditsProvider);

  final summary = DashboardSummary(
    studentData: studentData.valueOrNull,
    currentCourses: currentCourses,
    completedCourses: completedCourses,
    pendingAssessments: pendingAssessments,
    overdueAssessments: overdueAssessments,
    upcomingAssessments: upcomingAssessments,
    gpa: gpa,
    completedCredits: completedCredits,
    isOnline: networkStatus == NetworkStatus.online,
    lastUpdated: DateTime.now(),
  );

  return AsyncValue.data(summary);
});

/// Quick stats provider for dashboard cards
final quickStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final dashboard = ref.watch(dashboardProvider);
  
  return dashboard.when(
    data: (summary) => {
      'gpa': summary.gpa,
      'completed_credits': summary.completedCredits,
      'enrolled_credits': summary.totalEnrolledCredits,
      'pending_assessments': summary.pendingAssessments.length,
      'overdue_assessments': summary.overdueAssessments.length,
      'completion_percentage': summary.completionPercentage,
      'academic_status': summary.academicStatus,
      'is_on_track': summary.isOnTrack,
    },
    loading: () => <String, dynamic>{},
    error: (_, __) => <String, dynamic>{},
  );
});

/// Recent activity provider
final recentActivityProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final courses = ref.watch(coursesProvider);
  final assessments = ref.watch(assessmentsProvider);
  
  final activities = <Map<String, dynamic>>[];

  // Add recent course activities
  courses.whenData((courseList) {
    for (final course in courseList) {
      if (course.enrollmentDate != null) {
        activities.add({
          'type': 'enrollment',
          'title': 'Enrolled in ${course.name}',
          'date': course.enrollmentDate!,
          'icon': 'school',
        });
      }
      
      if (course.completionDate != null) {
        activities.add({
          'type': 'completion',
          'title': 'Completed ${course.name}',
          'date': course.completionDate!,
          'icon': 'check_circle',
          'grade': course.grade,
        });
      }
    }
  });

  // Add recent assessment activities
  assessments.whenData((assessmentList) {
    for (final assessment in assessmentList) {
      if (assessment.submissionDate != null) {
        activities.add({
          'type': 'submission',
          'title': 'Submitted ${assessment.title}',
          'date': assessment.submissionDate!,
          'icon': 'assignment_turned_in',
        });
      }
      
      if (assessment.status == 'graded' && assessment.earnedPoints != null) {
        activities.add({
          'type': 'graded',
          'title': 'Grade received for ${assessment.title}',
          'date': DateTime.now(), // This would need to come from API
          'icon': 'grade',
          'score': '${assessment.earnedPoints}/${assessment.totalPoints}',
          'percentage': assessment.gradePercentage,
        });
      }
    }
  });

  // Sort by date (most recent first)
  activities.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
  
  // Return only last 10 activities
  return activities.take(10).toList();
});

/// Academic progress provider
final academicProgressProvider = Provider<Map<String, dynamic>>((ref) {
  final completedCourses = ref.watch(completedCoursesProvider);
  final gpa = ref.watch(gpaProvider);
  final completedCredits = ref.watch(completedCreditsProvider);
  
  // Calculate semester-wise progress
  final semesterProgress = <String, Map<String, dynamic>>{};
  
  for (final course in completedCourses) {
    if (course.completionDate != null) {
      // Extract semester from completion date (simplified)
      final year = course.completionDate!.year;
      final month = course.completionDate!.month;
      final semester = month <= 6 ? 'Spring $year' : 'Fall $year';
      
      semesterProgress[semester] ??= {
        'courses': <Course>[],
        'credits': 0,
        'gpa': 0.0,
      };
      
      (semesterProgress[semester]!['courses'] as List<Course>).add(course);
      semesterProgress[semester]!['credits'] += course.credits;
    }
  }
  
  // Calculate GPA for each semester
  for (final semester in semesterProgress.keys) {
    final courses = semesterProgress[semester]!['courses'] as List<Course>;
    double totalPoints = 0;
    int totalCredits = 0;
    
    for (final course in courses) {
      if (course.grade != null) {
        totalPoints += course.grade! * course.credits;
        totalCredits += course.credits;
      }
    }
    
    semesterProgress[semester]!['gpa'] = totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }
  
  return {
    'overall_gpa': gpa,
    'total_credits': completedCredits,
    'semester_progress': semesterProgress,
    'completion_percentage': (completedCredits / 120 * 100).clamp(0, 100),
  };
});

/// Alerts provider for important notifications
final alertsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final dashboard = ref.watch(dashboardProvider);
  
  return dashboard.when(
    data: (summary) {
      final alerts = <Map<String, dynamic>>[];
      
      for (final alert in summary.alerts) {
        alerts.add({
          'message': alert,
          'type': alert.contains('overdue') 
              ? 'error' 
              : alert.contains('due this week')
                  ? 'warning'
                  : alert.contains('GPA')
                      ? 'error'
                      : 'info',
          'timestamp': DateTime.now(),
        });
      }
      
      return alerts;
    },
    loading: () => [],
    error: (_, __) => [
      {
        'message': 'Failed to load dashboard data',
        'type': 'error',
        'timestamp': DateTime.now(),
      }
    ],
  );
});
