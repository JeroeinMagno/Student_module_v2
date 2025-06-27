import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

/// Assessment table filters widget
class AssessmentTableFilters extends StatelessWidget {
  final List<Map<String, dynamic>> assessments;
  final bool showCourseFilter;
  final bool showTypeFilter;
  final String? courseFilter;
  final String? typeFilter;
  final ValueChanged<String?> onCourseFilterChanged;
  final ValueChanged<String?> onTypeFilterChanged;

  const AssessmentTableFilters({
    super.key,
    required this.assessments,
    required this.showCourseFilter,
    required this.showTypeFilter,
    required this.courseFilter,
    required this.typeFilter,
    required this.onCourseFilterChanged,
    required this.onTypeFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final courses = assessments
        .map((a) => a['course'] as String?)
        .where((c) => c != null)
        .toSet()
        .toList();
    
    final types = assessments
        .map((a) => a['type'] as String?)
        .where((t) => t != null)
        .toSet()
        .toList();

    return Row(
      children: [
        if (showCourseFilter) ...[
          Expanded(
            child: DropdownButtonFormField<String>(
              value: courseFilter,
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
              onChanged: onCourseFilterChanged,
            ),
          ),
          SizedBox(width: AppDimensions.paddingMD),
        ],
        if (showTypeFilter)
          Expanded(
            child: DropdownButtonFormField<String>(
              value: typeFilter,
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
              onChanged: onTypeFilterChanged,
            ),
          ),
      ],
    );
  }
}
