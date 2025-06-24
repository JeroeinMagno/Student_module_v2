
import 'package:equatable/equatable.dart';

class Student extends Equatable {
  const Student({
    required this.id,
    required this.studentId,
    required this.name,
    required this.email,
    this.profileImage,
  });

  final String id;
  final String studentId;
  final String name;
  final String email;
  final String? profileImage;

  @override
  List<Object?> get props => [id, studentId, name, email, profileImage];
}
