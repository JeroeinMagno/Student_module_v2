import 'package:equatable/equatable.dart';

/// Student entity representing a student in the system
class Student extends Equatable {
  final String name;
  final String srCode;
  final String avatar;

  const Student({
    required this.name,
    required this.srCode,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, srCode, avatar];

  Student copyWith({
    String? name,
    String? srCode,
    String? avatar,
  }) {
    return Student(
      name: name ?? this.name,
      srCode: srCode ?? this.srCode,
      avatar: avatar ?? this.avatar,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      srCode: json['srCode'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'srCode': srCode,
      'avatar': avatar,
    };
  }
}
