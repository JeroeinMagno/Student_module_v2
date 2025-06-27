import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Table widget displaying recent assessments with scores and status
class RecentAssessmentsTable extends StatelessWidget {
  final List<Map<String, dynamic>> recentAssessments;

  const RecentAssessmentsTable({
    super.key,
    required this.recentAssessments,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Assessments',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Your latest assessment results',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                ),
                columns: [
                  DataColumn(
                    label: Text('Course', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Assessment', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Score', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Date', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: recentAssessments.map((assessment) {
                  final isCompleted = assessment['status'] == 'Completed';
                  final score = assessment['score'];
                  
                  return DataRow(
                    cells: [
                      DataCell(Text(assessment['course'], style: TextStyle(color: textColor))),
                      DataCell(Text(assessment['type'], style: TextStyle(color: textColor))),
                      DataCell(
                        Text(
                          score != null 
                              ? '${((score / assessment['maxScore']) * 100).toStringAsFixed(1)}%' 
                              : 'TBD',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      DataCell(Text(assessment['date'], style: TextStyle(color: textColor))),
                      DataCell(
                        AppBadge(
                          text: assessment['status'],
                          variant: isCompleted ? BadgeVariant.success : BadgeVariant.warning,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
