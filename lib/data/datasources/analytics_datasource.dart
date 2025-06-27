import '../models/assessment_models.dart';
import 'base_datasource.dart';

/// Analytics data source interface
abstract class AnalyticsDataSource {
  /// Get grade trends over time
  Future<List<GradeTrend>> getGradeTrends();
  
  /// Get performance distribution
  Future<Map<String, double>> getPerformanceDistribution();
  
  /// Get subject performance data
  Future<List<Map<String, dynamic>>> getSubjectPerformance();
  
  /// Get monthly progress data
  Future<List<Map<String, dynamic>>> getMonthlyProgress();
  
  /// Get assessment type distribution
  Future<Map<String, dynamic>> getAssessmentTypeDistribution();
  
  /// Get skills progress data
  Future<List<Map<String, dynamic>>> getSkillsProgress();
  
  /// Get comprehensive dashboard data
  Future<Map<String, dynamic>> getDashboardData();
}

/// Analytics API service implementation
class AnalyticsApiService implements AnalyticsDataSource {
  final BaseApiService _apiService;
  
  AnalyticsApiService(this._apiService);
  
  @override
  Future<List<GradeTrend>> getGradeTrends() async {
    final response = await _apiService.get<List<dynamic>>('/charts/grade-trends');
    return response.map((json) => GradeTrend.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<Map<String, double>> getPerformanceDistribution() async {
    return await _apiService.get<Map<String, double>>('/charts/performance-distribution');
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSubjectPerformance() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/charts/subject-performance');
  }
  
  @override
  Future<List<Map<String, dynamic>>> getMonthlyProgress() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/charts/monthly-progress');
  }
  
  @override
  Future<Map<String, dynamic>> getAssessmentTypeDistribution() async {
    return await _apiService.get<Map<String, dynamic>>('/charts/assessment-distribution');
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSkillsProgress() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/charts/skills-progress');
  }
  
  @override
  Future<Map<String, dynamic>> getDashboardData() async {
    return await _apiService.get<Map<String, dynamic>>('/analytics/dashboard');
  }
}

/// Mock analytics data source for development
class MockAnalyticsDataSource implements AnalyticsDataSource {
  static const Duration _mockDelay = Duration(milliseconds: 500);
  
  @override
  Future<List<GradeTrend>> getGradeTrends() async {
    await Future.delayed(_mockDelay);
    
    return [
      GradeTrend(
        semester: '1st Semester 2023-2024',
        gwa: 1.85,
        date: DateTime(2024, 1, 15),
      ),
      GradeTrend(
        semester: '2nd Semester 2023-2024',
        gwa: 1.70,
        date: DateTime(2024, 6, 15),
      ),
      GradeTrend(
        semester: '1st Semester 2024-2025',
        gwa: 1.75,
        date: DateTime(2024, 12, 15),
      ),
    ];
  }
  
  @override
  Future<Map<String, double>> getPerformanceDistribution() async {
    await Future.delayed(_mockDelay);
    
    return {
      'Excellent (1.00-1.25)': 25.0,
      'Very Good (1.26-1.75)': 45.0,
      'Good (1.76-2.25)': 20.0,
      'Satisfactory (2.26-2.75)': 8.0,
      'Fair (2.76-3.00)': 2.0,
    };
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSubjectPerformance() async {
    await Future.delayed(_mockDelay);
    
    return [
      {
        'subject': 'Computer Science',
        'average': 1.65,
        'trend': 'improving',
        'courses': 5,
      },
      {
        'subject': 'Mathematics',
        'average': 1.75,
        'trend': 'stable',
        'courses': 3,
      },
      {
        'subject': 'Physics',
        'average': 2.00,
        'trend': 'declining',
        'courses': 2,
      },
      {
        'subject': 'General Education',
        'average': 1.50,
        'trend': 'improving',
        'courses': 4,
      },
    ];
  }
  
  @override
  Future<List<Map<String, dynamic>>> getMonthlyProgress() async {
    await Future.delayed(_mockDelay);
    
    return [
      {'month': 'August', 'progress': 20.0, 'assessments': 3},
      {'month': 'September', 'progress': 40.0, 'assessments': 5},
      {'month': 'October', 'progress': 65.0, 'assessments': 4},
      {'month': 'November', 'progress': 85.0, 'assessments': 6},
      {'month': 'December', 'progress': 95.0, 'assessments': 2},
    ];
  }
  
  @override
  Future<Map<String, dynamic>> getAssessmentTypeDistribution() async {
    await Future.delayed(_mockDelay);
    
    return {
      'types': {
        'Quizzes': 40.0,
        'Assignments': 30.0,
        'Exams': 20.0,
        'Projects': 10.0,
      },
      'performance': {
        'Quizzes': 85.5,
        'Assignments': 88.2,
        'Exams': 82.1,
        'Projects': 91.3,
      },
    };
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSkillsProgress() async {
    await Future.delayed(_mockDelay);
    
    return [
      {
        'skill': 'Programming',
        'level': 85.0,
        'progress': 15.0,
        'category': 'Technical',
      },
      {
        'skill': 'Problem Solving',
        'level': 90.0,
        'progress': 10.0,
        'category': 'Analytical',
      },
      {
        'skill': 'Mathematics',
        'level': 78.0,
        'progress': 12.0,
        'category': 'Academic',
      },
      {
        'skill': 'Communication',
        'level': 82.0,
        'progress': 8.0,
        'category': 'Soft Skills',
      },
    ];
  }
  
  @override
  Future<Map<String, dynamic>> getDashboardData() async {
    await Future.delayed(_mockDelay);
    
    return {
      'summary': {
        'currentGwa': 1.75,
        'semesterProgress': 85.0,
        'totalCredits': 21,
        'completedAssessments': 12,
        'upcomingDeadlines': 3,
      },
      'recentActivity': [
        {
          'type': 'assessment_completed',
          'title': 'CS101 Quiz 3',
          'score': 85,
          'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        },
        {
          'type': 'grade_updated',
          'title': 'MATH201 Assignment 2',
          'score': 92,
          'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        },
      ],
      'alerts': [
        {
          'type': 'deadline_approaching',
          'message': 'Physics assignment due in 2 days',
          'priority': 'medium',
        },
      ],
    };
  }
}
