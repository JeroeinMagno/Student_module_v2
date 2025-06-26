import 'package:flutter/foundation.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../model/skill.dart';
import '../model/career_opportunity.dart';
import '../model/career_profile.dart';

class CareerViewModel extends ChangeNotifier {
  final DataService _dataService = serviceLocator<DataService>();
  
  List<Skill> _skills = [];
  List<CareerOpportunity> _opportunities = [];
  CareerProfile? _profile;
  bool _isLoading = false;
  String? _error;

  List<Skill> get skills => _skills;
  List<CareerOpportunity> get opportunities => _opportunities;
  CareerProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Get skills grouped by category
  Map<String, List<Skill>> get skillsByCategory {
    final Map<String, List<Skill>> grouped = {};
    for (final skill in _skills) {
      if (!grouped.containsKey(skill.category)) {
        grouped[skill.category] = [];
      }
      grouped[skill.category]!.add(skill);
    }
    return grouped;
  }

  /// Get skill categories
  List<String> get skillCategories {
    return _skills.map((skill) => skill.category).toSet().toList();
  }

  /// Get opportunities by type
  List<CareerOpportunity> getOpportunitiesByType(String type) {
    return _opportunities.where((opp) => opp.type == type).toList();
  }

  /// Get high-match opportunities (>= 80%)
  List<CareerOpportunity> get highMatchOpportunities {
    return _opportunities.where((opp) => opp.matchPercentage >= 0.8).toList();
  }

  /// Get recent opportunities (posted within last 7 days)
  List<CareerOpportunity> get recentOpportunities {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return _opportunities.where((opp) => opp.postedDate.isAfter(sevenDaysAgo)).toList();
  }

  /// Get applied opportunities
  List<CareerOpportunity> get appliedOpportunities {
    return _opportunities.where((opp) => opp.applicationStatus != null).toList();
  }

  /// Get career statistics
  Map<String, dynamic> get careerStats {
    return {
      'totalOpportunities': _opportunities.length,
      'appliedOpportunities': appliedOpportunities.length,
      'highMatchOpportunities': highMatchOpportunities.length,
      'averageMatchPercentage': _opportunities.isEmpty 
          ? 0.0 
          : _opportunities.fold<double>(0.0, (sum, opp) => sum + opp.matchPercentage) / _opportunities.length,
      'overallReadiness': _profile?.overallReadinessScore ?? 0.0,
      'skillsCount': _skills.length,
      'averageSkillLevel': _skills.isEmpty 
          ? 0.0 
          : _skills.fold<double>(0.0, (sum, skill) => sum + skill.level) / _skills.length,
    };
  }

  /// Load all career data
  Future<void> loadCareerData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait([
        loadSkills(),
        loadOpportunities(),
        loadProfile(),
      ]);
      _error = null;
    } catch (e) {
      _error = 'Failed to load career data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load skills
  Future<void> loadSkills() async {
    try {
      final skillData = await _dataService.getSkills();
      _skills = skillData.map((data) => Skill.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to load skills: $e');
    }
  }

  /// Load career opportunities
  Future<void> loadOpportunities() async {
    try {
      final opportunityData = await _dataService.getCareerOpportunities();
      _opportunities = opportunityData.map((data) => CareerOpportunity.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to load opportunities: $e');
    }
  }

  /// Load career profile
  Future<void> loadProfile() async {
    try {
      final profileData = await _dataService.getCareerProfile();
      _profile = CareerProfile.fromJson(profileData);
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  /// Update skill level
  Future<void> updateSkillLevel(String skillId, double newLevel) async {
    try {
      final skillIndex = _skills.indexWhere((skill) => skill.id == skillId);
      if (skillIndex != -1) {
        final updatedSkill = _skills[skillIndex].copyWith(
          level: newLevel,
          lastUpdated: DateTime.now(),
        );
        _skills[skillIndex] = updatedSkill;
        
        // In a real app, this would save to the backend
        await _dataService.updateSkill(skillId, updatedSkill.toJson());
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update skill: $e';
      notifyListeners();
    }
  }

  /// Apply to opportunity
  Future<void> applyToOpportunity(String opportunityId) async {
    try {
      final oppIndex = _opportunities.indexWhere((opp) => opp.id == opportunityId);
      if (oppIndex != -1) {
        final updatedOpp = _opportunities[oppIndex].copyWith(
          applicationStatus: 'applied',
        );
        _opportunities[oppIndex] = updatedOpp;
        
        // In a real app, this would save to the backend
        await _dataService.applyToOpportunity(opportunityId);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to apply to opportunity: $e';
      notifyListeners();
    }
  }

  /// Update career profile readiness score
  Future<void> updateReadinessScore(String category, double score) async {
    if (_profile == null) return;
    
    try {
      final updatedScores = Map<String, double>.from(_profile!.readinessScores);
      updatedScores[category] = score;
      
      final updatedProfile = _profile!.copyWith(
        readinessScores: updatedScores,
        lastUpdated: DateTime.now(),
      );
      _profile = updatedProfile;
      
      // In a real app, this would save to the backend
      await _dataService.updateCareerProfile(updatedProfile.toJson());
      notifyListeners();
    } catch (e) {
      _error = 'Failed to update readiness score: $e';
      notifyListeners();
    }
  }

  /// Get skill by ID
  Skill? getSkillById(String skillId) {
    try {
      return _skills.firstWhere((skill) => skill.id == skillId);
    } catch (e) {
      return null;
    }
  }

  /// Get opportunity by ID
  CareerOpportunity? getOpportunityById(String opportunityId) {
    try {
      return _opportunities.firstWhere((opp) => opp.id == opportunityId);
    } catch (e) {
      return null;
    }
  }

  /// Filter opportunities by criteria
  List<CareerOpportunity> filterOpportunities({
    String? type,
    String? level,
    bool? isRemote,
    double? minMatch,
  }) {
    return _opportunities.where((opp) {
      if (type != null && opp.type != type) return false;
      if (level != null && opp.level != level) return false;
      if (isRemote != null && opp.isRemote != isRemote) return false;
      if (minMatch != null && opp.matchPercentage < minMatch) return false;
      return true;
    }).toList();
  }

  /// Refresh all data
  Future<void> refreshData() async {
    await loadCareerData();
  }

  /// Clear any error state
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
