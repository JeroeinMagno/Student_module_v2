import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying criteria completion status with circular progress indicator
class CriteriaCompletionCard extends StatelessWidget {
  final double completionPercentage;
  final List<String> completedCriteria;
  final List<String> pendingCriteria;

  const CriteriaCompletionCard({
    super.key,
    required this.completionPercentage,
    required this.completedCriteria,
    required this.pendingCriteria,
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
            'Criteria Completion',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Track your assessment requirements',
            style: TextStyle(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          SizedBox(height: 24.h),
          
          // Circular Progress - more compact for mobile
          Center(
            child: SizedBox(
              width: 100.w,
              height: 100.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 100.w,
                    child: CircularProgressIndicator(
                      value: completionPercentage / 100,
                      strokeWidth: 10.w,
                      backgroundColor: isDarkMode ? const Color(0xFF3A3F4A) : Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4ADE80)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${completionPercentage.toInt()}%',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          
          // Completed Criteria List
          ...completedCriteria.map((criteria) => Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4ADE80).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF4ADE80).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 18.w,
                  color: const Color(0xFF4ADE80),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    criteria,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4ADE80),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
          
          // Pending Criteria List
          ...pendingCriteria.map((criteria) => Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3F4A) : Colors.grey[50],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isDarkMode ? Colors.grey[600]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  size: 18.w,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    criteria,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
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
