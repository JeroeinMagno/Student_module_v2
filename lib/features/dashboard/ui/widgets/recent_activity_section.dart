import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/providers/dashboard_provider.dart';

/// Recent activity section showing latest student activities
class RecentActivitySection extends ConsumerWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentActivity = ref.watch(recentActivityProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (recentActivity.isEmpty)
              const Text('No recent activity')
            else
              ...recentActivity.take(5).map((activity) => ActivityItem(activity: activity)),
          ],
        ),
      ),
    );
  }
}

/// Individual activity item widget
class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key, required this.activity});

  final Map<String, dynamic> activity;

  @override
  Widget build(BuildContext context) {
    final type = activity['type'] as String;
    final title = activity['title'] as String;
    final date = activity['date'] as DateTime;

    IconData icon;
    switch (type) {
      case 'enrollment':
        icon = Icons.school;
        break;
      case 'completion':
        icon = Icons.check_circle;
        break;
      case 'submission':
        icon = Icons.assignment_turned_in;
        break;
      case 'graded':
        icon = Icons.grade;
        break;
      default:
        icon = Icons.event;
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        child: Icon(icon, size: 16),
      ),
      title: Text(title),
      subtitle: Text(_formatActivityDate(date)),
      dense: true,
    );
  }

  String _formatActivityDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
