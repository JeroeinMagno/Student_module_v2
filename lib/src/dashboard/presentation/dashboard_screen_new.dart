import 'package:flutter/material.dart';
import 'package:mobile_app_student_module_v2/src/core/providers/theme_provider.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/presentation/widgets/course_card.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/presentation/widgets/exam_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getStudent('1'); // Assuming student ID is '1' for now
      provider.getCourses();
      provider.getExams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${provider.student?.name ?? 'Student'}!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Courses',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (provider.courses.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      final course = provider.courses[index];
                      return CourseCard(
                        course: course,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on ${course.name}'),
                            ),
                          );
                        },
                      );
                    },
                  )
                else
                  const Text('No courses found.'),
                const SizedBox(height: 24),
                Text(
                  'Upcoming Exams',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (provider.exams.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: provider.exams.length,
                    itemBuilder: (context, index) {
                      final exam = provider.exams[index];
                      return ExamCard(
                        exam: exam,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on ${exam.name}'),
                            ),
                          );
                        },
                      );
                    },
                  )
                else
                  const Text('No exams found.'),
              ],
            ),
          );
        },
      ),
    );
  }
}
