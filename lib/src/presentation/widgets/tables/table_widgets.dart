import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../common/app_components.dart';

class AssessmentTable extends StatelessWidget {
  final List<Assessment> assessments;
  final String title;
  final bool showHeader;

  const AssessmentTable({
    super.key,
    required this.assessments,
    this.title = 'Recent Assessments',
    this.showHeader = true,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Sort assessments by date (most recent first)
    final sortedAssessments = List<Assessment>.from(assessments)
      ..sort((a, b) => b.date.compareTo(a.date));

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) ...[
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const AppSeparator(),
          ],
          
          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20.w,
              horizontalMargin: 16.w,
              headingRowHeight: 48.h,
              dataRowMinHeight: 56.h,
              dataRowMaxHeight: 56.h,
              dividerThickness: 0,
              headingTextStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
              dataTextStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              columns: const [
                DataColumn(label: Text('Course')),
                DataColumn(label: Text('Assessment')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Score')),
              ],
              rows: sortedAssessments.map((assessment) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        assessment.courseCode,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    DataCell(Text(assessment.type)),
                    DataCell(
                      Text(
                        DateFormat('MMM d, yyyy').format(assessment.date),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    DataCell(_buildStatusBadge(assessment.status)),
                    DataCell(_buildScoreWidget(assessment, theme)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(AssessmentStatus status) {
    switch (status) {
      case AssessmentStatus.completed:
        return const AppBadge.success(text: 'Completed');
      case AssessmentStatus.upcoming:
        return const AppBadge.outline(text: 'Upcoming');
      case AssessmentStatus.missing:
        return const AppBadge.destructive(text: 'Missing');
    }
  }

  Widget _buildScoreWidget(Assessment assessment, ThemeData theme) {
    if (assessment.status == AssessmentStatus.completed && assessment.score != null) {
      return Text(
        '${assessment.score}%',
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      );
    }
    
    return Text(
      '—',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: AppTheme.textSecondary,
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
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
                course.code,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              AppBadge(
                text: '${course.credits} Credits',
                variant: BadgeVariant.outline,
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            course.name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
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
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppProgress(
                      value: course.progress / 100,
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
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    course.currentGrade ?? 'N/A',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: course.currentGrade != null 
                          ? _getGradeColor(course.currentGrade)
                          : AppTheme.textSecondary,
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
    if (grade == null) return AppTheme.textSecondary;
    
    final numericGrade = double.tryParse(grade.replaceAll('%', ''));
    if (numericGrade == null) {
      // Letter grades
      switch (grade.toUpperCase()) {
        case 'A':
        case 'A+':
          return AppTheme.success;
        case 'B':
        case 'B+':
          return AppTheme.primaryGreen;
        case 'C':
        case 'C+':
          return AppTheme.warning;
        case 'D':
        case 'F':
          return AppTheme.destructive;
        default:
          return AppTheme.textSecondary;
      }
    }
    
    // Numeric grades
    if (numericGrade >= 90) return AppTheme.success;
    if (numericGrade >= 80) return AppTheme.primaryGreen;
    if (numericGrade >= 70) return AppTheme.warning;
    return AppTheme.destructive;
  }
}

class ExamScoreCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback? onTap;

  const ExamScoreCard({
    super.key,
    required this.exam,
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
          // Exam header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  exam.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppBadge(
                text: exam.type,
                backgroundColor: _getExamTypeColor(exam.type).withValues(alpha: 0.1),
                textColor: _getExamTypeColor(exam.type),
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            exam.courseCode,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Score and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Score',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    exam.score != null ? '${exam.score}%' : 'Pending',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: exam.score != null 
                          ? _getScoreColor(exam.score!)
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Date',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('MMM d').format(exam.date),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
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

  Color _getExamTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'quiz':
        return AppTheme.chartColors[0];
      case 'prelims':
        return AppTheme.chartColors[1];
      case 'midterms':
        return AppTheme.chartColors[2];
      case 'finals':
        return AppTheme.chartColors[3];
      default:
        return AppTheme.primaryGreen;
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return AppTheme.success;
    if (score >= 80) return AppTheme.primaryGreen;
    if (score >= 70) return AppTheme.warning;
    return AppTheme.destructive;
  }
}

class GradeCard extends StatelessWidget {
  final String subject;
  final String grade;
  final double? percentage;
  final String semester;
  final VoidCallback? onTap;

  const GradeCard({
    super.key,
    required this.subject,
    required this.grade,
    this.percentage,
    required this.semester,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getGradeColor(grade).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
                ),
                child: Text(
                  grade,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _getGradeColor(grade),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          if (percentage != null) ...[
            Text(
              '${percentage!.toStringAsFixed(1)}%',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: _getGradeColor(grade),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          
          Text(
            semester,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
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
        return AppTheme.success;
      case 'B':
      case 'B+':
        return AppTheme.primaryGreen;
      case 'C':
      case 'C+':
        return AppTheme.warning;
      case 'D':
      case 'F':
        return AppTheme.destructive;
      default:
        return AppTheme.textSecondary;
    }
  }
}

// Data Models
class Assessment {
  final String courseCode;
  final String type;
  final DateTime date;
  final AssessmentStatus status;
  final double? score;

  Assessment({
    required this.courseCode,
    required this.type,
    required this.date,
    required this.status,
    this.score,
  });
}

enum AssessmentStatus { upcoming, completed, missing }

class Course {
  final String code;
  final String name;
  final int credits;
  final double progress;
  final String? currentGrade;

  Course({
    required this.code,
    required this.name,
    required this.credits,
    required this.progress,
    this.currentGrade,
  });
}

class Exam {
  final String title;
  final String courseCode;
  final String type;
  final DateTime date;
  final double? score;

  Exam({
    required this.title,
    required this.courseCode,
    required this.type,
    required this.date,
    this.score,
  });
}
