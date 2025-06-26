/// Mock data for career and skills
class MockCareerData {
  static List<Map<String, dynamic>> get skills => [
    {
      'id': 'programming',
      'name': 'Programming',
      'category': 'Technical',
      'level': 0.85,
      'description': 'Proficiency in programming languages and software development',
      'keywords': ['Java', 'Python', 'JavaScript', 'C++', 'Flutter', 'Dart'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': 'problem_solving',
      'name': 'Problem Solving',
      'category': 'Analytical',
      'level': 0.75,
      'description': 'Ability to analyze problems and develop effective solutions',
      'keywords': ['Critical Thinking', 'Analysis', 'Logic', 'Algorithms'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 10)),
    },
    {
      'id': 'mathematics',
      'name': 'Mathematics',
      'category': 'Academic',
      'level': 0.90,
      'description': 'Strong foundation in mathematical concepts and applications',
      'keywords': ['Calculus', 'Statistics', 'Linear Algebra', 'Discrete Math'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 'communication',
      'name': 'Communication',
      'category': 'Soft Skills',
      'level': 0.70,
      'description': 'Effective verbal and written communication skills',
      'keywords': ['Presentation', 'Writing', 'Public Speaking', 'Documentation'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 7)),
    },
    {
      'id': 'teamwork',
      'name': 'Teamwork',
      'category': 'Soft Skills',
      'level': 0.80,
      'description': 'Ability to work effectively in team environments',
      'keywords': ['Collaboration', 'Leadership', 'Delegation', 'Conflict Resolution'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 12)),
    },
    {
      'id': 'database_design',
      'name': 'Database Design',
      'category': 'Technical',
      'level': 0.65,
      'description': 'Knowledge of database design principles and SQL',
      'keywords': ['SQL', 'MySQL', 'PostgreSQL', 'Database Normalization'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 8)),
    },
    {
      'id': 'web_development',
      'name': 'Web Development',
      'category': 'Technical',
      'level': 0.72,
      'description': 'Frontend and backend web development skills',
      'keywords': ['HTML', 'CSS', 'React', 'Node.js', 'REST APIs'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 6)),
    },
    {
      'id': 'project_management',
      'name': 'Project Management',
      'category': 'Management',
      'level': 0.55,
      'description': 'Planning, organizing, and managing project resources',
      'keywords': ['Planning', 'Scheduling', 'Risk Management', 'Agile', 'Scrum'],
      'lastUpdated': DateTime.now().subtract(const Duration(days: 15)),
    },
  ];

  static List<Map<String, dynamic>> get careerOpportunities => [
    {
      'id': 'job_001',
      'title': 'Junior Software Developer',
      'company': 'TechCorp Solutions',
      'description': 'Entry-level position for recent graduates with programming skills. Work on web applications using modern frameworks.',
      'requiredSkills': ['Programming', 'Problem Solving', 'Web Development'],
      'preferredSkills': ['Database Design', 'Communication', 'Teamwork'],
      'level': 'entry',
      'type': 'full-time',
      'location': 'Manila, Philippines',
      'isRemote': false,
      'matchPercentage': 0.85,
      'postedDate': DateTime.now().subtract(const Duration(days: 3)),
      'applicationDeadline': DateTime.now().add(const Duration(days: 14)),
      'salaryRange': '₱25,000 - ₱35,000',
      'applicationStatus': null,
    },
    {
      'id': 'job_002',
      'title': 'Mobile App Developer Intern',
      'company': 'StartupTech Inc.',
      'description': 'Summer internship program for students with mobile development interest. Work with Flutter and React Native.',
      'requiredSkills': ['Programming', 'Problem Solving'],
      'preferredSkills': ['Mobile Development', 'Communication'],
      'level': 'internship',
      'type': 'internship',
      'location': 'Quezon City, Philippines',
      'isRemote': true,
      'matchPercentage': 0.78,
      'postedDate': DateTime.now().subtract(const Duration(days: 1)),
      'applicationDecelline': DateTime.now().add(const Duration(days: 7)),
      'salaryRange': '₱15,000 - ₱20,000',
      'applicationStatus': 'applied',
    },
    {
      'id': 'job_003',
      'title': 'Data Analyst',
      'company': 'DataDriven Corp',
      'description': 'Analyze business data and create reports. Strong mathematical background required.',
      'requiredSkills': ['Mathematics', 'Problem Solving', 'Programming'],
      'preferredSkills': ['Database Design', 'Communication'],
      'level': 'entry',
      'type': 'full-time',
      'location': 'Makati, Philippines',
      'isRemote': false,
      'matchPercentage': 0.82,
      'postedDate': DateTime.now().subtract(const Duration(days: 5)),
      'applicationDeadline': DateTime.now().add(const Duration(days: 21)),
      'salaryRange': '₱30,000 - ₱40,000',
      'applicationStatus': null,
    },
    {
      'id': 'job_004',
      'title': 'IT Project Coordinator',
      'company': 'Enterprise Solutions Ltd.',
      'description': 'Coordinate IT projects and support project managers. Great for developing leadership skills.',
      'requiredSkills': ['Communication', 'Project Management', 'Problem Solving'],
      'preferredSkills': ['Teamwork', 'Programming'],
      'level': 'entry',
      'type': 'full-time',
      'location': 'BGC, Philippines',
      'isRemote': true,
      'matchPercentage': 0.65,
      'postedDate': DateTime.now().subtract(const Duration(days: 7)),
      'applicationDeadline': DateTime.now().add(const Duration(days: 10)),
      'salaryRange': '₱28,000 - ₱38,000',
      'applicationStatus': 'interview',
    },
    {
      'id': 'job_005',
      'title': 'Web Developer',
      'company': 'DigitalCraft Studio',
      'description': 'Create responsive websites and web applications for various clients.',
      'requiredSkills': ['Web Development', 'Programming', 'Problem Solving'],
      'preferredSkills': ['Database Design', 'Communication', 'Teamwork'],
      'level': 'mid',
      'type': 'full-time',
      'location': 'Cebu City, Philippines',
      'isRemote': true,
      'matchPercentage': 0.88,
      'postedDate': DateTime.now().subtract(const Duration(days: 2)),
      'applicationDeadline': DateTime.now().add(const Duration(days: 20)),
      'salaryRange': '₱35,000 - ₱50,000',
      'applicationStatus': null,
    },
  ];

  static Map<String, dynamic> get careerProfile => {
    'id': 'profile_001',
    'studentId': 'student_001',
    'readinessScores': {
      'resume': 0.85,
      'portfolio': 0.65,
      'interview_skills': 0.45,
      'technical_skills': 0.80,
      'soft_skills': 0.70,
      'professional_network': 0.30,
      'job_search_strategy': 0.55,
    },
    'completedAssessments': [
      'technical_assessment',
      'communication_assessment',
      'resume_review',
    ],
    'recommendedActions': [
      'Complete portfolio with 3-5 projects',
      'Practice interview skills through mock interviews',
      'Expand professional network through LinkedIn',
      'Attend career fairs and networking events',
      'Develop job search strategy and target companies',
    ],
    'lastUpdated': DateTime.now().subtract(const Duration(days: 2)),
    'personalInfo': {
      'preferredJobTypes': ['full-time', 'internship'],
      'preferredLocations': ['Manila', 'Quezon City', 'Remote'],
      'salaryExpectation': '₱25,000 - ₱40,000',
      'availabilityDate': DateTime.now().add(const Duration(days: 30)),
    },
    'preferences': {
      'workEnvironment': 'hybrid',
      'companySize': 'medium',
      'industries': ['Technology', 'Software', 'Startups'],
      'careerGoals': 'Software Developer, Full-Stack Developer',
    },
  };

  /// Get career overview statistics
  static Map<String, dynamic> get careerOverview {
    final opportunities = careerOpportunities;
    final profile = careerProfile;
    
    return {
      'totalOpportunities': opportunities.length,
      'appliedOpportunities': opportunities.where((o) => o['applicationStatus'] != null).length,
      'averageMatchPercentage': opportunities.fold<double>(
        0.0, 
        (sum, o) => sum + o['matchPercentage'],
      ) / opportunities.length,
      'overallReadiness': _calculateOverallReadiness(profile['readinessScores']),
      'skillsCount': skills.length,
      'averageSkillLevel': skills.fold<double>(
        0.0, 
        (sum, s) => sum + s['level'],
      ) / skills.length,
    };
  }

  static double _calculateOverallReadiness(Map<String, dynamic> scores) {
    if (scores.isEmpty) return 0.0;
    final totalScore = scores.values.fold<double>(0.0, (sum, score) => sum + score);
    return totalScore / scores.length;
  }

  /// Get skills by category
  static List<Map<String, dynamic>> getSkillsByCategory(String category) {
    return skills.where((skill) => skill['category'] == category).toList();
  }

  /// Get opportunities by type
  static List<Map<String, dynamic>> getOpportunitiesByType(String type) {
    return careerOpportunities.where((opp) => opp['type'] == type).toList();
  }

  /// Get high-match opportunities (>= 80%)
  static List<Map<String, dynamic>> getHighMatchOpportunities() {
    return careerOpportunities
        .where((opp) => opp['matchPercentage'] >= 0.8)
        .toList();
  }

  /// Get recent opportunities (posted within last 7 days)
  static List<Map<String, dynamic>> getRecentOpportunities() {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return careerOpportunities
        .where((opp) => (opp['postedDate'] as DateTime).isAfter(sevenDaysAgo))
        .toList();
  }

  /// Get skill categories
  static List<String> get skillCategories {
    return skills.map((skill) => skill['category'] as String).toSet().toList();
  }
}
