class MockDataService {
  // Student data (matching web system)
  static Map<String, dynamic> getStudentInfo() {
    return {
      'name': 'John Doe',
      'srCode': '22-12345',
      'avatar': 'https://randomuser.me/api/portraits/men/75.jpg',
    };
  }

  // Courses data (matching web system)
  static List<Map<String, dynamic>> getCourseData() {
    return [
      {
        'id': 'cs101',
        'code': 'CS 101',
        'title': 'Introduction to Computer Science',
        'description': 'An introduction to computer science...',
        'instructor': 'Prof. Jane Doe',
        'progress': 75,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-07-01',
            'percentage': 30,
            'status': 'missing',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-20',
            'percentage': 40,
            'status': 'upcoming',
          },
        ],
      },
      {
        'id': 'math201',
        'code': 'MATH 201',
        'title': 'Discrete Mathematics',
        'description': 'Covers logic, set theory, etc.',
        'instructor': 'Dr. John Smith',
        'progress': 45,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-06-25',
            'percentage': 25,
            'status': 'completed',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-15',
            'percentage': 35,
            'status': 'upcoming',
          },
        ],
      },
      {
        'id': 'it310',
        'code': 'IT 310',
        'title': 'Web Development',
        'description': 'A hands-on web development course...',
        'instructor': 'Engr. Lance Ramos',
        'progress': 90,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-06-22',
            'percentage': 20,
            'status': 'completed',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-10',
            'percentage': 30,
            'status': 'upcoming',
          },
        ],
      },
      {
        'id': 'phy201',
        'code': 'PHY 201',
        'title': 'Physics II',
        'description': 'Advanced physics concepts including electromagnetism...',
        'instructor': 'Dr. Maria Garcia',
        'progress': 60,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-06-28',
            'percentage': 25,
            'status': 'completed',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-18',
            'percentage': 35,
            'status': 'upcoming',
          },
        ],
      },
      {
        'id': 'eng101',
        'code': 'ENG 101',
        'title': 'Technical Writing',
        'description': 'Develops technical writing skills...',
        'instructor': 'Prof. Sarah Johnson',
        'progress': 85,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-06-20',
            'percentage': 20,
            'status': 'completed',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-12',
            'percentage': 30,
            'status': 'upcoming',
          },
        ],
      },
      {
        'id': 'hist101',
        'code': 'HIST 101',
        'title': 'Philippine History',
        'description': 'Comprehensive study of Philippine history...',
        'instructor': 'Dr. Ramon Santos',
        'progress': 70,
        'exams': [
          {
            'title': 'Midterm Exam',
            'date': '2025-06-30',
            'percentage': 30,
            'status': 'completed',
          },
          {
            'title': 'Final Exam',
            'date': '2025-08-25',
            'percentage': 40,
            'status': 'upcoming',
          },
        ],
      },
    ];
  }

  // Chart data for dashboard (matching web system)
  static List<Map<String, dynamic>> getChartData() {
    return [
      {'month': 'January', 'desktop': 186.0},
      {'month': 'February', 'desktop': 305.0},
      {'month': 'March', 'desktop': 237.0},
      {'month': 'April', 'desktop': 73.0},
      {'month': 'May', 'desktop': 209.0},
      {'month': 'June', 'desktop': 214.0},
    ];
  }

  // Assessment data for recent assessments table
  static List<Map<String, dynamic>> getRecentAssessments() {
    return [
      {
        'subject': 'Introduction to Computer Science',
        'grade': 'A',
        'score': '95%',
        'date': '2025-06-15',
        'type': 'Final Exam',
        'courseCode': 'CS 101',
      },
      {
        'subject': 'Discrete Mathematics',
        'grade': 'B+',
        'score': '88%',
        'date': '2025-06-12',
        'type': 'Midterm Exam',
        'courseCode': 'MATH 201',
      },
      {
        'subject': 'Web Development',
        'grade': 'A',
        'score': '96%',
        'date': '2025-06-10',
        'type': 'Project',
        'courseCode': 'IT 310',
      },
      {
        'subject': 'Physics II',
        'grade': 'B',
        'score': '85%',
        'date': '2025-06-08',
        'type': 'Lab Exam',
        'courseCode': 'PHY 201',
      },
      {
        'subject': 'Technical Writing',
        'grade': 'A-',
        'score': '92%',
        'date': '2025-06-05',
        'type': 'Essay',
        'courseCode': 'ENG 101',
      },
    ];
  }

  // Performance distribution data
  static Map<String, dynamic> getPerformanceDistribution() {
    return {
      'excellent': 40.0,
      'good': 30.0,
      'average': 20.0,
      'poor': 10.0,
    };
  }

  // Grade trends data
  static List<Map<String, dynamic>> getGradeTrends() {
    return [
      {'month': 'January', 'gpa': 3.2},
      {'month': 'February', 'gpa': 3.5},
      {'month': 'March', 'gpa': 3.1},
      {'month': 'April', 'gpa': 3.8},
      {'month': 'May', 'gpa': 3.6},
      {'month': 'June', 'gpa': 3.9},
    ];
  }

  // Topics data
  static List<Map<String, dynamic>> getTopics() {
    return [
      {
        'week': '1',
        'topic': 'Introduction to Course',
        'ilo': ['1'],
        'so': ['1', '2']
      },
      {
        'week': '2-3',
        'topic': 'Fundamentals of Programming',
        'ilo': ['1', '2'],
        'so': ['1', '3']
      },
      {
        'week': '4',
        'topic': 'Data Structures',
        'ilo': ['1'],
        'so': ['3', '4']
      },
      {
        'week': '5-6',
        'topic': 'Algorithms',
        'ilo': ['3'],
        'so': ['4']
      },
      {
        'week': '7-8',
        'topic': 'Advanced Algorithms',
        'ilo': ['3', '4'],
        'so': ['6']
      },
      {
        'week': '9',
        'topic': 'Software Engineering Principles',
        'ilo': ['1', '5'],
        'so': ['7']
      },
    ];
  }

  // ILOs (Intended Learning Outcomes)
  static List<Map<String, dynamic>> getILOs() {
    return [
      {
        'ilo': 'ILO1',
        'description': 'Understand the fundamentals of programming and computer science.'
      },
      {
        'ilo': 'ILO2',
        'description': 'Apply data structures and algorithms to solve problems.'
      },
      {
        'ilo': 'ILO3',
        'description': 'Design and analyze efficient algorithms.'
      },
      {
        'ilo': 'ILO4',
        'description': 'Demonstrate knowledge of advanced algorithms and software engineering principles.'
      },
      {
        'ilo': 'ILO5',
        'description': 'Communicate technical information effectively.'
      },
    ];
  }

  // Assessment criteria
  static List<Map<String, dynamic>> getDummyCriteria() {
    return [
      {'name': 'Quiz 1', 'accomplished': true},
      {'name': 'Midterms', 'accomplished': true},
      {'name': 'Plates', 'accomplished': true},
      {'name': 'Finals', 'accomplished': false},
    ];
  }

  // Flattened exams data (matching web API structure)
  static List<Map<String, dynamic>> getAllExams() {
    final courses = getCourseData();
    List<Map<String, dynamic>> allExams = [];

    for (var course in courses) {
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
        });
      }
    }

    return allExams;
  }

  // Career guidance data
  static List<Map<String, dynamic>> getCareerPaths() {
    return [
      {
        'title': 'Software Engineering',
        'description': 'Build innovative software solutions',
        'icon': 'computer',
        'skills': ['Programming', 'Problem Solving', 'System Design'],
        'averageSalary': '₱80,000 - ₱150,000',
        'growthRate': 'High',
      },
      {
        'title': 'Data Science',
        'description': 'Analyze and interpret complex data',
        'icon': 'analytics',
        'skills': ['Statistics', 'Machine Learning', 'Data Visualization'],
        'averageSalary': '₱70,000 - ₱130,000',
        'growthRate': 'Very High',
      },
      {
        'title': 'Product Management',
        'description': 'Lead product development initiatives',
        'icon': 'inventory',
        'skills': ['Strategy', 'Communication', 'Market Analysis'],
        'averageSalary': '₱90,000 - ₱180,000',
        'growthRate': 'High',
      },
      {
        'title': 'UX/UI Design',
        'description': 'Create intuitive user experiences',
        'icon': 'design_services',
        'skills': ['Design Thinking', 'Prototyping', 'User Research'],
        'averageSalary': '₱60,000 - ₱120,000',
        'growthRate': 'High',
      },
      {
        'title': 'Cybersecurity',
        'description': 'Protect digital assets and systems',
        'icon': 'security',
        'skills': ['Security Protocols', 'Risk Assessment', 'Incident Response'],
        'averageSalary': '₱85,000 - ₱160,000',
        'growthRate': 'Very High',
      },
      {
        'title': 'Cloud Architecture',
        'description': 'Design and manage cloud infrastructure',
        'icon': 'cloud',
        'skills': ['Cloud Platforms', 'DevOps', 'Infrastructure Management'],
        'averageSalary': '₱100,000 - ₱200,000',
        'growthRate': 'Very High',
      },
    ];
  }
}
