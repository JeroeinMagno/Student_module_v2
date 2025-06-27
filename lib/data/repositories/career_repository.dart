import '../datasources/career_datasource.dart';
import 'base_repository.dart';

/// Career repository interface
abstract class CareerRepository {
  /// Get all skills
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkills();
  
  /// Get career opportunities
  Future<RepositoryResult<List<Map<String, dynamic>>>> getCareerOpportunities();
  
  /// Get career profile
  Future<RepositoryResult<Map<String, dynamic>>> getCareerProfile();
  
  /// Get career overview/statistics
  Future<RepositoryResult<Map<String, dynamic>>> getCareerOverview();
  
  /// Update skill level
  Future<RepositoryResult<Map<String, dynamic>>> updateSkill(String skillId, Map<String, dynamic> skillData);
  
  /// Apply to career opportunity
  Future<RepositoryResult<Map<String, dynamic>>> applyToOpportunity(String opportunityId);
  
  /// Update career profile
  Future<RepositoryResult<Map<String, dynamic>>> updateCareerProfile(Map<String, dynamic> profileData);
  
  /// Get skills by category
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsByCategory(String category);
  
  /// Get opportunities by type
  Future<RepositoryResult<List<Map<String, dynamic>>>> getOpportunitiesByType(String type);
}

/// Implementation of CareerRepository
class CareerRepositoryImpl implements CareerRepository {
  final CareerApiService _careerDataSource;
  
  CareerRepositoryImpl(this._careerDataSource);
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkills() async {
    try {
      final data = await _careerDataSource.getSkills();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch skills: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getCareerOpportunities() async {
    try {
      final data = await _careerDataSource.getCareerOpportunities();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch career opportunities: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCareerProfile() async {
    try {
      final data = await _careerDataSource.getCareerProfile();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch career profile: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCareerOverview() async {
    try {
      final data = await _careerDataSource.getCareerOverview();
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch career overview: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> updateSkill(String skillId, Map<String, dynamic> skillData) async {
    try {
      final data = await _careerDataSource.updateSkill(skillId, skillData);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to update skill: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> applyToOpportunity(String opportunityId) async {
    try {
      final data = await _careerDataSource.applyToOpportunity(opportunityId);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to apply to opportunity: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> updateCareerProfile(Map<String, dynamic> profileData) async {
    try {
      final data = await _careerDataSource.updateCareerProfile(profileData);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to update career profile: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsByCategory(String category) async {
    try {
      final data = await _careerDataSource.getSkillsByCategory(category);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch skills by category: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getOpportunitiesByType(String type) async {
    try {
      final data = await _careerDataSource.getOpportunitiesByType(type);
      return RepositoryResult.success(data);
    } catch (e) {
      return RepositoryResult.failure('Failed to fetch opportunities by type: ${e.toString()}');
    }
  }
}

/// Mock implementation of CareerRepository for testing
class MockCareerRepository implements CareerRepository {
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkills() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final mockSkills = [
      {
        'id': 'skill_1',
        'name': 'Programming',
        'category': 'Technical',
        'level': 85,
        'progress': 12,
        'description': 'Software development and programming languages',
      },
      {
        'id': 'skill_2',
        'name': 'Problem Solving',
        'category': 'Analytical',
        'level': 78,
        'progress': 8,
        'description': 'Analytical thinking and problem-solving abilities',
      },
      {
        'id': 'skill_3',
        'name': 'Communication',
        'category': 'Soft Skills',
        'level': 88,
        'progress': 5,
        'description': 'Effective verbal and written communication',
      },
    ];
    
    return RepositoryResult.success(mockSkills);
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getCareerOpportunities() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final mockOpportunities = [
      {
        'id': 'opp_1',
        'title': 'Software Developer Intern',
        'company': 'Tech Corp',
        'type': 'Internship',
        'location': 'Remote',
        'deadline': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        'description': 'Join our development team as an intern',
        'requirements': ['Programming skills', 'Problem solving', 'Team work'],
      },
      {
        'id': 'opp_2',
        'title': 'Data Analyst Position',
        'company': 'Data Solutions Inc',
        'type': 'Full-time',
        'location': 'New York',
        'deadline': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'description': 'Analyze data to drive business decisions',
        'requirements': ['Data analysis', 'Statistics', 'Communication'],
      },
    ];
    
    return RepositoryResult.success(mockOpportunities);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCareerProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final mockProfile = {
      'id': 'profile_1',
      'name': 'John Doe',
      'title': 'Computer Science Student',
      'summary': 'Passionate computer science student with strong programming skills',
      'skills': ['Programming', 'Problem Solving', 'Communication'],
      'interests': ['Software Development', 'Machine Learning', 'Web Development'],
      'experience': [
        {
          'title': 'Programming Tutor',
          'organization': 'University',
          'duration': '6 months',
          'description': 'Helped fellow students with programming assignments',
        }
      ],
      'education': [
        {
          'degree': 'Bachelor of Science in Computer Science',
          'institution': 'University Name',
          'year': '2024',
          'gpa': '3.8',
        }
      ],
    };
    
    return RepositoryResult.success(mockProfile);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> getCareerOverview() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final mockOverview = {
      'totalSkills': 12,
      'skillsImproved': 8,
      'averageSkillLevel': 82.5,
      'opportunitiesApplied': 5,
      'interviewsScheduled': 2,
      'offersReceived': 0,
      'profileViews': 45,
      'profileCompleteness': 85.0,
    };
    
    return RepositoryResult.success(mockOverview);
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> updateSkill(String skillId, Map<String, dynamic> skillData) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    return RepositoryResult.success({
      'skillId': skillId,
      'updated': true,
      'message': 'Skill updated successfully',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> applyToOpportunity(String opportunityId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return RepositoryResult.success({
      'opportunityId': opportunityId,
      'applicationId': 'app_${DateTime.now().millisecondsSinceEpoch}',
      'status': 'submitted',
      'message': 'Application submitted successfully',
      'submittedAt': DateTime.now().toIso8601String(),
    });
  }
  
  @override
  Future<RepositoryResult<Map<String, dynamic>>> updateCareerProfile(Map<String, dynamic> profileData) async {
    await Future.delayed(const Duration(milliseconds: 700));
    
    return RepositoryResult.success({
      'profileId': 'profile_1',
      'updated': true,
      'message': 'Career profile updated successfully',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getSkillsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final allSkills = await getSkills();
    if (allSkills.isSuccess) {
      final filteredSkills = allSkills.data!.where((skill) => skill['category'] == category).toList();
      return RepositoryResult.success(filteredSkills);
    }
    
    return RepositoryResult.failure(allSkills.error!);
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getOpportunitiesByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 450));
    
    final allOpportunities = await getCareerOpportunities();
    if (allOpportunities.isSuccess) {
      final filteredOpportunities = allOpportunities.data!.where((opp) => opp['type'] == type).toList();
      return RepositoryResult.success(filteredOpportunities);
    }
    
    return RepositoryResult.failure(allOpportunities.error!);
  }
}
