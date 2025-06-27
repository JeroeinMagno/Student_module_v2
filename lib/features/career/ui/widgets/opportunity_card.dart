import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../model/career_opportunity.dart';

/// Individual opportunity card widget
class OpportunityCard extends StatelessWidget {
  final CareerOpportunity opportunity;
  final VoidCallback onTap;

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final matchColor = _getMatchColor(opportunity.matchPercentage);
    
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          opportunity.company,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBadge(
                    text: '${(opportunity.matchPercentage * 100).round()}%',
                    backgroundColor: matchColor.withOpacity(0.1),
                    textColor: matchColor,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingSM),
              Row(
                children: [
                  Icon(
                    opportunity.isRemote ? Icons.home : Icons.location_on,
                    size: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    opportunity.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  if (opportunity.salaryRange != null) ...[
                    Icon(
                      Icons.monetization_on,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      opportunity.salaryRange!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
              if (opportunity.applicationStatus != null) ...[
                SizedBox(height: AppDimensions.paddingSM),
                AppBadge(
                  text: _formatApplicationStatus(opportunity.applicationStatus!),
                  backgroundColor: _getApplicationStatusColor(opportunity.applicationStatus!).withOpacity(0.1),
                  textColor: _getApplicationStatusColor(opportunity.applicationStatus!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getMatchColor(double percentage) {
    if (percentage >= 0.8) return AppColors.success;
    if (percentage >= 0.6) return AppColors.primary;
    if (percentage >= 0.4) return AppColors.warning;
    return AppColors.error;
  }

  Color _getApplicationStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'applied':
        return AppColors.info;
      case 'interview':
        return AppColors.warning;
      case 'accepted':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatApplicationStatus(String status) {
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }
}
