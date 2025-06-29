import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../../core/state/providers/assessments_provider.dart';

/// Assessments section showing pending and overdue assessments
class AssessmentsSection extends ConsumerWidget {
  const AssessmentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAssessments = ref.watch(pendingAssessmentsProvider);
    final overdueAssessments = ref.watch(overdueAssessmentsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assessments',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to assessments page
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (overdueAssessments.isNotEmpty) ...[
              Text(
                'Overdue (${overdueAssessments.length})',
                style: TextStyle(color: AppColors.destructive, fontWeight: FontWeight.bold),
              ),
              ...overdueAssessments.take(2).map((assessment) => AssessmentItem(
                assessment: assessment,
                isOverdue: true,
              )),
            ],
            if (pendingAssessments.isNotEmpty) ...[
              Text(
                'Pending (${pendingAssessments.length})',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ...pendingAssessments.take(3).map((assessment) => AssessmentItem(
                assessment: assessment,
                isOverdue: false,
              )),
            ],
            if (pendingAssessments.isEmpty && overdueAssessments.isEmpty)
              const Text('No pending assessments'),
          ],
        ),
      ),
    );
  }
}

/// Individual assessment item widget
class AssessmentItem extends StatelessWidget {
  const AssessmentItem({
    super.key,
    required this.assessment,
    required this.isOverdue,
  });

  final Assessment assessment;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        assessment.title,
        style: TextStyle(
          color: isOverdue ? AppColors.destructive : null,
          fontWeight: isOverdue ? FontWeight.bold : null,
        ),
      ),
      subtitle: Text(
        'Due: ${_formatDate(assessment.dueDate)}',
        style: TextStyle(color: isOverdue ? AppColors.destructive : null),
      ),
      trailing: Chip(
        label: Text(assessment.type.toUpperCase()),
        backgroundColor: isOverdue ? AppColors.destructive.withOpacity(0.1) : AppColors.info.withOpacity(0.1),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    
    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else {
      return '${difference.inDays} days';
    }
  }
}
