import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../constants/constants.dart';
import '../components.dart';

class ExamScoreCard extends StatelessWidget {
  final Map<String, dynamic> exam;
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
                  exam['title']?.toString() ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppBadge(
                text: exam['type']?.toString() ?? '',
                variant: BadgeVariant.outline,
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          // Course code
          Text(
            exam['courseCode']?.toString() ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          SizedBox(height: 12.h),
          
          // Date and Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(exam['date']),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Score',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _buildScoreWidget(exam['score'], theme),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'TBD';
    
    try {
      if (date is DateTime) {
        return DateFormat('MMM d, yyyy').format(date);
      } else if (date is String) {
        final parsedDate = DateTime.tryParse(date);
        if (parsedDate != null) {
          return DateFormat('MMM d, yyyy').format(parsedDate);
        }
      }
    } catch (e) {
      // Handle parsing errors
    }
    
    return date.toString();
  }

  Widget _buildScoreWidget(dynamic score, ThemeData theme) {
    if (score == null) {
      return Text(
        'N/A',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      );
    }
    
    final scoreText = score.toString();
    final numericScore = double.tryParse(scoreText.replaceAll('%', ''));
    
    return Text(
      scoreText.contains('%') ? scoreText : '$scoreText%',
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: _getScoreColor(numericScore),
      ),
    );
  }

  Color _getScoreColor(double? score) {
    if (score == null) return AppColors.textSecondary;
    
    if (score >= 90) return AppColors.success;
    if (score >= 80) return AppColors.primary;
    if (score >= 70) return AppColors.warning;
    return AppColors.error;
  }
}
