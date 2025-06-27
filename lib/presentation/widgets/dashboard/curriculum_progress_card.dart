import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Card widget displaying curriculum progress and completion status
class CurriculumProgressCard extends StatelessWidget {
  final int totalRequiredCourses;
  final int completedCourses;
  final int currentCourses;
  final int progressPercentage;
  final String? programName;

  const CurriculumProgressCard({
    super.key,
    required this.totalRequiredCourses,
    required this.completedCourses,
    required this.currentCourses,
    required this.progressPercentage,
    this.programName,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final totalCourses = completedCourses + currentCourses;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curriculum',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            if (programName != null) ...[
              SizedBox(height: AppDimensions.paddingXS),
              Text(
                programName!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDarkMode 
                      ? Colors.white.withOpacity(0.7) 
                      : Colors.black.withOpacity(0.7),
                ),
              ),
            ],
            SizedBox(height: AppDimensions.paddingMD),
            Row(
              children: [
                Text(
                  '$totalCourses/$totalRequiredCourses',
                  style: AppTextStyles.heading3.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSM),
                Expanded(
                  child: Text(
                    'You completed $progressPercentage% of your curriculum.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDarkMode 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              '$completedCourses completed, $currentCourses in progress',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
