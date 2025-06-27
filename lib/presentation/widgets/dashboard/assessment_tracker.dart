import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Card widget displaying assessment tracker with circular progress indicator
class AssessmentTracker extends StatelessWidget {
  final Map<String, dynamic> assessmentOverview;

  const AssessmentTracker({
    super.key,
    required this.assessmentOverview,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final progressBackgroundColor = isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.1);
    
    final totalAssessments = assessmentOverview['totalAssessments'] ?? 0;
    final completedAssessments = assessmentOverview['completed'] ?? 0;
    final progress = totalAssessments > 0 ? completedAssessments / totalAssessments : 0.0;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assessment Tracker',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Completed vs. In Progress',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Center(
              child: SizedBox(
                height: 160.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 160.h,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 12.w,
                        backgroundColor: progressBackgroundColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$totalAssessments',
                          style: AppTextStyles.heading1.copyWith(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 36.sp,
                          ),
                        ),
                        Text(
                          'Total Assessments',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isDarkMode 
                                ? Colors.white.withOpacity(0.7) 
                                : Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Center(
              child: Column(
                children: [
                  Text(
                    '$completedAssessments completed, ${totalAssessments - completedAssessments} in progress',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    'Tracking assessments this semester',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDarkMode 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
