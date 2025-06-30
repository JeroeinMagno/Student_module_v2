import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../../core/state/providers/courses_provider.dart';
import '../../../../components/states/app_states.dart';

/// Courses section showing current enrolled courses
class CoursesSection extends ConsumerWidget {
  const CoursesSection({super.key});

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
                  children: currentCourses.map((course) => CourseItem(course: course)).toList(),
                );
              },
              loading: () => const AppLoading(),
              error: (error, stackTrace) => AppError(
                message: 'Failed to load courses',
                onRetry: () => ref.read(coursesProvider.notifier).refresh(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual course item widget
class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(course.name),
      subtitle: Text(course.code),
      trailing: course.grade != null
          ? Chip(
              label: Text(course.grade!.toStringAsFixed(1)),
              backgroundColor: _getGradeColor(course.grade!),
            )
          : const Text('In Progress'),
    );
  }

  Color _getGradeColor(double grade) {
    if (grade >= 3.5) return AppColors.success.withOpacity(0.1);
    if (grade >= 3.0) return AppColors.info.withOpacity(0.1);
    if (grade >= 2.0) return AppColors.warning.withOpacity(0.1);
    return AppColors.destructive.withOpacity(0.1);
  }
}
