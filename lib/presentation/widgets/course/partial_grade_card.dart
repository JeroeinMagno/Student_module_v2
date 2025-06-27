import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying partial grade with progress bar and status
class PartialGradeCard extends StatelessWidget {
  final double currentGrade;
  final String gradeStatus;
  final String? description;

  const PartialGradeCard({
    super.key,
    required this.currentGrade,
    required this.gradeStatus,
    this.description,
  });

  Color _getGradeColor() {
    if (currentGrade >= 75) return const Color(0xFF4ADE80);
    if (currentGrade >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradeColor = _getGradeColor();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Partial Grade',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: gradeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  gradeStatus,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: gradeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            description ?? 'Your current grade based on completed assessments only.',
            style: TextStyle(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(height: 24.h),
          
          // Large Grade Display - centered for better visual impact
          Center(
            child: Column(
              children: [
                Text(
                  '${currentGrade.toInt()}%',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: gradeColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Current Standing',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          
          // Progress Bar with rounded ends
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3F4A) : Colors.grey[200],
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              widthFactor: currentGrade / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: gradeColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          
          // Info section with better spacing
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: gradeColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.w,
                  color: gradeColor,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'This score reflects your current standing based on recorded results only.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: gradeColor,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
