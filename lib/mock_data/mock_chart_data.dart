/// Mock data for charts and performance metrics
class MockChartData {
  static List<Map<String, dynamic>> get gradeTrends => [
    {'semester': '1st Yr 1st Sem', 'gwa': 1.85, 'date': DateTime(2022, 8, 1)},
    {'semester': '1st Yr 2nd Sem', 'gwa': 1.82, 'date': DateTime(2023, 1, 1)},
    {'semester': '1st Yr Midyear', 'gwa': 1.75, 'date': DateTime(2023, 6, 1)},
    {'semester': '2nd Yr 2nd Sem', 'gwa': 2.00, 'date': DateTime(2024, 1, 1)},
    {'semester': '3rd Yr 2nd Sem', 'gwa': 1.85, 'date': DateTime(2024, 12, 1)},
  ];

  static Map<String, double> get performanceDistribution => {
    'Excellent (1.00-1.25)': 0.25,
    'Very Good (1.26-1.50)': 0.35,
    'Good (1.51-1.75)': 0.30,
    'Fair (1.76-2.00)': 0.10,
  };

  static List<Map<String, dynamic>> get subjectPerformance => [
    {'subject': 'CS 301', 'grade': 1.5, 'units': 3, 'color': 0xFF2196F3},
    {'subject': 'CS 302', 'grade': 1.75, 'units': 3, 'color': 0xFF4CAF50},
    {'subject': 'CS 303', 'grade': 1.25, 'units': 3, 'color': 0xFFFF9800},
    {'subject': 'MATH 301', 'grade': 2.0, 'units': 3, 'color': 0xFF9C27B0},
    {'subject': 'PE 3', 'grade': 1.0, 'units': 2, 'color': 0xFFE91E63},
    {'subject': 'RIZAL', 'grade': 1.5, 'units': 3, 'color': 0xFF607D8B},
  ];

  static List<Map<String, dynamic>> get monthlyProgress => [
    {'month': 'Jan', 'progress': 65, 'assessments': 8},
    {'month': 'Feb', 'progress': 72, 'assessments': 12},
    {'month': 'Mar', 'progress': 78, 'assessments': 15},
    {'month': 'Apr', 'progress': 85, 'assessments': 18},
    {'month': 'May', 'progress': 88, 'assessments': 22},
    {'month': 'Jun', 'progress': 92, 'assessments': 25},
  ];

  static Map<String, dynamic> get assessmentTypeDistribution => {
    'labels': ['Quizzes', 'Assignments', 'Exams', 'Projects'],
    'data': [40, 25, 20, 15],
    'colors': [0xFF3B82F6, 0xFF10B981, 0xFFF59E0B, 0xFFEF4444],
  };

  static List<Map<String, dynamic>> get skillsProgress => [
    {'skill': 'Programming', 'level': 85, 'color': 0xFF2196F3},
    {'skill': 'Problem Solving', 'level': 78, 'color': 0xFF4CAF50},
    {'skill': 'Database Design', 'level': 72, 'color': 0xFFFF9800},
    {'skill': 'Software Architecture', 'level': 68, 'color': 0xFF9C27B0},
    {'skill': 'Project Management', 'level': 75, 'color': 0xFFE91E63},
    {'skill': 'Communication', 'level': 80, 'color': 0xFF607D8B},
  ];
}
