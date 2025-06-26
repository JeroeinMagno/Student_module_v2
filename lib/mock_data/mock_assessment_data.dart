/// Mock data for assessments and exams
class MockAssessmentData {
  static List<Map<String, dynamic>> get assessments => [
    {
      'id': 'exam_001',
      'courseId': 'cs301',
      'courseCode': 'CS 301',
      'courseName': 'Data Structures and Algorithms',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'dueDate': DateTime.now().subtract(const Duration(days: 5)),
      'score': 85,
      'maxScore': 100,
      'percentage': 85.0,
      'status': 'completed',
      'grade': 1.5,
      'weight': 30,
    },
    {
      'id': 'quiz_001',
      'courseId': 'cs302',
      'courseCode': 'CS 302',
      'courseName': 'Database Systems',
      'type': 'Quiz',
      'title': 'SQL Basics Quiz',
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'dueDate': DateTime.now().subtract(const Duration(days: 10)),
      'score': 92,
      'maxScore': 100,
      'percentage': 92.0,
      'status': 'completed',
      'grade': 1.25,
      'weight': 10,
    },
    {
      'id': 'assignment_001',
      'courseId': 'cs303',
      'courseCode': 'CS 303',
      'courseName': 'Software Engineering',
      'type': 'Assignment',
      'title': 'Requirements Analysis Document',
      'date': DateTime.now().add(const Duration(days: 7)),
      'dueDate': DateTime.now().add(const Duration(days: 7)),
      'score': null,
      'maxScore': 100,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 20,
    },
    {
      'id': 'exam_002',
      'courseId': 'math301',
      'courseCode': 'MATH 301',
      'courseName': 'Discrete Mathematics',
      'type': 'Prelim',
      'title': 'Preliminary Examination',
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'dueDate': DateTime.now().subtract(const Duration(days: 15)),
      'score': 78,
      'maxScore': 100,
      'percentage': 78.0,
      'status': 'completed',
      'grade': 2.0,
      'weight': 25,
    },
    {
      'id': 'project_001',
      'courseId': 'cs303',
      'courseCode': 'CS 303',
      'courseName': 'Software Engineering',
      'type': 'Project',
      'title': 'Mobile App Development',
      'date': DateTime.now().add(const Duration(days: 21)),
      'dueDate': DateTime.now().add(const Duration(days: 21)),
      'score': null,
      'maxScore': 100,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 40,
    },
  ];

  static Map<String, dynamic> get assessmentOverview => {
    'totalAssessments': assessments.length,
    'completedAssessments': assessments.where((a) => a['status'] == 'completed').length,
    'upcomingAssessments': assessments.where((a) => a['status'] == 'upcoming').length,
    'averageScore': _calculateAverageScore(),
    'highestScore': _getHighestScore(),
    'lowestScore': _getLowestScore(),
  };

  static double _calculateAverageScore() {
    final completedAssessments = assessments.where((a) => a['status'] == 'completed').toList();
    if (completedAssessments.isEmpty) return 0.0;
    
    final totalScore = completedAssessments.fold<double>(
      0.0, 
      (sum, assessment) => sum + (assessment['percentage'] ?? 0.0),
    );
    
    return totalScore / completedAssessments.length;
  }

  static double _getHighestScore() {
    final completedAssessments = assessments.where((a) => a['status'] == 'completed').toList();
    if (completedAssessments.isEmpty) return 0.0;
    
    return completedAssessments.fold<double>(
      0.0,
      (max, assessment) => (assessment['percentage'] ?? 0.0) > max ? assessment['percentage'] : max,
    );
  }

  static double _getLowestScore() {
    final completedAssessments = assessments.where((a) => a['status'] == 'completed').toList();
    if (completedAssessments.isEmpty) return 0.0;
    
    return completedAssessments.fold<double>(
      100.0,
      (min, assessment) => (assessment['percentage'] ?? 100.0) < min ? assessment['percentage'] : min,
    );
  }

  static List<Map<String, dynamic>> getAssessmentsByCourse(String courseId) {
    return assessments.where((assessment) => assessment['courseId'] == courseId).toList();
  }

  static List<Map<String, dynamic>> getRecentAssessments({int limit = 5}) {
    final sortedAssessments = List<Map<String, dynamic>>.from(assessments);
    sortedAssessments.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
    return sortedAssessments.take(limit).toList();
  }
}
