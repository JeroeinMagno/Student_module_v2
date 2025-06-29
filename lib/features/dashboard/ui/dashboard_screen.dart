import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/providers/student_provider.dart';
import '../../../core/state/providers/courses_provider.dart';
import '../../../core/state/providers/assessments_provider.dart';
import '../../../core/ui/error_boundary.dart';
import 'widgets/widgets.dart';

/// Clean, modular dashboard screen with comprehensive state management
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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
                QuickStatsSection(),
                SizedBox(height: 16),
                AlertsSection(),
                SizedBox(height: 16),
                CoursesSection(),
                SizedBox(height: 16),
                AssessmentsSection(),
                SizedBox(height: 16),
                RecentActivitySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Refresh all dashboard data
  static Future<void> _refreshAll(WidgetRef ref) async {
    await Future.wait<void>([
      ref.read(studentDataProvider.notifier).refresh(),
      ref.read(coursesProvider.notifier).refresh(),
      ref.read(assessmentsProvider.notifier).refresh(),
    ]);
  }
}
