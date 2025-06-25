import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseProgressBar extends StatelessWidget {
  final String courseCode;
  final double progress;

  const CourseProgressBar({
    super.key,
    required this.courseCode,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black87;

    return Column(
      children: [
        Row(
          children: [
            Text(
              courseCode,
              style: TextStyle(
                color: textColor,
                fontSize: 14.sp,
              ),
            ),
            const Spacer(),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor:
                isDarkMode ? Colors.white10 : Colors.black.withValues(alpha: 0.1),
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }
}
