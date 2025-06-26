/// Mock data for exams
class MockExamData {
  static List<Map<String, dynamic>> get exams => [
    {
      'id': 'exam_cs301_midterm',
      'courseId': 'cs301',
      'courseCode': 'CS 301',
      'courseName': 'Data Structures and Algorithms',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime(2025, 6, 15),
      'dueDate': DateTime(2025, 6, 15),
      'score': 85.0,
      'maxScore': 100.0,
      'percentage': 85.0,
      'status': 'completed',
      'grade': 1.5,
      'weight': 30,
    },
    {
      'id': 'exam_cs301_final',
      'courseId': 'cs301',
      'courseCode': 'CS 301',
      'courseName': 'Data Structures and Algorithms',
      'type': 'Final',
      'title': 'Final Examination',
      'date': DateTime(2025, 7, 20),
      'dueDate': DateTime(2025, 7, 20),
      'score': null,
      'maxScore': 100.0,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 40,
    },
    {
      'id': 'exam_cs302_midterm',
      'courseId': 'cs302',
      'courseCode': 'CS 302',
      'courseName': 'Database Systems',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime(2025, 6, 18),
      'dueDate': DateTime(2025, 6, 18),
      'score': 92.0,
      'maxScore': 100.0,
      'percentage': 92.0,
      'status': 'completed',
      'grade': 1.25,
      'weight': 30,
    },
    {
      'id': 'exam_cs302_final',
      'courseId': 'cs302',
      'courseCode': 'CS 302',
      'courseName': 'Database Systems',
      'type': 'Final',
      'title': 'Final Examination',
      'date': DateTime(2025, 7, 25),
      'dueDate': DateTime(2025, 7, 25),
      'score': null,
      'maxScore': 100.0,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 40,
    },
    {
      'id': 'exam_cs303_midterm',
      'courseId': 'cs303',
      'courseCode': 'CS 303',
      'courseName': 'Software Engineering',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime(2025, 6, 22),
      'dueDate': DateTime(2025, 6, 22),
      'score': 78.0,
      'maxScore': 100.0,
      'percentage': 78.0,
      'status': 'completed',
      'grade': 2.0,
      'weight': 25,
    },
    {
      'id': 'exam_cs303_final',
      'courseId': 'cs303',
      'courseCode': 'CS 303',
      'courseName': 'Software Engineering',
      'type': 'Final',
      'title': 'Final Examination',
      'date': DateTime(2025, 7, 28),
      'dueDate': DateTime(2025, 7, 28),
      'score': null,
      'maxScore': 100.0,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 35,
    },
    {
      'id': 'exam_math201_midterm',
      'courseId': 'math201',
      'courseCode': 'MATH 201',
      'courseName': 'Advanced Mathematics',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime(2025, 6, 20),
      'dueDate': DateTime(2025, 6, 20),
      'score': 88.0,
      'maxScore': 100.0,
      'percentage': 88.0,
      'status': 'completed',
      'grade': 1.5,
      'weight': 30,
    },
    {
      'id': 'exam_math201_final',
      'courseId': 'math201',
      'courseCode': 'MATH 201',
      'courseName': 'Advanced Mathematics',
      'type': 'Final',
      'title': 'Final Examination',
      'date': DateTime(2025, 7, 30),
      'dueDate': DateTime(2025, 7, 30),
      'score': null,
      'maxScore': 100.0,
      'percentage': null,
      'status': 'upcoming',
      'grade': null,
      'weight': 40,
    },
    {
      'id': 'exam_pe101_practical',
      'courseId': 'pe101',
      'courseCode': 'PE 101',
      'courseName': 'Physical Education',
      'type': 'Practical',
      'title': 'Practical Examination',
      'date': DateTime(2025, 6, 12),
      'dueDate': DateTime(2025, 6, 12),
      'score': 95.0,
      'maxScore': 100.0,
      'percentage': 95.0,
      'status': 'completed',
      'grade': 1.0,
      'weight': 50,
    },
    {
      'id': 'exam_rizal_midterm',
      'courseId': 'rizal',
      'courseCode': 'RIZAL',
      'courseName': 'Life and Works of Rizal',
      'type': 'Midterm',
      'title': 'Midterm Examination',
      'date': DateTime(2025, 6, 25),
      'dueDate': DateTime(2025, 6, 25),
      'score': 87.0,
      'maxScore': 100.0,
      'percentage': 87.0,
      'status': 'completed',
      'grade': 1.5,
      'weight': 30,
    },
    {
      'id': 'exam_rizal_final',
      'courseId': 'rizal',
      'courseCode': 'RIZAL',
      'courseName': 'Life and Works of Rizal',
      'type': 'Final',
      'title': 'Final Examination',
      'date': DateTime(2025, 7, 15),
      'dueDate': DateTime(2025, 7, 15),
      'score': null,
      'maxScore': 100.0,
      'percentage': null,
      'status': 'missing',
      'grade': null,
      'weight': 40,
    },
  ];

  /// Get exam overview statistics
  static Map<String, dynamic> get examOverview {
    final total = exams.length;
    final completed = exams.where((exam) => exam['status'] == 'completed').length;
    final upcoming = exams.where((exam) => exam['status'] == 'upcoming').length;
    final missing = exams.where((exam) => exam['status'] == 'missing').length;

    final completedExams = exams.where((exam) => exam['status'] == 'completed' && exam['percentage'] != null);
    double averageScore = 0.0;
    if (completedExams.isNotEmpty) {
      averageScore = completedExams.fold<double>(0.0, (sum, exam) => sum + exam['percentage']) / completedExams.length;
    }

    return {
      'total': total,
      'completed': completed,
      'upcoming': upcoming,
      'missing': missing,
      'averageScore': averageScore,
    };
  }

  /// Get exams by course ID
  static List<Map<String, dynamic>> getExamsByCourse(String courseId) {
    return exams.where((exam) => exam['courseId'] == courseId).toList();
  }

  /// Get exams by status
  static List<Map<String, dynamic>> getExamsByStatus(String status) {
    return exams.where((exam) => exam['status'] == status).toList();
  }

  /// Get recent exams (sorted by date)
  static List<Map<String, dynamic>> getRecentExams({int limit = 5}) {
    final sortedExams = List<Map<String, dynamic>>.from(exams);
    sortedExams.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
    return sortedExams.take(limit).toList();
  }
}
