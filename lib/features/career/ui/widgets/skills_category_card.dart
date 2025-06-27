import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../model/skill.dart';

/// Widget for displaying skills grouped by category
class SkillsCategoryCard extends StatelessWidget {
  final String category;
  final List<Skill> skills;

  const SkillsCategoryCard({
    super.key,
    required this.category,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            ...skills.map((skill) => SkillItem(skill: skill)),
          ],
        ),
      ),
    );
  }
}

/// Individual skill item within a category
class SkillItem extends StatelessWidget {
  final Skill skill;

  const SkillItem({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getSkillColor(skill.level);
    
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
                  skill.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppBadge(
                text: skill.levelDescription,
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
                  value: skill.level,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${skill.percentageLevel}%',
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

  Color _getSkillColor(double level) {
    if (level >= 0.8) return AppColors.success;
    if (level >= 0.6) return AppColors.primary;
    if (level >= 0.4) return AppColors.warning;
    return AppColors.error;
  }
}
