import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../components/components.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/service_locator.dart';
import '../../../services/data_service.dart';
import '../viewmodel/courses_viewmodel.dart';
import '../model/course.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoursesViewModel(serviceLocator<DataService>()),
      child: const _CoursesPageContent(),
    );
  }
}

class _CoursesPageContent extends StatefulWidget {
  const _CoursesPageContent();

  @override
  State<_CoursesPageContent> createState() => _CoursesPageContentState();
}

class _CoursesPageContentState extends State<_CoursesPageContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CoursesViewModel>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Consumer<CoursesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const AppLoading(message: 'Loading courses...');
          }

          if (viewModel.error != null) {
            return AppError(
              message: viewModel.error!,
              onRetry: () => viewModel.loadCourses(),
            );
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, viewModel),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: viewModel.filteredCourses.isEmpty
                        ? _buildEmptyState(context)
                        : _buildCoursesList(context, viewModel),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CoursesViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Courses',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '${viewModel.totalCourses} courses enrolled',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        if (viewModel.totalCourses > 0) ...[
          SizedBox(height: 16.h),
          _buildStatistics(context, viewModel),
        ],
      ],
    );
  }

  Widget _buildStatistics(BuildContext context, CoursesViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Progress',
            '${(viewModel.overallProgress * 100).toInt()}%',
            Icons.trending_up,
            const Color(0xFF2196F3),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Avg Grade',
            viewModel.averageGrade.toStringAsFixed(1),
            Icons.grade,
            const Color(0xFF4CAF50),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Completed',
            '${viewModel.completedCourses}',
            Icons.check_circle,
            const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 4.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, CoursesViewModel viewModel) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.8,
        mainAxisSpacing: 16.h,
      ),
      itemCount: viewModel.filteredCourses.length,
      itemBuilder: (context, index) {
        return _buildCourseCard(context, viewModel.filteredCourses[index]);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Courses Found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your enrolled courses will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to course detail page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Course detail for ${course.name}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Course Color Indicator
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: course.color,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              
              SizedBox(width: 16.w),
              
              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course.code,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: course.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (course.grade != null)
                          _buildGradeBadge(context, course.grade!),
                      ],
                    ),
                    Text(
                      course.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Prof. ${course.professor}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Progress',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  Text(
                                    course.progressPercentage,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: course.color,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              LinearProgressIndicator(
                                value: course.progress,
                                backgroundColor: course.color.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(course.color),
                                minHeight: 6.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeBadge(BuildContext context, double grade) {
    Color badgeColor;
    String gradeText;

    if (grade >= 90) {
      badgeColor = const Color(0xFF4CAF50);
      gradeText = 'A';
    } else if (grade >= 80) {
      badgeColor = const Color(0xFF2196F3);
      gradeText = 'B';
    } else if (grade >= 70) {
      badgeColor = const Color(0xFFFF9800);
      gradeText = 'C';
    } else if (grade >= 60) {
      badgeColor = const Color(0xFFE91E63);
      gradeText = 'D';
    } else {
      badgeColor = const Color(0xFFF44336);
      gradeText = 'F';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        gradeText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
