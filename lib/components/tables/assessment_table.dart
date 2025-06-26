import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Advanced assessment table with sorting and filtering capabilities
class AssessmentTable extends StatefulWidget {
  final List<Map<String, dynamic>> assessments;
  final bool showCourseFilter;
  final bool showTypeFilter;
  final bool allowSorting;

  const AssessmentTable({
    super.key,
    required this.assessments,
    this.showCourseFilter = true,
    this.showTypeFilter = true,
    this.allowSorting = true,
  });

  @override
  State<AssessmentTable> createState() => _AssessmentTableState();
}

class _AssessmentTableState extends State<AssessmentTable> {
  String _sortColumn = 'date';
  bool _sortAscending = false;
  String? _courseFilter;
  String? _typeFilter;
  List<Map<String, dynamic>> _filteredAssessments = [];

  @override
  void initState() {
    super.initState();
    _filteredAssessments = widget.assessments;
    _applyFiltersAndSort();
  }

  @override
  void didUpdateWidget(AssessmentTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assessments != widget.assessments) {
      _filteredAssessments = widget.assessments;
      _applyFiltersAndSort();
    }
  }

  void _applyFiltersAndSort() {
    setState(() {
      _filteredAssessments = widget.assessments.where((assessment) {
        if (_courseFilter != null && assessment['course'] != _courseFilter) {
          return false;
        }
        if (_typeFilter != null && assessment['type'] != _typeFilter) {
          return false;
        }
        return true;
      }).toList();

      if (widget.allowSorting) {
        _filteredAssessments.sort((a, b) {
          dynamic aValue = a[_sortColumn];
          dynamic bValue = b[_sortColumn];

          if (aValue == null && bValue == null) return 0;
          if (aValue == null) return _sortAscending ? -1 : 1;
          if (bValue == null) return _sortAscending ? 1 : -1;

          int comparison = 0;
          if (aValue is String && bValue is String) {
            comparison = aValue.compareTo(bValue);
          } else if (aValue is num && bValue is num) {
            comparison = aValue.compareTo(bValue);
          } else if (aValue is DateTime && bValue is DateTime) {
            comparison = aValue.compareTo(bValue);
          }

          return _sortAscending ? comparison : -comparison;
        });
      }
    });
  }

  void _onSort(String column, bool ascending) {
    if (widget.allowSorting) {
      setState(() {
        _sortColumn = column;
        _sortAscending = ascending;
      });
      _applyFiltersAndSort();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (widget.showCourseFilter || widget.showTypeFilter) ...[
              SizedBox(height: AppDimensions.paddingMD),
              _buildFilters(),
            ],
            SizedBox(height: AppDimensions.paddingMD),
            _buildTable(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assessment Results',
                style: AppTextStyles.heading5.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                'Track your performance across all assessments',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // TODO: Show filter dialog
          },
          tooltip: 'Filter assessments',
        ),
      ],
    );
  }

  Widget _buildFilters() {
    final courses = widget.assessments
        .map((a) => a['course'] as String?)
        .where((c) => c != null)
        .toSet()
        .toList();
    
    final types = widget.assessments
        .map((a) => a['type'] as String?)
        .where((t) => t != null)
        .toSet()
        .toList();

    return Row(
      children: [
        if (widget.showCourseFilter) ...[
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _courseFilter,
              decoration: const InputDecoration(
                labelText: 'Course',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('All Courses'),
                ),
                ...courses.map((course) => DropdownMenuItem<String>(
                  value: course,
                  child: Text(course!),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _courseFilter = value;
                });
                _applyFiltersAndSort();
              },
            ),
          ),
          SizedBox(width: AppDimensions.paddingMD),
        ],
        if (widget.showTypeFilter)
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _typeFilter,
              decoration: const InputDecoration(
                labelText: 'Type',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('All Types'),
                ),
                ...types.map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type!),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _typeFilter = value;
                });
                _applyFiltersAndSort();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTable(bool isDarkMode) {
    if (_filteredAssessments.isEmpty) {
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
        sortColumnIndex: ['course', 'type', 'score', 'date'].indexOf(_sortColumn),
        sortAscending: _sortAscending,
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
            onSort: widget.allowSorting ? (columnIndex, ascending) => _onSort('course', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Assessment',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            onSort: widget.allowSorting ? (columnIndex, ascending) => _onSort('type', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Score',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            numeric: true,
            onSort: widget.allowSorting ? (columnIndex, ascending) => _onSort('score', ascending) : null,
          ),
          DataColumn(
            label: Text(
              'Date',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            onSort: widget.allowSorting ? (columnIndex, ascending) => _onSort('date', ascending) : null,
          ),
          const DataColumn(
            label: Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: _filteredAssessments.map((assessment) {
          final score = assessment['score'];
          final isCompleted = score != null;
          
          return DataRow(
            cells: [
              DataCell(
                Text(
                  assessment['course'] ?? 'Unknown',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              DataCell(
                Text(
                  assessment['type'] ?? 'Unknown',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isCompleted) ...[
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: _getGradeColor(score),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingXS),
                    ],
                    Text(
                      isCompleted 
                          ? '${score.toStringAsFixed(0)}/${assessment['maxScore']?.toStringAsFixed(0) ?? '100'}'
                          : 'TBD',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isCompleted ? _getGradeColor(score) : null,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  assessment['date'] ?? 'TBD',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              DataCell(
                AppBadge(
                  text: _getStatusText(assessment),
                  variant: isCompleted ? BadgeVariant.success : BadgeVariant.warning,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
