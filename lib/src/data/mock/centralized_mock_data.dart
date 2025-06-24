/// Centralized Mock Data for Student Module
/// This file contains all mock data for a single test user
/// This data will be replaced when backend API endpoints are ready

class CentralizedMockData {
  // Test User ID for all data
  static const String testUserId = 'test_user_001';
  
  // Test User Basic Information
  static const Map<String, dynamic> testUserInfo = {
    'id': testUserId,
    'name': 'John Doe',
    'srCode': '22-12345',
    'email': 'john.doe@student.bsu.edu.ph',
    'avatar': 'https://randomuser.me/api/portraits/men/75.jpg',
    'yearLevel': '3rd Year',
    'program': 'Bachelor of Science in Computer Science',
    'college': 'College of Engineering and Information Technology',
    'semester': '2nd Semester',
    'academicYear': '2024-2025',
    'gpa': 3.75,
    'units': 21,
    'status': 'Regular',
  };

  // Test User's Enrolled Courses
  static const List<Map<String, dynamic>> testUserCourses = [
    {
      'id': 'cs101',
      'code': 'CS 101',
      'title': 'Introduction to Computer Science',
      'description': 'An introduction to computer science concepts including programming fundamentals, problem-solving techniques, and computational thinking.',
      'instructor': 'Prof. Jane Doe',
      'units': 3,
      'schedule': 'MWF 8:00-9:00 AM',
      'room': 'CIT 201',
      'progress': 75,
      'currentGrade': 'A-',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Exam',
          'date': '2025-07-01',
          'percentage': 30,
          'status': 'missing',
          'score': null,
        },
        {
          'title': 'Final Exam',
          'date': '2025-08-20',
          'percentage': 40,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
    {
      'id': 'math201',
      'code': 'MATH 201',
      'title': 'Discrete Mathematics',
      'description': 'Covers logic, set theory, relations, functions, combinatorics, and graph theory essential for computer science.',
      'instructor': 'Dr. John Smith',
      'units': 3,
      'schedule': 'TTh 10:00-11:30 AM',
      'room': 'MATH 105',
      'progress': 45,
      'currentGrade': 'B+',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Exam',
          'date': '2025-06-25',
          'percentage': 25,
          'status': 'completed',
          'score': 88,
        },
        {
          'title': 'Final Exam',
          'date': '2025-08-15',
          'percentage': 35,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
    {
      'id': 'it310',
      'code': 'IT 310',
      'title': 'Web Development',
      'description': 'A hands-on web development course covering HTML, CSS, JavaScript, and modern web frameworks.',
      'instructor': 'Engr. Lance Ramos',
      'units': 3,
      'schedule': 'MWF 1:00-2:30 PM',
      'room': 'CIT Lab 1',
      'progress': 90,
      'currentGrade': 'A',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Practical Exam',
          'date': '2025-06-22',
          'percentage': 20,
          'status': 'completed',
          'score': 96,
        },
        {
          'title': 'Final Project Defense',
          'date': '2025-08-10',
          'percentage': 30,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
    {
      'id': 'phy201',
      'code': 'PHY 201',
      'title': 'Physics II',
      'description': 'Advanced physics concepts including electromagnetism, waves, optics, and modern physics.',
      'instructor': 'Dr. Maria Garcia',
      'units': 4,
      'schedule': 'TTh 8:00-9:30 AM, Lab: F 2:00-5:00 PM',
      'room': 'SCI 301, Lab: PHY Lab 2',
      'progress': 60,
      'currentGrade': 'B',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Exam',
          'date': '2025-06-28',
          'percentage': 25,
          'status': 'completed',
          'score': 85,
        },
        {
          'title': 'Final Exam',
          'date': '2025-08-18',
          'percentage': 35,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
    {
      'id': 'eng101',
      'code': 'ENG 101',
      'title': 'Technical Writing',
      'description': 'Develops technical writing skills essential for professional communication in technology fields.',
      'instructor': 'Prof. Sarah Johnson',
      'units': 3,
      'schedule': 'MWF 10:00-11:00 AM',
      'room': 'ENG 204',
      'progress': 85,
      'currentGrade': 'A-',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Portfolio',
          'date': '2025-06-20',
          'percentage': 20,
          'status': 'completed',
          'score': 92,
        },
        {
          'title': 'Final Research Paper',
          'date': '2025-08-12',
          'percentage': 30,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
    {
      'id': 'hist101',
      'code': 'HIST 101',
      'title': 'Philippine History',
      'description': 'Comprehensive study of Philippine history from pre-colonial times to the present.',
      'instructor': 'Dr. Ramon Santos',
      'units': 3,
      'schedule': 'TTh 1:00-2:30 PM',
      'room': 'HIST 102',
      'progress': 70,
      'currentGrade': 'B+',
      'status': 'Active',
      'exams': [
        {
          'title': 'Midterm Exam',
          'date': '2025-06-30',
          'percentage': 30,
          'status': 'completed',
          'score': 87,
        },
        {
          'title': 'Final Exam',
          'date': '2025-08-25',
          'percentage': 40,
          'status': 'upcoming',
          'score': null,
        },
      ],
    },
  ];
  // Test User's Assessment History (Recent and Upcoming)
  static const List<Map<String, dynamic>> testUserAssessments = [
    // Recent Completed Assessments
    {
      'id': 'assess_001',
      'subject': 'Web Development',
      'grade': 'A',
      'score': '96%',
      'numericScore': 96.0,
      'date': '2025-06-22',
      'type': 'Midterm Practical Exam',
      'courseCode': 'IT 310',
      'courseId': 'it310',
      'status': 'completed',
      'weight': 20,
    },
    {
      'id': 'assess_002',
      'subject': 'Technical Writing',
      'grade': 'A-',
      'score': '92%',
      'numericScore': 92.0,
      'date': '2025-06-20',
      'type': 'Midterm Portfolio',
      'courseCode': 'ENG 101',
      'courseId': 'eng101',
      'status': 'completed',
      'weight': 20,
    },
    {
      'id': 'assess_003',
      'subject': 'Philippine History',
      'grade': 'B+',
      'score': '87%',
      'numericScore': 87.0,
      'date': '2025-06-30',
      'type': 'Midterm Exam',
      'courseCode': 'HIST 101',
      'courseId': 'hist101',
      'status': 'completed',
      'weight': 30,
    },
    {
      'id': 'assess_004',
      'subject': 'Physics II',
      'grade': 'B',
      'score': '85%',
      'numericScore': 85.0,
      'date': '2025-06-28',
      'type': 'Midterm Exam',
      'courseCode': 'PHY 201',
      'courseId': 'phy201',
      'status': 'completed',
      'weight': 25,
    },
    {
      'id': 'assess_005',
      'subject': 'Discrete Mathematics',
      'grade': 'B+',
      'score': '88%',
      'numericScore': 88.0,
      'date': '2025-06-25',
      'type': 'Midterm Exam',
      'courseCode': 'MATH 201',
      'courseId': 'math201',
      'status': 'completed',
      'weight': 25,
    },
    // Missing Assessments
    {
      'id': 'assess_006',
      'subject': 'Introduction to Computer Science',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-07-01',
      'type': 'Midterm Exam',
      'courseCode': 'CS 101',
      'courseId': 'cs101',
      'status': 'missing',
      'weight': 30,
    },
    // Upcoming Assessments
    {
      'id': 'assess_007',
      'subject': 'Web Development',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-10',
      'type': 'Final Project Defense',
      'courseCode': 'IT 310',
      'courseId': 'it310',
      'status': 'upcoming',
      'weight': 30,
    },
    {
      'id': 'assess_008',
      'subject': 'Technical Writing',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-12',
      'type': 'Final Research Paper',
      'courseCode': 'ENG 101',
      'courseId': 'eng101',
      'status': 'upcoming',
      'weight': 30,
    },
    {
      'id': 'assess_009',
      'subject': 'Discrete Mathematics',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-15',
      'type': 'Final Exam',
      'courseCode': 'MATH 201',
      'courseId': 'math201',
      'status': 'upcoming',
      'weight': 35,
    },
    {
      'id': 'assess_010',
      'subject': 'Physics II',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-18',
      'type': 'Final Exam',
      'courseCode': 'PHY 201',
      'courseId': 'phy201',
      'status': 'upcoming',
      'weight': 35,
    },
    {
      'id': 'assess_011',
      'subject': 'Introduction to Computer Science',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-20',
      'type': 'Final Exam',
      'courseCode': 'CS 101',
      'courseId': 'cs101',
      'status': 'upcoming',
      'weight': 40,
    },
    {
      'id': 'assess_012',
      'subject': 'Philippine History',
      'grade': null,
      'score': null,
      'numericScore': null,
      'date': '2025-08-25',
      'type': 'Final Exam',
      'courseCode': 'HIST 101',
      'courseId': 'hist101',
      'status': 'upcoming',
      'weight': 40,
    },
  ];
  // Test User's Performance Analytics
  static const Map<String, dynamic> testUserPerformance = {
    'distribution': {
      'excellent': 25.0, // 90-100% (2 out of 8 assessments)
      'good': 37.5,      // 80-89% (3 out of 8 assessments)
      'average': 0.0,    // 70-79% (0 out of 8 assessments)
      'poor': 0.0,       // Below 70% (0 out of 8 assessments)
      'pending': 37.5,   // Missing/Upcoming (3 out of 8 assessments)
    },
    'gradeTrends': [
      {'month': 'January', 'gpa': 3.2},
      {'month': 'February', 'gpa': 3.5},
      {'month': 'March', 'gpa': 3.1},
      {'month': 'April', 'gpa': 3.8},
      {'month': 'May', 'gpa': 3.6},
      {'month': 'June', 'gpa': 3.9},
    ],
    'monthlyScores': [
      {'month': 'January', 'desktop': 78.0},
      {'month': 'February', 'desktop': 82.0},
      {'month': 'March', 'desktop': 75.0},
      {'month': 'April', 'desktop': 85.0},
      {'month': 'May', 'desktop': 88.0},
      {'month': 'June', 'desktop': 89.6}, // Average of June assessments
    ],
    'recentAverage': 89.6, // Average of recent completed assessments
    'overallGPA': 3.75,
    'totalAssessments': 12,
    'completedAssessments': 5,
    'upcomingAssessments': 6,
    'missedAssessments': 1,
  };

  // Test User's Course Topics and Learning Outcomes
  static const List<Map<String, dynamic>> testCourseTopics = [
    {
      'week': '1',
      'topic': 'Introduction to Course',
      'ilo': ['1'],
      'so': ['1', '2'],
      'status': 'completed',
    },
    {
      'week': '2-3',
      'topic': 'Fundamentals of Programming',
      'ilo': ['1', '2'],
      'so': ['1', '3'],
      'status': 'completed',
    },
    {
      'week': '4',
      'topic': 'Data Structures',
      'ilo': ['1'],
      'so': ['3', '4'],
      'status': 'completed',
    },
    {
      'week': '5-6',
      'topic': 'Algorithms',
      'ilo': ['3'],
      'so': ['4'],
      'status': 'current',
    },
    {
      'week': '7-8',
      'topic': 'Advanced Algorithms',
      'ilo': ['3', '4'],
      'so': ['6'],
      'status': 'upcoming',
    },
    {
      'week': '9',
      'topic': 'Software Engineering Principles',
      'ilo': ['1', '5'],
      'so': ['7'],
      'status': 'upcoming',
    },
  ];

  // Intended Learning Outcomes
  static const List<Map<String, dynamic>> testLearningOutcomes = [
    {
      'ilo': 'ILO1',
      'description': 'Understand the fundamentals of programming and computer science.',
      'achieved': true,
    },
    {
      'ilo': 'ILO2',
      'description': 'Apply data structures and algorithms to solve problems.',
      'achieved': true,
    },
    {
      'ilo': 'ILO3',
      'description': 'Design and analyze efficient algorithms.',
      'achieved': false,
    },
    {
      'ilo': 'ILO4',
      'description': 'Demonstrate knowledge of advanced algorithms and software engineering principles.',
      'achieved': false,
    },
    {
      'ilo': 'ILO5',
      'description': 'Communicate technical information effectively.',
      'achieved': true,
    },
  ];

  // Assessment Criteria Progress
  static const List<Map<String, dynamic>> testAssessmentCriteria = [
    {'name': 'Attendance', 'accomplished': true, 'score': 95},
    {'name': 'Quiz 1', 'accomplished': true, 'score': 88},
    {'name': 'Quiz 2', 'accomplished': true, 'score': 92},
    {'name': 'Midterms', 'accomplished': true, 'score': 85},
    {'name': 'Project', 'accomplished': true, 'score': 96},
    {'name': 'Finals', 'accomplished': false, 'score': null},
  ];

  // Career Guidance Data
  static const List<Map<String, dynamic>> careerPaths = [
    {
      'title': 'Software Engineering',
      'description': 'Build innovative software solutions',
      'icon': 'computer',
      'skills': ['Programming', 'Problem Solving', 'System Design'],
      'averageSalary': '₱80,000 - ₱150,000',
      'growthRate': 'High',
      'matchPercentage': 95,
    },
    {
      'title': 'Data Science',
      'description': 'Analyze and interpret complex data',
      'icon': 'analytics',
      'skills': ['Statistics', 'Machine Learning', 'Data Visualization'],
      'averageSalary': '₱70,000 - ₱130,000',
      'growthRate': 'Very High',
      'matchPercentage': 85,
    },
    {
      'title': 'Product Management',
      'description': 'Lead product development initiatives',
      'icon': 'inventory',
      'skills': ['Strategy', 'Communication', 'Market Analysis'],
      'averageSalary': '₱90,000 - ₱180,000',
      'growthRate': 'High',
      'matchPercentage': 70,
    },
    {
      'title': 'UX/UI Design',
      'description': 'Create intuitive user experiences',
      'icon': 'design_services',
      'skills': ['Design Thinking', 'Prototyping', 'User Research'],
      'averageSalary': '₱60,000 - ₱120,000',
      'growthRate': 'High',
      'matchPercentage': 60,
    },
    {
      'title': 'Cybersecurity',
      'description': 'Protect digital assets and systems',
      'icon': 'security',
      'skills': ['Security Protocols', 'Risk Assessment', 'Incident Response'],
      'averageSalary': '₱85,000 - ₱160,000',
      'growthRate': 'Very High',
      'matchPercentage': 75,
    },
    {
      'title': 'Cloud Architecture',
      'description': 'Design and manage cloud infrastructure',
      'icon': 'cloud',
      'skills': ['Cloud Platforms', 'DevOps', 'Infrastructure Management'],
      'averageSalary': '₱100,000 - ₱200,000',
      'growthRate': 'Very High',
      'matchPercentage': 80,
    },
  ];

  // Utility methods to get all user data
  static Map<String, dynamic> getAllUserData() {
    return {
      'userInfo': testUserInfo,
      'courses': testUserCourses,
      'assessments': testUserAssessments,
      'performance': testUserPerformance,
      'topics': testCourseTopics,
      'learningOutcomes': testLearningOutcomes,
      'assessmentCriteria': testAssessmentCriteria,
      'careerPaths': careerPaths,
    };
  }

  // Get data by category
  static Map<String, dynamic> getUserInfo() => testUserInfo;
  static List<Map<String, dynamic>> getUserCourses() => testUserCourses;
  static List<Map<String, dynamic>> getUserAssessments() => testUserAssessments;
  static Map<String, dynamic> getUserPerformance() => testUserPerformance;
  static List<Map<String, dynamic>> getCourseTopics() => testCourseTopics;
  static List<Map<String, dynamic>> getLearningOutcomes() => testLearningOutcomes;
  static List<Map<String, dynamic>> getAssessmentCriteria() => testAssessmentCriteria;
  static List<Map<String, dynamic>> getCareerPaths() => careerPaths;

  // Get specific course data
  static Map<String, dynamic>? getCourseById(String courseId) {
    try {
      return testUserCourses.firstWhere((course) => course['id'] == courseId);
    } catch (e) {
      return null;
    }
  }

  // Get assessments for specific course
  static List<Map<String, dynamic>> getAssessmentsByCourse(String courseId) {
    return testUserAssessments
        .where((assessment) => assessment['courseId'] == courseId)
        .toList();
  }
  // Get flattened exam data
  static List<Map<String, dynamic>> getAllExams() {
    List<Map<String, dynamic>> allExams = [];

    for (var course in testUserCourses) {
      final courseExams = course['exams'] as List<dynamic>? ?? [];
      for (var exam in courseExams) {
        allExams.add({
          'courseId': course['id'],
          'courseCode': course['code'],
          'courseTitle': course['title'],
          'title': exam['title'],
          'date': exam['date'],
          'percentage': exam['percentage'],
          'status': exam['status'],
          'score': exam['score'],
        });
      }
    }

    return allExams;
  }

  // Get assessments formatted for UI Assessment model
  static List<Map<String, dynamic>> getUIFormattedAssessments() {
    return testUserAssessments.map((assessment) {
      return {
        'courseCode': assessment['courseCode'],
        'type': assessment['type'],
        'date': assessment['date'],
        'status': assessment['status'],
        'score': assessment['numericScore'],
      };
    }).toList();
  }

  // Get recent assessments (last 5)
  static List<Map<String, dynamic>> getRecentAssessments() {
    final sortedAssessments = List<Map<String, dynamic>>.from(testUserAssessments);
    sortedAssessments.sort((a, b) => b['date'].compareTo(a['date']));
    return sortedAssessments.take(5).toList();
  }

  // Get completed assessments only
  static List<Map<String, dynamic>> getCompletedAssessments() {
    return testUserAssessments
        .where((assessment) => assessment['status'] == 'completed')
        .toList();
  }

  // Get upcoming assessments only
  static List<Map<String, dynamic>> getUpcomingAssessments() {
    return testUserAssessments
        .where((assessment) => assessment['status'] == 'upcoming')
        .toList();
  }

  // Get missing assessments only
  static List<Map<String, dynamic>> getMissedAssessments() {
    return testUserAssessments
        .where((assessment) => assessment['status'] == 'missing')
        .toList();
  }

  // Get assessment overview data for charts
  static Map<String, dynamic> getAssessmentOverview() {
    final completed = getCompletedAssessments();
    final upcoming = getUpcomingAssessments();
    final missed = getMissedAssessments();

    return {
      'totalAssessments': testUserAssessments.length,
      'completed': completed.length,
      'upcoming': upcoming.length,
      'missed': missed.length,
      'completionRate': (completed.length / testUserAssessments.length * 100).round(),
      'averageScore': completed.isNotEmpty 
          ? (completed.map((a) => a['numericScore'] as double).reduce((a, b) => a + b) / completed.length).round()
          : 0,
      'monthlyData': [
        {'month': 'Jan', 'score': 0},
        {'month': 'Feb', 'score': 0},
        {'month': 'Mar', 'score': 0},
        {'month': 'Apr', 'score': 0},
        {'month': 'May', 'score': 0},
        {'month': 'Jun', 'score': 89.6}, // Average of June assessments
      ],
    };
  }
}
