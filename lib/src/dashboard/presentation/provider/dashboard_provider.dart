
import 'package:flutter/material.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/course.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/dashboard_repository.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/exam.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/domain/student.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository repository;

  DashboardProvider({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  List<Exam> _exams = [];
  List<Exam> get exams => _exams;

  Student? _student;
  Student? get student => _student;

  Future<void> getCourses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _courses = await repository.getCourses();
    } catch (e) {
      // TODO: Handle error
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getExams() async {
    _isLoading = true;
    notifyListeners();
    try {
      _exams = await repository.getExams();
    } catch (e) {
      // TODO: Handle error
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getStudent(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _student = await repository.getStudent(id);
    } catch (e) {
      // TODO: Handle error
    }
    _isLoading = false;
    notifyListeners();
  }
}
