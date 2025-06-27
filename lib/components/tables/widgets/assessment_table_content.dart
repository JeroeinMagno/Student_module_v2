import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

/// Assessment table content widget
class AssessmentTableContent extends StatelessWidget {
  final List<Map<String, dynamic>> assessments;
  final bool allowSorting;
  final String sortColumn;
  final bool sortAscending;
  final Function(String, bool)? onSort;

  const AssessmentTableContent({
    super.key,
    required this.assessments,
    required this.allowSorting,
    required this.sortColumn,
    required this.sortAscending,
    this.onSort,
  });

  Color _getGradeColor(dynamic grade) {
    if (grade == null) return AppColors.warning;
    
    final gradeValue = grade is String ? double.tryParse(grade) : grade.toDouble();
    if (gradeValue == null) return AppColors.warning;

    if (gradeValue >= 90) return AppColors.success;
    if (gradeValue >= 80) return AppColors.primary;
    if (gradeValue >= 70) return AppColors.warning;
    return AppColors.error;
  }

  String _getStatusText(Map<String, dynamic> assessment) {
    if (assessment['score'] == null) return 'Pending';
    return 'Completed';
  }

  Widget _buildGradeChip(Map<String, dynamic> assessment, bool isDarkMode) {
    final score = assessment['score'];
    final status = _getStatusText(assessment);
    final gradeColor = _getGradeColor(score);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: gradeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gradeColor.withOpacity(0.3)),
      ),
      child: Text(
        score != null ? '${score.toStringAsFixed(0)}%' : status,
        style: AppTextStyles.labelSmall.copyWith(
          color: gradeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    if (assessments.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: AppDimensions.paddingMD),
              Text(
                'No assessments found',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: ['course', 'type', 'score', 'date'].indexOf(sortColumn),
        sortAscending: sortAscending,
        headingRowColor: MaterialStateProperty.all(
          isDarkMode 
              ? Colors.white.withOpacity(0.05) 
              : Colors.grey.withOpacity(0.1),
        ),
        columns: [
          DataColumn(
            label: Text(
              'Course',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            onSort: allowSorting && onSort != null ? (columnIndex, ascending) => onSort!('course', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Assessment',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            onSort: allowSorting && onSort != null ? (columnIndex, ascending) => onSort!('type', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Score',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            numeric: true,
            onSort: allowSorting && onSort != null ? (columnIndex, ascending) => onSort!('score', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Date',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            onSort: allowSorting && onSort != null ? (columnIndex, ascending) => onSort!('date', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Status',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: assessments.map((assessment) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  assessment['courseCode'] ?? assessment['course'] ?? 'N/A',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      assessment['title'] ?? 'N/A',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      assessment['type'] ?? 'N/A',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                _buildGradeChip(assessment, isDarkMode),
              ),
              DataCell(
                Text(
                  assessment['date']?.toString().split(' ')[0] ?? 'N/A',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: assessment['score'] != null 
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(assessment),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: assessment['score'] != null 
                          ? AppColors.success
                          : AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
