import 'api/api_services.dart';

/// Centralized service that coordinates all API calls and data management
class DataService {
  final StudentApiService _studentApi;
  final CourseApiService _courseApi;
  final AssessmentApiService _assessmentApi;
  final AnalyticsApiService _analyticsApi;
  final CareerApiService _careerApi;
  
  DataService({
    required StudentApiService studentApi,
    required CourseApiService courseApi,
    required AssessmentApiService assessmentApi,
    required AnalyticsApiService analyticsApi,
    required CareerApiService careerApi,
  }) : _studentApi = studentApi,
       _courseApi = courseApi,
       _assessmentApi = assessmentApi,
       _analyticsApi = analyticsApi,
       _careerApi = careerApi;
       
  // Student-related methods
  Future<Map<String, dynamic>> getStudentInfo() => _studentApi.getStudentProfile();
  Future<Map<String, dynamic>> getStudentData() => _studentApi.getStudentProfile();
  Future<Map<String, dynamic>> getProgramInfo() => _studentApi.getStudentProgram();
  Future<List<Map<String, dynamic>>> getEnrollmentHistory() => _studentApi.getEnrollmentHistory();
  
  // Course-related methods
  Future<List<Map<String, dynamic>>> getCourses() => _courseApi.getCourses();
  Future<List<Map<String, dynamic>>> getCoursesData() => _courseApi.getCourses();
  Future<Map<String, dynamic>> getCourseById(String id) => _courseApi.getCourseById(id);
  Future<List<Map<String, dynamic>>> getCoursesBySemester(String semester) => 
      _courseApi.getCoursesBySemester(semester);
  
  // Assessment-related methods
  Future<List<Map<String, dynamic>>> getAssessments() => _assessmentApi.getAssessments();
  Future<List<Map<String, dynamic>>> getRecentAssessments({int limit = 5}) => 
      _assessmentApi.getRecentAssessments(limit: limit);
  Future<Map<String, dynamic>> getAssessmentOverview() => _assessmentApi.getAssessmentOverview();
  Future<List<Map<String, dynamic>>> getAssessmentsByCourse(String courseId) => 
      _assessmentApi.getAssessmentsByCourse(courseId);
  
  // Exam-specific methods
  Future<List<Map<String, dynamic>>> getAllExams() async {
    final assessments = await _assessmentApi.getAssessments();
    return assessments.where((assessment) => 
        assessment['type'].toString().toLowerCase().contains('exam') ||
        assessment['type'].toString().toLowerCase().contains('midterm') ||
        assessment['type'].toString().toLowerCase().contains('final') ||
        assessment['type'].toString().toLowerCase().contains('prelim')
    ).toList();
  }
  
  Future<List<Map<String, dynamic>>> getExamsByCourse(String courseId) async {
    final assessments = await _assessmentApi.getAssessmentsByCourse(courseId);
    return assessments.where((assessment) => 
        assessment['type'].toString().toLowerCase().contains('exam') ||
        assessment['type'].toString().toLowerCase().contains('midterm') ||
        assessment['type'].toString().toLowerCase().contains('final') ||
        assessment['type'].toString().toLowerCase().contains('prelim')
    ).toList();
  }
  
  // Analytics-related methods
  Future<List<Map<String, dynamic>>> getGradeTrends() => _analyticsApi.getGradeTrends();
  Future<Map<String, double>> getPerformanceDistribution() => _analyticsApi.getPerformanceDistribution();
  Future<List<Map<String, dynamic>>> getSubjectPerformance() => _analyticsApi.getSubjectPerformance();
  Future<List<Map<String, dynamic>>> getSkillsProgress() => _analyticsApi.getSkillsProgress();
  
  // Career-related methods
  Future<List<Map<String, dynamic>>> getSkills() => _careerApi.getSkills();
  Future<List<Map<String, dynamic>>> getCareerOpportunities() => _careerApi.getCareerOpportunities();
  Future<Map<String, dynamic>> getCareerProfile() => _careerApi.getCareerProfile();
  Future<Map<String, dynamic>> getCareerOverview() => _careerApi.getCareerOverview();
  Future<Map<String, dynamic>> updateSkill(String skillId, Map<String, dynamic> skillData) => 
      _careerApi.updateSkill(skillId, skillData);
  Future<Map<String, dynamic>> applyToOpportunity(String opportunityId) => 
      _careerApi.applyToOpportunity(opportunityId);
  Future<Map<String, dynamic>> updateCareerProfile(Map<String, dynamic> profileData) => 
      _careerApi.updateCareerProfile(profileData);
  Future<List<Map<String, dynamic>>> getSkillsByCategory(String category) => 
      _careerApi.getSkillsByCategory(category);
  Future<List<Map<String, dynamic>>> getOpportunitiesByType(String type) => 
      _careerApi.getOpportunitiesByType(type);
  
  /// Get formatted assessments for UI display
  Future<List<Map<String, dynamic>>> getUIFormattedAssessments() async {
    final assessments = await getRecentAssessments();
    return assessments.map((assessment) => {
      ...assessment,
      'formattedDate': _formatDate(assessment['date']),
      'statusColor': _getStatusColor(assessment['status']),
      'typeIcon': _getTypeIcon(assessment['type']),
    }).toList();
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
  
  int _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return 0xFF10B981; // Green
      case 'upcoming':
        return 0xFFF59E0B; // Yellow
      case 'missing':
        return 0xFFEF4444; // Red
      default:
        return 0xFF64748B; // Gray
    }
  }
  
  int _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'quiz':
        return 0xe8fd; // Icons.quiz
      case 'exam':
      case 'midterm':
      case 'final':
        return 0xe8e8; // Icons.assignment
      case 'project':
        return 0xe89c; // Icons.folder
      case 'assignment':
        return 0xe1b8; // Icons.description
      default:
        return 0xe873; // Icons.help_outline
    }
  }
}
