import '../../presentation/widgets/tables/table_widgets.dart' as ui;

/// Assessment Data Converter
/// Converts centralized mock data to UI-specific models
class AssessmentConverter {
  /// Convert centralized assessment data to UI Assessment model
  static ui.Assessment toUIAssessment(Map<String, dynamic> data) {
    return ui.Assessment(
      courseCode: data['courseCode'] ?? '',
      type: data['type'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
      status: _parseAssessmentStatus(data['status']),
      score: data['numericScore']?.toDouble(),
    );
  }

  /// Convert list of centralized assessment data to UI Assessment models
  static List<ui.Assessment> toUIAssessmentList(List<Map<String, dynamic>> dataList) {
    return dataList.map((data) => toUIAssessment(data)).toList();
  }

  /// Parse assessment status string to enum
  static ui.AssessmentStatus _parseAssessmentStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return ui.AssessmentStatus.completed;
      case 'upcoming':
        return ui.AssessmentStatus.upcoming;
      case 'missing':
        return ui.AssessmentStatus.missing;
      default:
        return ui.AssessmentStatus.upcoming;
    }
  }

  /// Convert UI Assessment back to centralized format (if needed)
  static Map<String, dynamic> fromUIAssessment(ui.Assessment assessment) {
    return {
      'courseCode': assessment.courseCode,
      'type': assessment.type,
      'date': assessment.date.toIso8601String().split('T')[0],
      'status': assessment.status.name,
      'numericScore': assessment.score,
    };
  }

  /// Get assessment summary statistics
  static Map<String, dynamic> getAssessmentSummary(List<Map<String, dynamic>> assessments) {
    final completed = assessments.where((a) => a['status'] == 'completed').toList();
    final upcoming = assessments.where((a) => a['status'] == 'upcoming').toList();
    final missing = assessments.where((a) => a['status'] == 'missing').toList();

    double averageScore = 0.0;
    if (completed.isNotEmpty) {
      final scores = completed
          .where((a) => a['numericScore'] != null)
          .map((a) => (a['numericScore'] as num).toDouble());
      if (scores.isNotEmpty) {
        averageScore = scores.reduce((a, b) => a + b) / scores.length;
      }
    }

    return {
      'total': assessments.length,
      'completed': completed.length,
      'upcoming': upcoming.length,
      'missing': missing.length,
      'averageScore': averageScore,
      'completionRate': assessments.isNotEmpty 
          ? (completed.length / assessments.length * 100).round() 
          : 0,
    };
  }
}
