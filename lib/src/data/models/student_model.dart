import '../../domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.name,
    required super.srCode,
    required super.avatar,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
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

  factory StudentModel.fromEntity(Student student) {
    return StudentModel(
      name: student.name,
      srCode: student.srCode,
      avatar: student.avatar,
    );
  }
}
