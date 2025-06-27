import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/providers/dashboard_provider.dart';
import '../../core/state/providers/student_provider.dart';
import '../../core/state/providers/courses_provider.dart';
import '../../core/state/providers/assessments_provider.dart';
import '../../core/ui/error_boundary.dart';
import '../../components/states/app_states.dart';

/// Enhanced dashboard screen with comprehensive state management
class EnhancedDashboardScreen extends ConsumerWidget {
  const EnhancedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ErrorBoundary(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Dashboard'),
          actions: [
            IconButton(
              onPressed: () => _refreshAll(ref),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshAll(ref),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _QuickStatsSection(),
                SizedBox(height: 16),
                _AlertsSection(),
                SizedBox(height: 16),
                _CoursesSection(),
                SizedBox(height: 16),
                _AssessmentsSection(),
                SizedBox(height: 16),
                _RecentActivitySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> _refreshAll(WidgetRef ref) async {
    await Future.wait<void>([
      ref.read(studentDataProvider.notifier).refresh(),
      ref.read(coursesProvider.notifier).refresh(),
      ref.read(assessmentsProvider.notifier).refresh(),
    ]);
  }
}

/// Quick stats cards section
class _QuickStatsSection extends ConsumerWidget {
  const _QuickStatsSection();

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
        _StatCard(
          title: 'GPA',
          value: (quickStats['gpa'] as double).toStringAsFixed(2),
          icon: Icons.school,
          color: _getGpaColor(quickStats['gpa'] as double),
        ),
        _StatCard(
          title: 'Credits',
          value: '${quickStats['completed_credits']}/${quickStats['enrolled_credits']}',
          icon: Icons.timeline,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Progress',
          value: '${(quickStats['completion_percentage'] as double).toInt()}%',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Status',
          value: quickStats['academic_status'] as String,
          icon: Icons.flag,
          color: quickStats['is_on_track'] as bool ? Colors.green : Colors.orange,
        ),
      ],
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.5) return Colors.green;
    if (gpa >= 3.0) return Colors.blue;
    if (gpa >= 2.0) return Colors.orange;
    return Colors.red;
  }
}

/// Individual stat card
class _StatCard extends StatelessWidget {
  const _StatCard({
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

/// Alerts section
class _AlertsSection extends ConsumerWidget {
  const _AlertsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider);

    if (alerts.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alerts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...alerts.map((alert) => _AlertItem(alert: alert)),
          ],
        ),
      ),
    );
  }
}

/// Individual alert item
class _AlertItem extends StatelessWidget {
  const _AlertItem({required this.alert});

  final Map<String, dynamic> alert;

  @override
  Widget build(BuildContext context) {
    final type = alert['type'] as String;
    final message = alert['message'] as String;

    Color color;
    IconData icon;

    switch (type) {
      case 'error':
        color = Colors.red;
        icon = Icons.error;
        break;
      case 'warning':
        color = Colors.orange;
        icon = Icons.warning;
        break;
      default:
        color = Colors.blue;
        icon = Icons.info;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Courses section
class _CoursesSection extends ConsumerWidget {
  const _CoursesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

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
                  'Current Courses',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to courses page
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            coursesAsync.when(
              data: (courses) {
                final currentCourses = courses.where((c) => c.status == 'enrolled').take(3);
                if (currentCourses.isEmpty) {
                  return const Text('No current courses');
                }
                return Column(
                  children: currentCourses.map((course) => _CourseItem(course: course)).toList(),
                );
              },
              loading: () => const AppLoading(),
              error: (error, stackTrace) => AsyncErrorWidget(
                asyncValue: coursesAsync,
                onRetry: () => ref.read(coursesProvider.notifier).refresh(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual course item
class _CourseItem extends StatelessWidget {
  const _CourseItem({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(course.name),
      subtitle: Text('${course.code} • ${course.credits} credits'),
      trailing: course.grade != null
          ? Chip(
              label: Text(course.grade!.toStringAsFixed(1)),
              backgroundColor: _getGradeColor(course.grade!),
            )
          : const Text('In Progress'),
    );
  }

  Color _getGradeColor(double grade) {
    if (grade >= 3.5) return Colors.green.shade100;
    if (grade >= 3.0) return Colors.blue.shade100;
    if (grade >= 2.0) return Colors.orange.shade100;
    return Colors.red.shade100;
  }
}

/// Assessments section
class _AssessmentsSection extends ConsumerWidget {
  const _AssessmentsSection();

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
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              ...overdueAssessments.take(2).map((assessment) => _AssessmentItem(
                assessment: assessment,
                isOverdue: true,
              )),
            ],
            if (pendingAssessments.isNotEmpty) ...[
              Text(
                'Pending (${pendingAssessments.length})',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ...pendingAssessments.take(3).map((assessment) => _AssessmentItem(
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

/// Individual assessment item
class _AssessmentItem extends StatelessWidget {
  const _AssessmentItem({
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
          color: isOverdue ? Colors.red : null,
          fontWeight: isOverdue ? FontWeight.bold : null,
        ),
      ),
      subtitle: Text(
        'Due: ${_formatDate(assessment.dueDate)}',
        style: TextStyle(color: isOverdue ? Colors.red : null),
      ),
      trailing: Chip(
        label: Text(assessment.type.toUpperCase()),
        backgroundColor: isOverdue ? Colors.red.shade100 : Colors.blue.shade100,
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

/// Recent activity section
class _RecentActivitySection extends ConsumerWidget {
  const _RecentActivitySection();

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
              ...recentActivity.take(5).map((activity) => _ActivityItem(activity: activity)),
          ],
        ),
      ),
    );
  }
}

/// Individual activity item
class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.activity});

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
