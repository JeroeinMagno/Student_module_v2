import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../../core/state/providers/dashboard_provider.dart';
import '../../../../components/states/app_states.dart';

/// Quick stats cards section showing GPA, Credits, Progress, and Status
class QuickStatsSection extends ConsumerWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quickStats = ref.watch(quickStatsProvider);
    
    if (quickStats.isEmpty) {
      return const AppLoading(message: 'Loading dashboard...');
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          title: 'GPA',
          value: (quickStats['gpa'] as double).toStringAsFixed(2),
          icon: Icons.school,
          color: _getGpaColor(quickStats['gpa'] as double),
        ),
        StatCard(
          title: 'Credits',
          value: '${quickStats['completed_credits']}/${quickStats['enrolled_credits']}',
          icon: Icons.timeline,
          color: AppColors.info,
        ),
        StatCard(
          title: 'Progress',
          value: '${(quickStats['completion_percentage'] as double).toInt()}%',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        StatCard(
          title: 'Status',
          value: quickStats['academic_status'] as String,
          icon: Icons.flag,
          color: quickStats['is_on_track'] as bool ? AppColors.success : AppColors.warning,
        ),
      ],
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.5) return AppColors.success;
    if (gpa >= 3.0) return AppColors.info;
    if (gpa >= 2.0) return AppColors.warning;
    return AppColors.destructive;
  }
}

/// Individual stat card widget
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
