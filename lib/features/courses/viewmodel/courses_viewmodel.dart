import 'package:flutter/material.dart';
import '../../../services/data_service.dart';
import '../model/course.dart';
import '../../../constants/constants.dart';

class CoursesViewModel extends ChangeNotifier {
  final DataService _dataService;
  
  CoursesViewModel(this._dataService);

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;
  String _selectedSemester = '1st Semester';
  String _selectedAcademicYear = '2025-2026';

  // Getters
  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedSemester => _selectedSemester;
  String get selectedAcademicYear => _selectedAcademicYear;

  // Filtered courses based on selected period
  List<Course> get filteredCourses {
    return _courses.where((course) {
      return course.semester == _selectedSemester &&
             course.academicYear == _selectedAcademicYear;
    }).toList();
  }

  // Course statistics
  int get totalCourses => filteredCourses.length;
  int get completedCourses => filteredCourses.where((c) => c.isCompleted).length;
  int get inProgressCourses => filteredCourses.where((c) => c.isInProgress).length;
  int get notStartedCourses => filteredCourses.where((c) => c.isNotStarted).length;
  
  double get overallProgress {
    if (filteredCourses.isEmpty) return 0.0;
    final totalProgress = filteredCourses.fold<double>(
      0.0, 
      (sum, course) => sum + course.progress,
    );
    return totalProgress / filteredCourses.length;
  }
  
  double get averageGrade {
    final coursesWithGrades = filteredCourses.where((c) => c.grade != null);
    if (coursesWithGrades.isEmpty) return 0.0;
    final totalGrades = coursesWithGrades.fold<double>(
      0.0, 
      (sum, course) => sum + course.grade!,
    );
    return totalGrades / coursesWithGrades.length;
  }

  Future<void> loadCourses() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Get mock course data from data service
      final courseData = await _dataService.getCourses();
      _courses = courseData.map((data) => _mapToCourse(data)).toList();
    } catch (e) {
      _error = 'Failed to load courses: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Course _mapToCourse(Map<String, dynamic> data) {
    return Course(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? 'Unknown Course',
      code: data['code']?.toString() ?? 'N/A',
      progress: data['progress'] != null ? (data['progress'] as num).toDouble() : 0.0,
      color: _getCourseColor(data['code']?.toString() ?? 'default'),
      professor: data['professor']?.toString() ?? 'TBD',
      description: data['description']?.toString() ?? 'No description available',
      semester: data['semester']?.toString() ?? 'N/A',
      academicYear: data['academicYear']?.toString() ?? 'N/A',
      units: data['units'] != null ? data['units'] as int : 3,
      grade: data['grade'] != null ? (data['grade'] as num).toDouble() : null,
      status: data['status']?.toString(),
      schedule: data['schedule']?.toString(),
      room: data['room']?.toString(),
      prerequisites: data['prerequisites'] != null
          ? List<String>.from(data['prerequisites'])
          : null,
    );
  }

  Color _getCourseColor(String courseCode) {
    // Generate consistent colors based on course code
    final hash = courseCode.hashCode;
    return AppColors.chartColors[hash.abs() % AppColors.chartColors.length];
  }

  void updatePeriod(String academicYear, String semester) {
    _selectedAcademicYear = academicYear;
    _selectedSemester = semester;
    notifyListeners();
  }

  Course? getCourseById(String id) {
    try {
      return _courses.firstWhere((course) => course.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Course> searchCourses(String query) {
    if (query.isEmpty) return filteredCourses;
    
    final lowercaseQuery = query.toLowerCase();
    return filteredCourses.where((course) {
      return course.name.toLowerCase().contains(lowercaseQuery) ||
             course.code.toLowerCase().contains(lowercaseQuery) ||
             course.professor.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Course> getCoursesByStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return filteredCourses.where((c) => c.isCompleted).toList();
      case 'in progress':
        return filteredCourses.where((c) => c.isInProgress).toList();
      case 'not started':
        return filteredCourses.where((c) => c.isNotStarted).toList();
      default:
        return filteredCourses;
    }
  }

  void refreshCourses() {
    loadCourses();
  }
}
