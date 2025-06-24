import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/app_sidebar.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_bottom_nav_bar.dart';

class CoursePage extends ConsumerStatefulWidget {
  const CoursePage({super.key});

  @override
  ConsumerState<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends ConsumerState<CoursePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const AppSidebar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Courses',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildCourseCard(context, index);
                  },
                ),              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildCourseCard(BuildContext context, int index) {
    final courses = [
      {'title': 'Mathematics', 'code': 'MATH101', 'instructor': 'Dr. Smith'},
      {'title': 'Physics', 'code': 'PHYS101', 'instructor': 'Dr. Johnson'},
      {'title': 'Chemistry', 'code': 'CHEM101', 'instructor': 'Dr. Brown'},
      {'title': 'English', 'code': 'ENG101', 'instructor': 'Prof. Davis'},
      {'title': 'History', 'code': 'HIST101', 'instructor': 'Dr. Wilson'},
      {'title': 'Computer Science', 'code': 'CS101', 'instructor': 'Dr. Garcia'},
    ];

    final course = courses[index % courses.length];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to course details
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.book_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                course['title']!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                course['code']!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                course['instructor']!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends ConsumerStatefulWidget {
  final String courseId;

  const CourseDetailPage({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends ConsumerState<CourseDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const AppSidebar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Course Details',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Course ID: ${widget.courseId}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Add more course details here
            ],
          ),
        ),
      ),
    );
  }
}
