import '../datasources/analytics_datasource.dart';
import 'base_repository.dart';

/// Analytics repository interface
abstract class AnalyticsRepository {
  /// Get grade trends over time
  Future<RepositoryResult<List<Map<String, dynamic>>>> getGradeTrends();
  
  /// Get performance distribution
  Future<RepositoryResult<Map<String, double>>> getPerformanceDistribution();
  
  /// Get subject performance data
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSubjectPerformance();
  
  /// Get monthly progress data
  Future<RepositoryResult<List<Map<String, dynamic>>>> getMonthlyProgress();
  
  /// Get assessment type distribution
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentTypeDistribution();
  
  /// Get skills progress data
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsProgress();
  
  /// Get comprehensive dashboard data
  Future<RepositoryResult<Map<String, dynamic>>> getDashboardData();
}

/// Implementation of AnalyticsRepository
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsApiService _analyticsDataSource;
  
  AnalyticsRepositoryImpl(this._analyticsDataSource);
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getGradeTrends() async {
    try {
      final gradeTrends = await _analyticsDataSource.getGradeTrends();
      final data = gradeTrends.map((trend) => trend.toJson()).toList();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch grade trends: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, double>>> getPerformanceDistribution() async {
    try {
      final data = await _analyticsDataSource.getPerformanceDistribution();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch performance distribution: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSubjectPerformance() async {
    try {
      final data = await _analyticsDataSource.getSubjectPerformance();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch subject performance: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getMonthlyProgress() async {
    try {
      final data = await _analyticsDataSource.getMonthlyProgress();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch monthly progress: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentTypeDistribution() async {
    try {
      final data = await _analyticsDataSource.getAssessmentTypeDistribution();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch assessment type distribution: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsProgress() async {
    try {
      final data = await _analyticsDataSource.getSkillsProgress();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch skills progress: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getDashboardData() async {
    try {
      final data = await _analyticsDataSource.getDashboardData();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch dashboard data: ${e.toString()}');
    }
  }
}

/// Mock implementation of AnalyticsRepository for testing
class MockAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getGradeTrends() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final mockTrends = [
      {'month': 'Jan', 'grade': 85.0},
      {'month': 'Feb', 'grade': 88.0},
      {'month': 'Mar', 'grade': 92.0},
      {'month': 'Apr', 'grade': 87.0},
      {'month': 'May', 'grade': 90.0},
    ];
    
    return RepositoryResult.success(mockTrends);
  }
  
  @override
  Future<RepositoryResult<Map<String, double>>> getPerformanceDistribution() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final mockDistribution = {
      'A': 0.25,
      'B': 0.35,
      'C': 0.25,
      'D': 0.10,
      'F': 0.05,
    };
    
    return RepositoryResult.success(mockDistribution);
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSubjectPerformance() async {
    await Future.delayed(const Duration(milliseconds: 450));
    
    final mockPerformance = [
      {'subject': 'Computer Science', 'score': 92.0, 'trend': 'up'},
      {'subject': 'Mathematics', 'score': 88.0, 'trend': 'stable'},
      {'subject': 'Physics', 'score': 85.0, 'trend': 'down'},
      {'subject': 'English', 'score': 90.0, 'trend': 'up'},
    ];
    
    return RepositoryResult.success(mockPerformance);
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getMonthlyProgress() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final mockProgress = [
      {'month': 'Jan', 'progress': 75.0, 'target': 80.0},
      {'month': 'Feb', 'progress': 78.0, 'target': 80.0},
      {'month': 'Mar', 'progress': 85.0, 'target': 80.0},
      {'month': 'Apr', 'progress': 82.0, 'target': 85.0},
      {'month': 'May', 'progress': 88.0, 'target': 85.0},
    ];
    
    return RepositoryResult.success(mockProgress);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getAssessmentTypeDistribution() async {
    await Future.delayed(const Duration(milliseconds: 350));
    
    final mockDistribution = {
      'exams': 40,
      'assignments': 35,
      'quizzes': 20,
      'projects': 5,
    };
    
    return RepositoryResult.success(mockDistribution);
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsProgress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final mockSkills = [
      {'skill': 'Programming', 'level': 85, 'progress': 12},
      {'skill': 'Problem Solving', 'level': 78, 'progress': 8},
      {'skill': 'Data Analysis', 'level': 72, 'progress': 15},
      {'skill': 'Communication', 'level': 88, 'progress': 5},
    ];
    
    return RepositoryResult.success(mockSkills);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final mockDashboard = {
      'overallGPA': 3.7,
      'currentSemesterGPA': 3.8,
      'totalCredits': 45,
      'completedCourses': 12,
      'currentCourses': 5,
      'upcomingDeadlines': 3,
      'recentGradeAverage': 87.5,
      'progressTowardsGraduation': 65.0,
    };
    
    return RepositoryResult.success(mockDashboard);
  }
}
