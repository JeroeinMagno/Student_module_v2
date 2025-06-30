import '../../../core/state/providers/assessments_provider.dart';

/// Helper functions for converting assessment data formats
class AssessmentDataConverter {
  /// Converts legacy assessment data format to Assessment objects
  static List<Assessment> convertLegacyData(List<Map<String, dynamic>> legacyData) {
    return legacyData.map((data) {
      final status = _convertStatus(data['status']?.toString() ?? 'pending');
      
      return Assessment(
        id: '${data['course']}_${data['type']}'.replaceAll(' ', '_').toLowerCase(),
        courseId: data['course']?.toString() ?? 'unknown',
        title: data['type']?.toString() ?? 'Assessment',
        type: _convertType(data['type']?.toString() ?? 'assignment'),
        description: '${data['type']} for ${data['course']}',
        dueDate: _parseDate(data['date']?.toString()),
        submissionDate: status == 'graded' ? _parseDate(data['date']?.toString()) : null,
        totalPoints: (data['maxScore'] as num?)?.toDouble() ?? 100.0,
        earnedPoints: (data['score'] as num?)?.toDouble(),
        status: status,
        feedback: null,
        attachments: [],
      );
    }).toList();
  }

  static String _convertStatus(String legacyStatus) {
    switch (legacyStatus.toLowerCase()) {
      case 'completed':
        return 'graded';
      case 'in progress':
        return 'pending';
      default:
        return 'pending';
    }
  }

  static String _convertType(String legacyType) {
    final type = legacyType.toLowerCase();
    if (type.contains('exam')) return 'exam';
    if (type.contains('quiz')) return 'quiz';
    if (type.contains('project')) return 'project';
    if (type.contains('assignment')) return 'assignment';
    return 'assignment';
  }

  static DateTime _parseDate(String? dateString) {
    if (dateString == null) return DateTime.now();
    
    try {
      // Handle "Nov 15, 2024" format
      if (dateString.contains(',')) {
        // Parse "Nov 15, 2024" format
        final parts = dateString.split(' ');
        if (parts.length == 3) {
          final month = _getMonthNumber(parts[0]);
          final day = int.parse(parts[1].replaceAll(',', ''));
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
      
      // Try standard ISO format
      return DateTime.parse(dateString);
    } catch (e) {
      print('Date parsing error for "$dateString": $e');
      return DateTime.now();
    }
  }
  
  static int _getMonthNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'jan': return 1;
      case 'feb': return 2;
      case 'mar': return 3;
      case 'apr': return 4;
      case 'may': return 5;
      case 'jun': return 6;
      case 'jul': return 7;
      case 'aug': return 8;
      case 'sep': return 9;
      case 'oct': return 10;
      case 'nov': return 11;
      case 'dec': return 12;
      default: return 1;
    }
  }
}
