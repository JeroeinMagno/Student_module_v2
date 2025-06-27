import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';

/// Opportunities overview statistics card
class OpportunitiesOverviewCard extends StatelessWidget {
  final Map<String, dynamic> careerStats;

  const OpportunitiesOverviewCard({
    super.key,
    required this.careerStats,
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
              'Opportunities Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Total',
                    careerStats['totalOpportunities']?.toString() ?? '0',
                    AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Applied',
                    careerStats['appliedOpportunities']?.toString() ?? '0',
                    AppColors.warning,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'High Match',
                    careerStats['highMatchOpportunities']?.toString() ?? '0',
                    AppColors.success,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Avg Match',
                    '${((careerStats['averageMatchPercentage'] ?? 0) * 100).round()}%',
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
