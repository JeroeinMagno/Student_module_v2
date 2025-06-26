import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../viewmodel/exam_viewmodel.dart';
import '../model/exam.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExamViewModel(),
      child: const _ExamPageContent(),
    );
  }
}

class _ExamPageContent extends StatefulWidget {
  const _ExamPageContent();

  @override
  State<_ExamPageContent> createState() => _ExamPageContentState();
}

class _ExamPageContentState extends State<_ExamPageContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExamViewModel>().loadExams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamViewModel>(
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: AppDimensions.paddingLG),
                _buildExamOverview(),
                SizedBox(height: AppDimensions.paddingLG),
                Expanded(
                  child: _buildExamsList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.examOverview,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Consumer<ExamViewModel>(
          builder: (context, viewModel, child) {
            return AppIconButton(
              icon: const Icon(Icons.refresh),
              onPressed: viewModel.isLoading ? null : () => viewModel.refreshExams(),
              size: AppDimensions.iconLG,
            );
          },
        ),
      ],
    );
  }

  Widget _buildExamOverview() {
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
                        'Total',
                        overview['total'].toString(),
                        AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        'Completed',
                        overview['completed'].toString(),
                        AppColors.success,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        'Upcoming',
                        overview['upcoming'].toString(),
                        AppColors.warning,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
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

  Widget _buildOverviewItem(String label, String value, Color color) {
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

  Widget _buildExamsList() {
    return Consumer<ExamViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: AppLoading());
        }

        if (viewModel.error != null) {
          return AppError(
            message: viewModel.error!,
            onRetry: () => viewModel.refreshExams(),
          );
        }

        if (viewModel.exams.isEmpty) {
          return const AppEmpty(
            message: 'No exams found',
          );
        }

        return ListView.builder(
          itemCount: viewModel.exams.length,
          itemBuilder: (context, index) {
            return _buildExamCard(context, viewModel.exams[index]);
          },
        );
      },
    );
  }

  Widget _buildExamCard(BuildContext context, Exam exam) {
    final statusColor = _getStatusColor(exam.status);
    
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: InkWell(
        onTap: () => _showExamDetails(context, exam),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
                ),
              ),
              SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${exam.courseCode} - ${exam.courseName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Date: ${exam.formattedDate}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (exam.score != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Score: ${exam.score}/${exam.maxScore} (${exam.percentage?.toStringAsFixed(1)}%)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AppBadge(
                text: _formatStatus(exam.status),
                backgroundColor: statusColor.withOpacity(0.1),
                textColor: statusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'upcoming':
        return AppColors.primary;
      case 'missing':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  void _showExamDetails(BuildContext context, Exam exam) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildExamDetailsModal(context, exam),
    );
  }

  Widget _buildExamDetailsModal(BuildContext context, Exam exam) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
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
              exam.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            _buildDetailRow('Course', '${exam.courseCode} - ${exam.courseName}'),
            _buildDetailRow('Type', exam.type),
            _buildDetailRow('Date', exam.formattedDate),
            _buildDetailRow('Status', _formatStatus(exam.status)),
            if (exam.score != null) ...[
              _buildDetailRow('Score', '${exam.score}/${exam.maxScore}'),
              _buildDetailRow('Percentage', '${exam.percentage?.toStringAsFixed(1)}%'),
            ],
            if (exam.grade != null)
              _buildDetailRow('Grade', exam.grade.toString()),
            _buildDetailRow('Weight', '${exam.weight}%'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
