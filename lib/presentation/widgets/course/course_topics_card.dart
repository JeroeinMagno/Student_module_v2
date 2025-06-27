import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying course topics with weekly schedule and ILO mapping
class CourseTopicsCard extends StatelessWidget {
  final List<Map<String, String>> courseTopics;

  const CourseTopicsCard({
    super.key,
    required this.courseTopics,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2D3A) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Topics',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4ADE80),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This table outlines the weekly topics and their corresponding intended learning outcomes (ILO).',
            style: TextStyle(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(height: 20.h),
          
          // Mobile-friendly list instead of table
          ...courseTopics.map((topic) => Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3F4A) : Colors.grey[50],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF4ADE80).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ADE80).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Week ${topic['week'] ?? ''}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4ADE80),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        topic['ilo'] ?? '',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  topic['topic'] ?? '',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
