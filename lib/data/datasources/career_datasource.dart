import 'base_datasource.dart';

/// Career data source interface
abstract class CareerDataSource {
  /// Get all skills
  Future<List<Map<String, dynamic>>> getSkills();
  
  /// Get career opportunities
  Future<List<Map<String, dynamic>>> getCareerOpportunities();
  
  /// Get career profile
  Future<Map<String, dynamic>> getCareerProfile();
  
  /// Get career overview/statistics
  Future<Map<String, dynamic>> getCareerOverview();
  
  /// Update skill level
  Future<Map<String, dynamic>> updateSkill(String skillId, Map<String, dynamic> skillData);
  
  /// Apply to career opportunity
  Future<Map<String, dynamic>> applyToOpportunity(String opportunityId);
  
  /// Update career profile
  Future<Map<String, dynamic>> updateCareerProfile(Map<String, dynamic> profileData);
  
  /// Get skills by category
  Future<List<Map<String, dynamic>>> getSkillsByCategory(String category);
  
  /// Get opportunities by type
  Future<List<Map<String, dynamic>>> getOpportunitiesByType(String type);
}

/// Career API service implementation
class CareerApiService implements CareerDataSource {
  final BaseApiService _apiService;
  
  CareerApiService(this._apiService);
  
  @override
  Future<List<Map<String, dynamic>>> getSkills() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/career/skills');
  }
  
  @override
  Future<List<Map<String, dynamic>>> getCareerOpportunities() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/career/opportunities');
  }
  
  @override
  Future<Map<String, dynamic>> getCareerProfile() async {
    return await _apiService.get<Map<String, dynamic>>('/career/profile');
  }
  
  @override
  Future<Map<String, dynamic>> getCareerOverview() async {
    return await _apiService.get<Map<String, dynamic>>('/career/overview');
  }
  
  @override
  Future<Map<String, dynamic>> updateSkill(String skillId, Map<String, dynamic> skillData) async {
    return await _apiService.put<Map<String, dynamic>>('/career/skills/$skillId', data: skillData);
  }
  
  @override
  Future<Map<String, dynamic>> applyToOpportunity(String opportunityId) async {
    return await _apiService.post<Map<String, dynamic>>('/career/opportunities/$opportunityId/apply');
  }
  
  @override
  Future<Map<String, dynamic>> updateCareerProfile(Map<String, dynamic> profileData) async {
    return await _apiService.put<Map<String, dynamic>>('/career/profile', data: profileData);
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSkillsByCategory(String category) async {
    return await _apiService.get<List<Map<String, dynamic>>>('/career/skills/category/$category');
  }
  
  @override
  Future<List<Map<String, dynamic>>> getOpportunitiesByType(String type) async {
    return await _apiService.get<List<Map<String, dynamic>>>('/career/opportunities/type/$type');
  }
}

/// Mock career data source for development
class MockCareerDataSource implements CareerDataSource {
  static const Duration _mockDelay = Duration(milliseconds: 500);
  
  static final List<Map<String, dynamic>> _mockSkills = [
    {
      'id': 'skill_001',
      'name': 'Flutter Development',
      'category': 'Mobile Development',
      'level': 85.0,
      'progress': 15.0,
      'description': 'Cross-platform mobile app development with Flutter',
    },
    {
      'id': 'skill_002',
      'name': 'Dart Programming',
      'category': 'Programming Languages',
      'level': 90.0,
      'progress': 10.0,
      'description': 'Dart programming language proficiency',
    },
    {
      'id': 'skill_003',
      'name': 'UI/UX Design',
      'category': 'Design',
      'level': 70.0,
      'progress': 20.0,
      'description': 'User interface and experience design',
    },
    {
      'id': 'skill_004',
      'name': 'Problem Solving',
      'category': 'Soft Skills',
      'level': 88.0,
      'progress': 12.0,
      'description': 'Analytical and critical thinking skills',
    },
  ];
  
  static final List<Map<String, dynamic>> _mockOpportunities = [
    {
      'id': 'opp_001',
      'title': 'Mobile App Developer Intern',
      'company': 'TechCorp Solutions',
      'type': 'Internship',
      'location': 'Manila, Philippines',
      'description': 'Develop mobile applications using Flutter framework',
      'requirements': ['Flutter', 'Dart', 'Git'],
      'deadline': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
      'matchPercentage': 85.0,
    },
    {
      'id': 'opp_002',
      'title': 'Junior Software Engineer',
      'company': 'StartupXYZ',
      'type': 'Full-time',
      'location': 'Cebu City, Philippines',
      'description': 'Join our development team building innovative solutions',
      'requirements': ['Programming', 'Problem Solving', 'Team Work'],
      'deadline': DateTime.now().add(const Duration(days: 21)).toIso8601String(),
      'matchPercentage': 78.0,
    },
    {
      'id': 'opp_003',
      'title': 'UI/UX Design Apprentice',
      'company': 'Creative Agency',
      'type': 'Apprenticeship',
      'location': 'Davao City, Philippines',
      'description': 'Learn and practice design skills in real projects',
      'requirements': ['Design Thinking', 'Creativity', 'Adobe Tools'],
      'deadline': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'matchPercentage': 65.0,
    },
  ];
  
  @override
  Future<List<Map<String, dynamic>>> getSkills() async {
    await Future.delayed(_mockDelay);
    return List.from(_mockSkills);
  }
  
  @override
  Future<List<Map<String, dynamic>>> getCareerOpportunities() async {
    await Future.delayed(_mockDelay);
    return List.from(_mockOpportunities);
  }
  
  @override
  Future<Map<String, dynamic>> getCareerProfile() async {
    await Future.delayed(_mockDelay);
    
    return {
      'id': 'profile_001',
      'studentId': 'student_123',
      'careerGoals': 'Mobile App Developer',
      'preferredIndustries': ['Technology', 'Fintech', 'E-commerce'],
      'workPreferences': {
        'location': 'Metro Manila',
        'workType': 'Hybrid',
        'salaryRange': '25000-35000',
      },
      'experiences': [
        {
          'title': 'Programming Tutor',
          'organization': 'University Peer Learning',
          'duration': '6 months',
          'description': 'Helped fellow students with programming concepts',
        },
      ],
      'achievements': [
        'Dean\'s List - 2 semesters',
        'Programming Competition - 3rd Place',
        'Mobile App Hackathon - Winner',
      ],
      'portfolioUrl': 'https://github.com/johndoe',
      'resumeUrl': 'https://drive.google.com/resume.pdf',
    };
  }
  
  @override
  Future<Map<String, dynamic>> getCareerOverview() async {
    await Future.delayed(_mockDelay);
    
    return {
      'skillsOverview': {
        'totalSkills': _mockSkills.length,
        'averageLevel': _mockSkills.map((s) => s['level'] as double).reduce((a, b) => a + b) / _mockSkills.length,
        'topSkills': _mockSkills.take(3).map((s) => s['name']).toList(),
      },
      'opportunitiesOverview': {
        'totalOpportunities': _mockOpportunities.length,
        'appliedCount': 2,
        'averageMatch': _mockOpportunities.map((o) => o['matchPercentage'] as double).reduce((a, b) => a + b) / _mockOpportunities.length,
      },
      'careerReadiness': {
        'score': 78.0,
        'level': 'Good',
        'recommendations': [
          'Improve UI/UX Design skills',
          'Build more portfolio projects',
          'Practice technical interviews',
        ],
      },
    };
  }
  
  @override
  Future<Map<String, dynamic>> updateSkill(String skillId, Map<String, dynamic> skillData) async {
    await Future.delayed(_mockDelay);
    
    return {
      'success': true,
      'skillId': skillId,
      'updatedAt': DateTime.now().toIso8601String(),
      'newLevel': skillData['level'],
    };
  }
  
  @override
  Future<Map<String, dynamic>> applyToOpportunity(String opportunityId) async {
    await Future.delayed(_mockDelay);
    
    return {
      'success': true,
      'opportunityId': opportunityId,
      'applicationId': 'app_${DateTime.now().millisecondsSinceEpoch}',
      'status': 'submitted',
      'submittedAt': DateTime.now().toIso8601String(),
      'message': 'Application submitted successfully',
    };
  }
  
  @override
  Future<Map<String, dynamic>> updateCareerProfile(Map<String, dynamic> profileData) async {
    await Future.delayed(_mockDelay);
    
    return {
      'success': true,
      'profileId': 'profile_001',
      'updatedAt': DateTime.now().toIso8601String(),
      'updatedFields': profileData.keys.toList(),
    };
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSkillsByCategory(String category) async {
    await Future.delayed(_mockDelay);
    
    return _mockSkills.where((skill) => skill['category'] == category).toList();
  }
  
  @override
  Future<List<Map<String, dynamic>>> getOpportunitiesByType(String type) async {
    await Future.delayed(_mockDelay);
    
    return _mockOpportunities.where((opp) => opp['type'] == type).toList();
  }
}
