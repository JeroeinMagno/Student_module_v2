import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../core/state/providers/assessments_provider.dart';

/// Individual assessment list item component
class AssessmentListItem extends StatelessWidget {
  final Assessment assessment;
  final bool isLast;
  final VoidCallback? onTap;

  const AssessmentListItem({
    super.key,
    required this.assessment,
    required this.isLast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          border: isLast 
            ? null 
            : Border(
                bottom: BorderSide(
                  color: isDarkMode 
                      ? AppColors.borderDark 
                      : AppColors.border,
                  width: 0.5,
                ),
              ),
        ),
        child: Row(
          children: [
            // Course Code
            Expanded(
              flex: 2,
              child: Text(
                _getCourseCode(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            // Assessment Name
            Expanded(
              flex: 2,
              child: Text(
                assessment.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Status
            Expanded(
              flex: 2,
              child: _buildStatusChip(),
            ),
            
            // Score
            Expanded(
              flex: 1,
              child: Text(
                _getScoreText(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    final isCompleted = assessment.status == 'graded' || assessment.status == 'completed';
    final backgroundColor = isCompleted 
        ? AppColors.success 
        : AppColors.warning;
    
    final statusText = isCompleted ? 'Completed' : 'In Progress';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        statusText,
        style: AppTextStyles.labelSmall.copyWith(
          color: isCompleted ? AppColors.successForeground : AppColors.warningForeground,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getCourseCode() {
    // This would normally come from a course lookup by courseId
    // For now, using a placeholder based on courseId
    return assessment.courseId.toUpperCase();
  }

  String _getScoreText() {
    if (assessment.earnedPoints != null && assessment.totalPoints > 0) {
      final percentage = (assessment.earnedPoints! / assessment.totalPoints) * 100;
      return '${percentage.toStringAsFixed(0)}%';
    }
    return 'TBD';
  }
}
