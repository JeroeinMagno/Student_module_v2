import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../viewmodel/exam_viewmodel.dart';

/// Overview section showing exam statistics
class ExamOverviewCard extends StatelessWidget {
  const ExamOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const AppLoading();
        }

        final overview = viewModel.examOverview;
        return AppCard(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingMD),
                Row(
                  children: [
                    Expanded(
                      child: _buildOverviewItem(
                        context,
                        'Total',
                        overview['total'].toString(),
                        AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        context,
                        'Completed',
                        overview['completed'].toString(),
                        AppColors.success,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        context,
                        'Upcoming',
                        overview['upcoming'].toString(),
                        AppColors.warning,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        context,
                        'Missing',
                        overview['missing'].toString(),
                        AppColors.error,
                      ),
                    ),
                  ],
                ),
                if (overview['averageScore'] > 0) ...[
                  SizedBox(height: AppDimensions.paddingSM),
                  Text(
                    'Average Score: ${overview['averageScore'].toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverviewItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
