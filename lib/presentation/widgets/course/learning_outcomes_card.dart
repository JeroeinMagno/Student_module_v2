import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying course learning outcomes in a mobile-friendly format
class LearningOutcomesCard extends StatelessWidget {
  final List<Map<String, String>> learningOutcomes;

  const LearningOutcomesCard({
    super.key,
    required this.learningOutcomes,
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
            'Intended Learning Outcomes',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4ADE80),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This table lists each ILO and its description.',
            style: TextStyle(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(height: 20.h),
          
          // Mobile-friendly list instead of table
          ...learningOutcomes.map((outcome) => Container(
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4ADE80).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    outcome['ilo'] ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4ADE80),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  outcome['description'] ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
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
