import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../components/components.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/service_locator.dart';
import '../../../services/data_service.dart';
import '../viewmodel/courses_viewmodel.dart';
import 'widgets/widgets.dart';

/// Main Courses Page for displaying enrolled courses
/// This is the navigation entry point for the courses feature
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
                  const CoursesHeader(),
                  SizedBox(height: 20.h),
                  const Expanded(
                    child: CoursesList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
