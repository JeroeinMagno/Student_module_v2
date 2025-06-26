import 'package:flutter/foundation.dart';
import '../../../services/data_service.dart';
import '../../../core/service_locator.dart';
import '../model/exam.dart';

class ExamViewModel extends ChangeNotifier {
  final DataService _dataService = serviceLocator<DataService>();
  
  List<Exam> _exams = [];
  bool _isLoading = false;
  String? _error;

  List<Exam> get exams => _exams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Get exams filtered by status
  List<Exam> getExamsByStatus(String status) {
    return _exams.where((exam) => exam.status.toLowerCase() == status.toLowerCase()).toList();
  }

  /// Get upcoming exams (sorted by date)
  List<Exam> get upcomingExams {
    final upcoming = getExamsByStatus('upcoming');
    upcoming.sort((a, b) => a.date.compareTo(b.date));
    return upcoming;
  }

  /// Get completed exams (sorted by date, most recent first)
  List<Exam> get completedExams {
    final completed = getExamsByStatus('completed');
    completed.sort((a, b) => b.date.compareTo(a.date));
    return completed;
  }

  /// Get missing exams
  List<Exam> get missingExams {
    return getExamsByStatus('missing');
  }

  /// Get exam overview statistics
  Map<String, dynamic> get examOverview {
    final total = _exams.length;
    final completed = completedExams.length;
    final upcoming = upcomingExams.length;
    final missing = missingExams.length;

    double averageScore = 0.0;
    if (completedExams.isNotEmpty) {
      final totalScore = completedExams
          .where((exam) => exam.percentage != null)
          .fold<double>(0.0, (sum, exam) => sum + exam.percentage!);
      averageScore = totalScore / completedExams.where((exam) => exam.percentage != null).length;
    }

    return {
      'total': total,
      'completed': completed,
      'upcoming': upcoming,
      'missing': missing,
      'averageScore': averageScore,
    };
  }

  /// Load all exams
  Future<void> loadExams() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final examData = await _dataService.getAllExams();
      _exams = examData.map((data) => Exam.fromJson(data)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load exams: $e';
      _exams = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load exams for a specific course
  Future<void> loadExamsByCourse(String courseId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final examData = await _dataService.getExamsByCourse(courseId);
      _exams = examData.map((data) => Exam.fromJson(data)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load course exams: $e';
      _exams = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get exam by ID
  Exam? getExamById(String examId) {
    try {
      return _exams.firstWhere((exam) => exam.id == examId);
    } catch (e) {
      return null;
    }
  }

  /// Get exams by course
  List<Exam> getExamsByCourse(String courseId) {
    return _exams.where((exam) => exam.courseId == courseId).toList();
  }

  /// Refresh exams
  Future<void> refreshExams() async {
    await loadExams();
  }

  /// Clear any error state
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
