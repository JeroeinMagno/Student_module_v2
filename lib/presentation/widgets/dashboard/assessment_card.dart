import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../../../core/state/providers/assessments_provider.dart';
import 'assessment_status_toggle.dart';
import 'assessment_list_item.dart';

/// Main assessment card with Completed/In Progress toggle functionality
class AssessmentCard extends StatefulWidget {
  final List<Assessment> assessments;
  final Function(Assessment)? onAssessmentTap;
  final String title;
  final String subtitle;
  
  const AssessmentCard({
    Key? key,
    required this.assessments,
    this.onAssessmentTap,
    this.title = 'Recent Assessments',
    this.subtitle = 'Your latest assessment results',
  }) : super(key: key);

  @override
  State<AssessmentCard> createState() => _AssessmentCardState();
}

class _AssessmentCardState extends State<AssessmentCard> {
  bool _showCompleted = true;

  List<Assessment> get _filteredAssessments {
    final filtered = widget.assessments.where((assessment) {
      if (_showCompleted) {
        return assessment.status == 'graded' || assessment.status == 'completed';
      } else {
        return assessment.status == 'pending' || assessment.status == 'submitted';
      }
    }).toList();
    
    // Debug output
    print('Total assessments: ${widget.assessments.length}');
    print('Show completed: $_showCompleted');
    print('Filtered assessments: ${filtered.length}');
    for (var assessment in widget.assessments) {
      print('  ${assessment.title} - ${assessment.status}');
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return AppCard(
      child: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                Text(
                  widget.title,
                  style: AppTextStyles.heading6.copyWith(
                    color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDarkMode 
                        ? Colors.white.withOpacity(0.7) 
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingMD),
                
                // Toggle buttons
                AssessmentStatusToggle(
                  isCompleted: _showCompleted,
                  onToggle: (isCompleted) {
                    setState(() {
                      _showCompleted = isCompleted;
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Assessment list section
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.mutedDark : AppColors.muted,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: _buildAssessmentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentList() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    if (_filteredAssessments.isEmpty) {
      return Container(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          children: [
            Icon(
              _showCompleted ? Icons.check_circle_outline : Icons.hourglass_empty,
              size: 48.sp,
              color: isDarkMode ? AppColors.mutedForegroundDark : AppColors.mutedForeground,
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              _showCompleted 
                ? 'No completed assessments yet.' 
                : 'No assessments in progress.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDarkMode ? AppColors.mutedForegroundDark : AppColors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header row
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMD,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDarkMode ? AppColors.borderDark : AppColors.border, 
                width: 1
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Course Code',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Assessment',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Status',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Score',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        
        // Assessment items
        ...(_filteredAssessments.asMap().entries.map((entry) {
          final index = entry.key;
          final assessment = entry.value;
          final isLast = index == _filteredAssessments.length - 1;
          
          return AssessmentListItem(
            assessment: assessment,
            isLast: isLast,
            onTap: () => widget.onAssessmentTap?.call(assessment),
          );
        }).toList()),
      ],
    );
  }
}
