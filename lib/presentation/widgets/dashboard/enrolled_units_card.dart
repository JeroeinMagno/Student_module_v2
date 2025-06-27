import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Card widget displaying the student's enrolled units for the current semester
class EnrolledUnitsCard extends StatelessWidget {
  final int units;
  final String description;

  const EnrolledUnitsCard({
    super.key,
    required this.units,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayDescription = description.isNotEmpty 
        ? description 
        : 'You are currently taking $units units this semester.';

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enrolled Units',
              style: AppTextStyles.heading6.copyWith(
                color: isDarkMode ? AppColors.primaryDark : AppColors.primary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Row(
              children: [
                Text(
                  '$units',
                  style: AppTextStyles.heading1.copyWith(
                    color: isDarkMode ? AppColors.foregroundDark : AppColors.foreground,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    displayDescription,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDarkMode 
                          ? AppColors.mutedForegroundDark 
                          : AppColors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
