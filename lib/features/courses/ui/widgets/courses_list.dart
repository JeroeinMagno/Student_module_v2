import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/courses_viewmodel.dart';
import 'course_card.dart';
import 'courses_empty_state.dart';

/// List of all courses
class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.filteredCourses.isEmpty) {
          return const CoursesEmptyState();
        }

        return ListView.separated(
          itemCount: viewModel.filteredCourses.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final course = viewModel.filteredCourses[index];
            return CourseCard(course: course);
          },
        );
      },
    );
  }
}
