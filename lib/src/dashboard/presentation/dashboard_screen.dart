import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../domain/student.dart' as domain;
import 'provider/dashboard_provider.dart';
import '../../presentation/widgets/navigation/navigation_widgets.dart';
import '../../presentation/widgets/charts/chart_widgets.dart';
import '../../presentation/widgets/tables/table_widgets.dart' as ui;
import '../../presentation/widgets/common/app_components.dart';
import '../../core/theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getStudent('1');
      provider.getCourses();
      provider.getExams();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: DashboardAppBar(
            title: _getPageTitle(_currentNavIndex),
            onNotificationTap: () {
              // TODO: Show notifications
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked')),
              );
            },            onThemeToggle: () {
              themeProvider.toggleTheme(
                themeProvider.themeMode != ThemeMode.dark
              );
            },
            isDarkMode: themeProvider.themeMode == ThemeMode.dark,
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentNavIndex = index;
              });
            },
            children: const [
              DashboardOverviewPage(),
              CoursesPage(),
              ExamsPage(),
              CareerPage(),
              ChatbotPage(),
            ],
          ),
          bottomNavigationBar: AppBottomNavigation(
            currentIndex: _currentNavIndex,
            onTap: (index) {
              setState(() {
                _currentNavIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            items: [
              BottomNavItem(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                route: '/dashboard',
              ),
              BottomNavItem(
                icon: Icons.book_outlined,
                label: 'Courses',
                route: '/courses',
              ),
              BottomNavItem(
                icon: Icons.assignment_outlined,
                label: 'Exams',
                route: '/exams',
              ),
              BottomNavItem(
                icon: Icons.work_outline,
                label: 'Career',
                route: '/career',
              ),
              BottomNavItem(
                icon: Icons.chat_bubble_outline,
                label: 'Chatbot',
                route: '/chatbot',
              ),
            ],
          ),
        );
      },
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Courses';
      case 2:
        return 'Exams';
      case 3:
        return 'Career';
      case 4:
        return 'Chatbot';
      default:
        return 'Dashboard';
    }
  }
}

class DashboardOverviewPage extends StatelessWidget {
  const DashboardOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              _buildWelcomeSection(context, provider.student),
              
              SizedBox(height: 24.h),
              
              // Charts section (mimicking web layout)
              _buildChartsSection(context, provider),
              
              SizedBox(height: 24.h),
              
              // Recent assessments and insights
              _buildBottomSection(context, provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeSection(BuildContext context, domain.Student? student) {
    final theme = Theme.of(context);
    
    return AppCard(
      backgroundColor: AppTheme.primaryGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back${student != null ? ', ${student.name.split(' ').first}!' : '!'}',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Here\'s your academic overview for this semester',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(BuildContext context, DashboardProvider provider) {
    return Column(
      children: [
        // Top row - mimicking web's grid layout
        Row(
          children: [
            // Left column - two small charts
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Placeholder for small chart 1
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    ),
                    child: const Center(
                      child: Text('Quick Stats'),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Placeholder for small chart 2
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    ),
                    child: const Center(
                      child: Text('Grade Overview'),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Right side - horizontal bar chart
            Expanded(
              flex: 2,
              child: HorizontalBarChart(
                title: 'Assessment Overview',
                subtitle: 'January - June 2024',
                data: _getSampleBarData(),
                height: 256.h,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 16.h),
        
        // Bottom row - line chart and radial chart
        Row(
          children: [
            // Line chart
            Expanded(
              flex: 3,
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: const Center(
                  child: Text('Performance Trend'),
                ),
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Radial chart
            Expanded(
              flex: 2,
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: const Center(
                  child: Text('Grade Distribution'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context, DashboardProvider provider) {
    // Create sample assessment data
    final assessments = _getSampleAssessments();
      return ui.AssessmentTable(
      assessments: assessments,
      title: 'Recent Assessments',
    );
  }  List<ChartDataModel> _getSampleBarData() {
    return [
      ChartDataModel(label: 'January', value: 86),
      ChartDataModel(label: 'February', value: 92),
      ChartDataModel(label: 'March', value: 78),
      ChartDataModel(label: 'April', value: 88),
      ChartDataModel(label: 'May', value: 95),
      ChartDataModel(label: 'June', value: 89),
    ];
  }
  List<ui.Assessment> _getSampleAssessments() {
    return [
      ui.Assessment(
        courseCode: 'CS101',
        type: 'Finals',
        date: DateTime(2025, 6, 28),
        status: ui.AssessmentStatus.upcoming,
      ),
      ui.Assessment(
        courseCode: 'MATH123',
        type: 'Midterms',
        date: DateTime(2025, 6, 15),
        status: ui.AssessmentStatus.completed,
        score: 84,
      ),
      ui.Assessment(
        courseCode: 'HIST200',
        type: 'Prelims',
        date: DateTime(2025, 6, 10),
        status: ui.AssessmentStatus.missing,
      ),
      ui.Assessment(
        courseCode: 'CS101',
        type: 'Quiz',
        date: DateTime(2025, 6, 8),
        status: ui.AssessmentStatus.completed,
        score: 92,
      ),
    ];
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Courses',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              
              // Course cards grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),                itemCount: provider.courses.length,
                itemBuilder: (context, index) {
                  final course = provider.courses[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),                    child: ui.CourseCard(
                      course: ui.Course(
                        code: course.code,
                        name: course.name,
                        credits: course.credits,
                        progress: 75, // Sample progress
                        currentGrade: 'A-', // Sample grade
                      ),
                      onTap: () {
                        // TODO: Navigate to course details
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exams & Assessments',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              
              // Exam cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.exams.length,
                itemBuilder: (context, index) {
                  final exam = provider.exams[index];                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ui.ExamScoreCard(
                      exam: ui.Exam(
                        title: exam.name,
                        courseCode: exam.courseId,
                        type: 'Exam',
                        date: exam.date,
                        score: null,
                      ),
                      onTap: () {
                        // TODO: Navigate to exam details
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 64.w,
            color: AppTheme.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'Career Section',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Career guidance and opportunities coming soon!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64.w,
            color: AppTheme.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'AI Chatbot',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'AI-powered academic assistant coming soon!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
