import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../model/career_opportunity.dart';
import '../../viewmodel/career_viewmodel.dart';

/// Modal bottom sheet for showing opportunity details
class OpportunityDetailsModal extends StatelessWidget {
  final CareerOpportunity opportunity;

  const OpportunityDetailsModal({
    super.key,
    required this.opportunity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusXL),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Text(
              opportunity.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              opportunity.company,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection('Description', opportunity.description),
                    _buildDetailSection('Location', opportunity.location),
                    if (opportunity.salaryRange != null)
                      _buildDetailSection('Salary Range', opportunity.salaryRange!),
                    _buildDetailSection('Type', _formatApplicationStatus(opportunity.type)),
                    _buildDetailSection('Level', _formatApplicationStatus(opportunity.level)),
                    _buildDetailSection('Match', '${(opportunity.matchPercentage * 100).round()}%'),
                    _buildSkillsSection('Required Skills', opportunity.requiredSkills),
                    if (opportunity.preferredSkills.isNotEmpty)
                      _buildSkillsSection('Preferred Skills', opportunity.preferredSkills),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: opportunity.applicationStatus == null ? 'Apply Now' : 'Applied',
                onPressed: opportunity.applicationStatus == null
                    ? () => _applyToOpportunity(context, opportunity.id)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            content,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(String title, List<String> skills) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: skills.map((skill) => AppBadge(
              text: skill,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              textColor: AppColors.primary,
            )).toList(),
          ),
        ],
      ),
    );
  }

  String _formatApplicationStatus(String status) {
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  void _applyToOpportunity(BuildContext context, String opportunityId) {
    context.read<CareerViewModel>().applyToOpportunity(opportunityId);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application submitted successfully!')),
    );
  }
}
