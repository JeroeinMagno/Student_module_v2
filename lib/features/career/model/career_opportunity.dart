import 'package:equatable/equatable.dart';

/// Represents a career opportunity or job position
class CareerOpportunity extends Equatable {
  final String id;
  final String title;
  final String company;
  final String description;
  final List<String> requiredSkills;
  final List<String> preferredSkills;
  final String level; // entry, mid, senior
  final String type; // internship, full-time, part-time, contract
  final String location;
  final bool isRemote;
  final double matchPercentage;
  final DateTime postedDate;
  final DateTime? applicationDeadline;
  final String? salaryRange;
  final String? applicationStatus; // not_applied, applied, interview, rejected, accepted

  const CareerOpportunity({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.requiredSkills,
    required this.preferredSkills,
    required this.level,
    required this.type,
    required this.location,
    required this.isRemote,
    required this.matchPercentage,
    required this.postedDate,
    this.applicationDeadline,
    this.salaryRange,
    this.applicationStatus,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        company,
        description,
        requiredSkills,
        preferredSkills,
        level,
        type,
        location,
        isRemote,
        matchPercentage,
        postedDate,
        applicationDeadline,
        salaryRange,
        applicationStatus,
      ];

  factory CareerOpportunity.fromJson(Map<String, dynamic> json) {
    return CareerOpportunity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      description: json['description'] ?? '',
      requiredSkills: List<String>.from(json['requiredSkills'] ?? []),
      preferredSkills: List<String>.from(json['preferredSkills'] ?? []),
      level: json['level'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      isRemote: json['isRemote'] ?? false,
      matchPercentage: (json['matchPercentage'] ?? 0.0).toDouble(),
      postedDate: json['postedDate'] is DateTime 
          ? json['postedDate'] 
          : DateTime.parse(json['postedDate'].toString()),
      applicationDeadline: json['applicationDeadline'] != null
          ? (json['applicationDeadline'] is DateTime 
              ? json['applicationDeadline'] 
              : DateTime.parse(json['applicationDeadline'].toString()))
          : null,
      salaryRange: json['salaryRange'],
      applicationStatus: json['applicationStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'description': description,
      'requiredSkills': requiredSkills,
      'preferredSkills': preferredSkills,
      'level': level,
      'type': type,
      'location': location,
      'isRemote': isRemote,
      'matchPercentage': matchPercentage,
      'postedDate': postedDate.toIso8601String(),
      'applicationDeadline': applicationDeadline?.toIso8601String(),
      'salaryRange': salaryRange,
      'applicationStatus': applicationStatus,
    };
  }

  CareerOpportunity copyWith({
    String? id,
    String? title,
    String? company,
    String? description,
    List<String>? requiredSkills,
    List<String>? preferredSkills,
    String? level,
    String? type,
    String? location,
    bool? isRemote,
    double? matchPercentage,
    DateTime? postedDate,
    DateTime? applicationDeadline,
    String? salaryRange,
    String? applicationStatus,
  }) {
    return CareerOpportunity(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      description: description ?? this.description,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      preferredSkills: preferredSkills ?? this.preferredSkills,
      level: level ?? this.level,
      type: type ?? this.type,
      location: location ?? this.location,
      isRemote: isRemote ?? this.isRemote,
      matchPercentage: matchPercentage ?? this.matchPercentage,
      postedDate: postedDate ?? this.postedDate,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      salaryRange: salaryRange ?? this.salaryRange,
      applicationStatus: applicationStatus ?? this.applicationStatus,
    );
  }

  /// Get formatted posted date
  String get formattedPostedDate {
    final now = DateTime.now();
    final difference = now.difference(postedDate);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${postedDate.day}/${postedDate.month}/${postedDate.year}';
    }
  }

  /// Get match level description
  String get matchLevel {
    if (matchPercentage >= 0.8) return 'Excellent Match';
    if (matchPercentage >= 0.6) return 'Good Match';
    if (matchPercentage >= 0.4) return 'Fair Match';
    return 'Poor Match';
  }

  /// Get match color based on percentage
  String get matchColor {
    if (matchPercentage >= 0.8) return 'green';
    if (matchPercentage >= 0.6) return 'blue';
    if (matchPercentage >= 0.4) return 'orange';
    return 'red';
  }

  /// Check if application deadline is soon (within 7 days)
  bool get isDeadlineSoon {
    if (applicationDeadline == null) return false;
    final now = DateTime.now();
    final difference = applicationDeadline!.difference(now);
    return difference.inDays <= 7 && difference.inDays >= 0;
  }

  /// Check if application deadline has passed
  bool get isDeadlinePassed {
    if (applicationDeadline == null) return false;
    return DateTime.now().isAfter(applicationDeadline!);
  }
}
