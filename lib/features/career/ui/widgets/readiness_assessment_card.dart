import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../model/career_profile.dart';

/// Widget for displaying career readiness assessment breakdown
class ReadinessAssessmentCard extends StatelessWidget {
  final CareerProfile profile;

  const ReadinessAssessmentCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Readiness Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Expanded(
              child: ListView.builder(
                itemCount: profile.readinessScores.length,
                itemBuilder: (context, index) {
                  final category = profile.readinessScores.keys.elementAt(index);
                  final score = profile.readinessScores[category]!;
                  return ReadinessItem(
                    category: category,
                    score: score,
                    profile: profile,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual readiness category item
class ReadinessItem extends StatelessWidget {
  final String category;
  final double score;
  final CareerProfile profile;

  const ReadinessItem({
    super.key,
    required this.category,
    required this.score,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getReadinessColor(score);
    final formattedCategory = _formatCategoryName(category);
    
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  formattedCategory,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppBadge(
                text: profile.getReadinessLevel(category),
                backgroundColor: color.withOpacity(0.1),
                textColor: color,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: score,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${profile.getReadinessPercentage(category)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getReadinessColor(double score) {
    if (score >= 0.8) return AppColors.success;
    if (score >= 0.6) return AppColors.primary;
    if (score >= 0.4) return AppColors.warning;
    return AppColors.error;
  }

  String _formatCategoryName(String category) {
    return category
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
