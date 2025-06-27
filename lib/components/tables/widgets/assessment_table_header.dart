import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

/// Assessment table header widget
class AssessmentTableHeader extends StatelessWidget {
  final VoidCallback? onFilterPressed;

  const AssessmentTableHeader({
    super.key,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assessment Results',
                style: AppTextStyles.heading5.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                'Track your performance across all assessments',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: onFilterPressed,
          tooltip: 'Filter assessments',
        ),
      ],
    );
  }
}
