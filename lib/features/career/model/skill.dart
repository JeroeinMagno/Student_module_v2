import 'package:equatable/equatable.dart';

/// Represents a skill with proficiency level
class Skill extends Equatable {
  final String id;
  final String name;
  final String category;
  final double level; // 0.0 to 1.0
  final String description;
  final List<String> keywords;
  final DateTime lastUpdated;

  const Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.level,
    required this.description,
    required this.keywords,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, name, category, level, description, keywords, lastUpdated];

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      level: (json['level'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      keywords: List<String>.from(json['keywords'] ?? []),
      lastUpdated: json['lastUpdated'] is DateTime 
          ? json['lastUpdated'] 
          : DateTime.parse(json['lastUpdated'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'level': level,
      'description': description,
      'keywords': keywords,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  Skill copyWith({
    String? id,
    String? name,
    String? category,
    double? level,
    String? description,
    List<String>? keywords,
    DateTime? lastUpdated,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      level: level ?? this.level,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Get skill level as percentage
  int get percentageLevel => (level * 100).round();

  /// Get skill level description
  String get levelDescription {
    if (level >= 0.9) return 'Expert';
    if (level >= 0.7) return 'Advanced';
    if (level >= 0.5) return 'Intermediate';
    if (level >= 0.3) return 'Beginner';
    return 'Novice';
  }

  /// Get skill level color based on proficiency
  String get levelColor {
    if (level >= 0.8) return 'green';
    if (level >= 0.6) return 'blue';
    if (level >= 0.4) return 'orange';
    return 'red';
  }
}
