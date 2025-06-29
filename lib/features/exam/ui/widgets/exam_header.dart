import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../components/components.dart';
import '../../viewmodel/exam_viewmodel.dart';

/// Header section with title and refresh button
class ExamHeader extends StatelessWidget {
  const ExamHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
}
