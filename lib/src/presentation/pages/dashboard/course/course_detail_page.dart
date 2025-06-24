import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/app_providers.dart';
import '../../../widgets/course_detail_widgets.dart';
import '../../../widgets/exam_detail_widgets.dart';
import '../../../widgets/syllabus_detail_widgets.dart';

class CourseDetailPage extends ConsumerStatefulWidget {
  final String courseId;

  const CourseDetailPage({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends ConsumerState<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Course Details'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Syllabus', icon: Icon(Icons.article_outlined)),
            Tab(text: 'Exams', icon: Icon(Icons.quiz_outlined)),
          ],
        ),
      ),
      body: coursesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.w,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: 16.h),
              Text(
                'Error loading course details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        data: (courses) {
          final course = courses.firstWhere(
            (c) => c.id == widget.courseId,
            orElse: () => courses.first, // Fallback to first course if ID not found
          );

          return Column(
            children: [
              // Course Header Card
              CourseHeaderCard(course: course),
              SizedBox(height: 16.h),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SyllabusTab(courseId: widget.courseId),
                    ExamTab(courseId: widget.courseId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
