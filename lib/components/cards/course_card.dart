import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/constants.dart';
import '../components.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                course['code'] ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              AppBadge(
                text: '${course['credits'] ?? 0} Credits',
                variant: BadgeVariant.outline,
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            course['name'] ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: 16.h),
          
          // Progress and grade
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppProgress(
                      value: (course['progress'] ?? 0) / 100.0,
                      showPercentage: true,
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 16.w),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Current Grade',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    course['currentGrade']?.toString() ?? 'N/A',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: course['currentGrade'] != null 
                          ? _getGradeColor(course['currentGrade']?.toString())
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String? grade) {
    if (grade == null) return AppColors.textSecondary;
    
    final numericGrade = double.tryParse(grade.replaceAll('%', ''));
    if (numericGrade == null) {
      // Letter grades
      switch (grade.toUpperCase()) {
        case 'A':
        case 'A+':
          return AppColors.success;
        case 'B':
        case 'B+':
          return AppColors.primary;
        case 'C':
        case 'C+':
          return AppColors.warning;
        case 'D':
        case 'F':
          return AppColors.error;
        default:
          return AppColors.textSecondary;
      }
    }
    
    // Numeric grades
    if (numericGrade >= 90) return AppColors.success;
    if (numericGrade >= 80) return AppColors.primary;
    if (numericGrade >= 70) return AppColors.warning;
    return AppColors.error;
  }
}
