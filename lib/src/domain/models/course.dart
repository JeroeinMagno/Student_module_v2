/// Represents a course in the student module
class Course {
  final String id;
  final String title;
  final String code;
  final String instructor;
  final String description;
  final String imageUrl;

  const Course({
    required this.id,
    required this.title,
    required this.code,
    required this.instructor,
    this.description = '',
    this.imageUrl = '',
  });

  Course copyWith({
    String? id,
    String? title,
    String? code,
    String? instructor,
    String? description,
    String? imageUrl,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      code: code ?? this.code,
      instructor: instructor ?? this.instructor,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'instructor': instructor,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String,
      instructor: json['instructor'] as String,
      description: (json['description'] as String?) ?? '',
      imageUrl: (json['imageUrl'] as String?) ?? '',
    );
  }
}
