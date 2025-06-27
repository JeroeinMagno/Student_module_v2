import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Card widget displaying course progress overview with progress bars for each course
class CourseProgressOverview extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const CourseProgressOverview({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Progress Overview',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
              ),
            ),
            Text(
              'Track real-time progress in your enrolled courses',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            ...courses.map((course) {
              final progress = (course['progress'] ?? 0) / 100.0;
              return Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
                child: CourseProgressBar(
                  courseCode: course['code'] ?? 'Unknown',
                  progress: progress,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
