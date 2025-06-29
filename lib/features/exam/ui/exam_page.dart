import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../viewmodel/exam_viewmodel.dart';
import 'widgets/widgets.dart';

/// Main Exam Page for displaying exam information
/// This is the navigation entry point for the exam feature
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExamHeader(),
            SizedBox(height: AppDimensions.paddingLG),
            const ExamOverviewCard(),
            SizedBox(height: AppDimensions.paddingLG),
            const Expanded(
              child: ExamsList(),
            ),
          ],
        ),
      ),
    );
  }
}
