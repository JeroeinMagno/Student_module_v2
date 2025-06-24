import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';

class AssessmentTable extends ConsumerWidget {
  const AssessmentTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Assessments',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Latest exam results',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ref.watch(recentAssessmentsProvider).when(
              data: (assessments) => ListView.builder(
                itemCount: assessments.length,
                itemBuilder: (context, index) {
                  final assessment = assessments[index];
                  final color = _getGradeColor(assessment.grade);
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assessment.subject,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${assessment.type} • ${assessment.score}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                assessment.courseCode,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            assessment.grade,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              loading: () => ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 14.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: 80.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, stack) => Center(
                child: Text(
                  'Failed to load assessments',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
      case 'A+':
        return const Color(0xFF6B9B8A);
      case 'A-':
        return const Color(0xFF9BC9B8);
      case 'B+':
      case 'B':
        return const Color(0xFFE8A87C);
      case 'B-':
      case 'C+':
        return const Color(0xFFE8A87C);
      case 'C':
      case 'C-':
      case 'D':
      case 'F':
        return const Color(0xFFE85A4F);
      default:
        return const Color(0xFF6B9B8A);
    }
  }
}
