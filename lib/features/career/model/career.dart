import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String id;
  final String name;
  final double level; // 0.0 to 1.0
  final String category;
  final String description;

  const Skill({
    required this.id,
    required this.name,
    required this.level,
    required this.category,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, level, category, description];

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      level: (json['level'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'category': category,
      'description': description,
    };
  }

  Skill copyWith({
    String? id,
    String? name,
    double? level,
    String? category,
    String? description,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  /// Get level as percentage (0-100)
  int get levelPercentage => (level * 100).round();

  /// Get skill level description
  String get levelDescription {
    if (level >= 0.9) return 'Expert';
    if (level >= 0.7) return 'Advanced';
    if (level >= 0.5) return 'Intermediate';
    if (level >= 0.3) return 'Beginner';
    return 'Learning';
  }
}

class CareerReadinessItem extends Equatable {
  final String id;
  final String title;
  final String status;
  final String description;
  final double progress; // 0.0 to 1.0

  const CareerReadinessItem({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.progress,
  });

  @override
  List<Object?> get props => [id, title, status, description, progress];

  factory CareerReadinessItem.fromJson(Map<String, dynamic> json) {
    return CareerReadinessItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      progress: (json['progress'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'description': description,
      'progress': progress,
    };
  }

  CareerReadinessItem copyWith({
    String? id,
    String? title,
    String? status,
    String? description,
    double? progress,
  }) {
    return CareerReadinessItem(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      description: description ?? this.description,
      progress: progress ?? this.progress,
    );
  }

  /// Get progress as percentage (0-100)
  int get progressPercentage => (progress * 100).round();
}

class CareerProfile extends Equatable {
  final List<Skill> skills;
  final List<CareerReadinessItem> readinessItems;
  final double overallReadiness;

  const CareerProfile({
    required this.skills,
    required this.readinessItems,
    required this.overallReadiness,
  });

  @override
  List<Object?> get props => [skills, readinessItems, overallReadiness];

  factory CareerProfile.fromJson(Map<String, dynamic> json) {
    return CareerProfile(
      skills: (json['skills'] as List<dynamic>?)
          ?.map((skill) => Skill.fromJson(skill as Map<String, dynamic>))
          .toList() ?? [],
      readinessItems: (json['readinessItems'] as List<dynamic>?)
          ?.map((item) => CareerReadinessItem.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
      overallReadiness: (json['overallReadiness'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'readinessItems': readinessItems.map((item) => item.toJson()).toList(),
      'overallReadiness': overallReadiness,
    };
  }

  CareerProfile copyWith({
    List<Skill>? skills,
    List<CareerReadinessItem>? readinessItems,
    double? overallReadiness,
  }) {
    return CareerProfile(
      skills: skills ?? this.skills,
      readinessItems: readinessItems ?? this.readinessItems,
      overallReadiness: overallReadiness ?? this.overallReadiness,
    );
  }

  /// Get skills by category
  List<Skill> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  /// Get average skill level
  double get averageSkillLevel {
    if (skills.isEmpty) return 0.0;
    return skills.fold<double>(0.0, (sum, skill) => sum + skill.level) / skills.length;
  }

  /// Get overall readiness percentage
  int get overallReadinessPercentage => (overallReadiness * 100).round();
}
