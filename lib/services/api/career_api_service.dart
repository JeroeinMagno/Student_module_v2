import 'base_api_service.dart';

/// Career and skills related API service
class CareerApiService {
  final BaseApiService _apiService;
  
  CareerApiService(this._apiService);
  
  /// Get all skills
  Future<List<Map<String, dynamic>>> getSkills() async {
    return await _apiService.get('/career/skills');
  }
  
  /// Get career opportunities
  Future<List<Map<String, dynamic>>> getCareerOpportunities() async {
    return await _apiService.get('/career/opportunities');
  }
  
  /// Get career profile
  Future<Map<String, dynamic>> getCareerProfile() async {
    return await _apiService.get('/career/profile');
  }
  
  /// Get career overview/statistics
  Future<Map<String, dynamic>> getCareerOverview() async {
    return await _apiService.get('/career/overview');
  }
  
  /// Update skill level
  Future<Map<String, dynamic>> updateSkill(String skillId, Map<String, dynamic> skillData) async {
    return await _apiService.put('/career/skills/$skillId', data: skillData);
  }
  
  /// Apply to career opportunity
  Future<Map<String, dynamic>> applyToOpportunity(String opportunityId) async {
    return await _apiService.post('/career/opportunities/$opportunityId/apply');
  }
  
  /// Update career profile
  Future<Map<String, dynamic>> updateCareerProfile(Map<String, dynamic> profileData) async {
    return await _apiService.put('/career/profile', data: profileData);
  }
  
  /// Get skills by category
  Future<List<Map<String, dynamic>>> getSkillsByCategory(String category) async {
    return await _apiService.get('/career/skills/category/$category');
  }
  
  /// Get opportunities by type
  Future<List<Map<String, dynamic>>> getOpportunitiesByType(String type) async {
    return await _apiService.get('/career/opportunities/type/$type');
  }
}
