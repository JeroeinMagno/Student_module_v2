
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_student_module_v2/src/dashboard/data/course_dto.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/data/exam_dto.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/data/student_dto.dart';

class DashboardApiService {
  final String _baseUrl = 'http://localhost:3000/api';

  Future<List<CourseDto>> getCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl/courses'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CourseDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<ExamDto>> getExams() async {
    final response = await http.get(Uri.parse('$_baseUrl/exams'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ExamDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exams');
    }
  }

  Future<StudentDto> getStudent(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/students/$id'));

    if (response.statusCode == 200) {
      return StudentDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student');
    }
  }
}
