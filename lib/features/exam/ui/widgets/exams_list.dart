import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/components.dart';
import '../../viewmodel/exam_viewmodel.dart';
import '../../model/exam.dart';
import 'exam_card.dart';
import 'exam_details_modal.dart';

/// List of all exams
class ExamsList extends StatelessWidget {
  const ExamsList({super.key});

  @override
  Widget build(BuildContext context) {
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
            final exam = viewModel.exams[index];
            return ExamCard(
              exam: exam,
              onTap: () => _showExamDetails(context, exam),
            );
          },
        );
      },
    );
  }

  void _showExamDetails(BuildContext context, Exam exam) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExamDetailsModal(exam: exam),
    );
  }
}
