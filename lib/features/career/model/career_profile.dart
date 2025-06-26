import 'package:equatable/equatable.dart';

/// Represents career readiness assessment and profile
class CareerProfile extends Equatable {
  final String id;
  final String studentId;
  final Map<String, double> readinessScores; // category -> score (0.0 to 1.0)
  final List<String> completedAssessments;
  final List<String> recommendedActions;
  final DateTime lastUpdated;
  final Map<String, dynamic> personalInfo;
  final Map<String, dynamic> preferences;

  const CareerProfile({
    required this.id,
    required this.studentId,
    required this.readinessScores,
    required this.completedAssessments,
    required this.recommendedActions,
    required this.lastUpdated,
    required this.personalInfo,
    required this.preferences,
  });

  @override
  List<Object?> get props => [
        id,
        studentId,
        readinessScores,
        completedAssessments,
        recommendedActions,
        lastUpdated,
        personalInfo,
        preferences,
      ];

  factory CareerProfile.fromJson(Map<String, dynamic> json) {
    return CareerProfile(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      readinessScores: Map<String, double>.from(
        (json['readinessScores'] ?? {}).map((k, v) => MapEntry(k, v.toDouble())),
      ),
      completedAssessments: List<String>.from(json['completedAssessments'] ?? []),
      recommendedActions: List<String>.from(json['recommendedActions'] ?? []),
      lastUpdated: json['lastUpdated'] is DateTime 
          ? json['lastUpdated'] 
          : DateTime.parse(json['lastUpdated'].toString()),
      personalInfo: Map<String, dynamic>.from(json['personalInfo'] ?? {}),
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'readinessScores': readinessScores,
      'completedAssessments': completedAssessments,
      'recommendedActions': recommendedActions,
      'lastUpdated': lastUpdated.toIso8601String(),
      'personalInfo': personalInfo,
      'preferences': preferences,
    };
  }

  CareerProfile copyWith({
    String? id,
    String? studentId,
    Map<String, double>? readinessScores,
    List<String>? completedAssessments,
    List<String>? recommendedActions,
    DateTime? lastUpdated,
    Map<String, dynamic>? personalInfo,
    Map<String, dynamic>? preferences,
  }) {
    return CareerProfile(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      readinessScores: readinessScores ?? this.readinessScores,
      completedAssessments: completedAssessments ?? this.completedAssessments,
      recommendedActions: recommendedActions ?? this.recommendedActions,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      personalInfo: personalInfo ?? this.personalInfo,
      preferences: preferences ?? this.preferences,
    );
  }

  /// Get overall career readiness score
  double get overallReadinessScore {
    if (readinessScores.isEmpty) return 0.0;
    final totalScore = readinessScores.values.fold<double>(0.0, (sum, score) => sum + score);
    return totalScore / readinessScores.length;
  }

  /// Get overall readiness level description
  String get overallReadinessLevel {
    final score = overallReadinessScore;
    if (score >= 0.9) return 'Excellent';
    if (score >= 0.7) return 'Good';
    if (score >= 0.5) return 'Fair';
    if (score >= 0.3) return 'Needs Improvement';
    return 'Poor';
  }

  /// Get readiness level for a specific category
  String getReadinessLevel(String category) {
    final score = readinessScores[category] ?? 0.0;
    if (score >= 0.9) return 'Excellent';
    if (score >= 0.7) return 'Good';
    if (score >= 0.5) return 'Fair';
    if (score >= 0.3) return 'Needs Improvement';
    return 'Poor';
  }

  /// Get color for readiness level
  String getReadinessColor(String category) {
    final score = readinessScores[category] ?? 0.0;
    if (score >= 0.8) return 'green';
    if (score >= 0.6) return 'blue';
    if (score >= 0.4) return 'orange';
    return 'red';
  }

  /// Get overall readiness color
  String get overallReadinessColor {
    final score = overallReadinessScore;
    if (score >= 0.8) return 'green';
    if (score >= 0.6) return 'blue';
    if (score >= 0.4) return 'orange';
    return 'red';
  }

  /// Get readiness score as percentage for a category
  int getReadinessPercentage(String category) {
    return ((readinessScores[category] ?? 0.0) * 100).round();
  }

  /// Get overall readiness as percentage
  int get overallReadinessPercentage {
    return (overallReadinessScore * 100).round();
  }
}
