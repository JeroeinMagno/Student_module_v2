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
import '../../data/services/centralized_data_service.dart';
import '../../data/converters/assessment_converter.dart';

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
        }        return LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message
                  _buildWelcomeSection(context, provider.student),
                  
                  SizedBox(height: 24.h),
                  
                  // Charts section (responsive layout)
                  _buildChartsSection(context, provider, isLandscape, screenWidth),
                  
                  SizedBox(height: 24.h),
                  
                  // Recent assessments and insights
                  _buildBottomSection(context, provider),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget _buildWelcomeSection(BuildContext context, domain.Student? student) {
    final theme = Theme.of(context);
    
    return AppCard(
      backgroundColor: AppTheme.primaryGreen,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back${student != null ? ', ${student.name.split(' ').first}!' : '!'}',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Here\'s your academic overview for this semester',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildChartsSection(BuildContext context, DashboardProvider provider, bool isLandscape, double screenWidth) {
    // For small screens or portrait mode, stack charts vertically
    if (screenWidth < 600.w || !isLandscape) {
      return Column(
        children: [
          // Quick stats row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  child: Center(
                    child: Text(
                      'Quick Stats',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  child: Center(
                    child: Text(
                      'Grade Overview',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
            // Horizontal bar chart - full width
          FutureBuilder<Map<String, dynamic>>(
            future: CentralizedDataService().getAssessmentOverview(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final overviewData = snapshot.data;
              final monthlyData = overviewData?['monthlyData'] as List<dynamic>? ?? [];
              
              final chartData = monthlyData.map((item) => 
                ChartDataModel(
                  label: item['month'] ?? '', 
                  value: (item['score'] as num?)?.toDouble() ?? 0.0
                )
              ).toList();

              return HorizontalBarChart(
                title: 'Assessment Overview',
                subtitle: 'Recent Performance - 2025',
                data: chartData,
                height: 200.h,
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Performance trend - full width
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
            child: Center(
              child: Text(
                'Performance Trend',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Grade distribution - full width
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
            child: Center(
              child: Text(
                'Grade Distribution',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ],
      );
    }
    
    // For larger screens and landscape mode, use grid layout
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
                    child: Center(
                      child: Text(
                        'Quick Stats',
                        style: TextStyle(fontSize: 14.sp),
                      ),
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
                    child: Center(
                      child: Text(
                        'Grade Overview',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 16.w),
              // Right side - horizontal bar chart
            Expanded(
              flex: 2,
              child: FutureBuilder<Map<String, dynamic>>(
                future: CentralizedDataService().getAssessmentOverview(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 256.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  final overviewData = snapshot.data;
                  final monthlyData = overviewData?['monthlyData'] as List<dynamic>? ?? [];
                  
                  final chartData = monthlyData.map((item) => 
                    ChartDataModel(
                      label: item['month'] ?? '', 
                      value: (item['score'] as num?)?.toDouble() ?? 0.0
                    )
                  ).toList();

                  return HorizontalBarChart(
                    title: 'Assessment Overview',
                    subtitle: 'Recent Performance - 2025',
                    data: chartData,
                    height: 256.h,
                  );
                },
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
                child: Center(
                  child: Text(
                    'Performance Trend',
                    style: TextStyle(fontSize: 14.sp),
                  ),
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
                child: Center(
                  child: Text(
                    'Grade Distribution',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildBottomSection(BuildContext context, DashboardProvider provider) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: CentralizedDataService().getRecentAssessments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppCard(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return AppCard(
            child: Center(
              child: Text('Error loading assessments: ${snapshot.error}'),
            ),
          );
        }

        final assessmentData = snapshot.data ?? [];
        final assessments = AssessmentConverter.toUIAssessmentList(assessmentData);

        return ui.AssessmentTable(
          assessments: assessments,
          title: 'Recent Assessments',
        );
      },    );
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
        }        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              SizedBox(height: 16.h),
              
              // Course cards - responsive layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final isLandscape = constraints.maxWidth > constraints.maxHeight;
                  final screenWidth = constraints.maxWidth;
                  
                  int crossAxisCount = 1;
                  double childAspectRatio = 2.5;
                  
                  if (screenWidth > 600.w) {
                    crossAxisCount = 2;
                    childAspectRatio = isLandscape ? 3.0 : 2.8;
                  }
                  
                  if (screenWidth > 900.w) {
                    crossAxisCount = 3;
                    childAspectRatio = 2.5;
                  }
                  
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      final course = provider.courses[index];
                      return ui.CourseCard(
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
                      );
                    },
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
        }        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exams & Assessments',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 16.h),
              
              // Exam cards - responsive layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.exams.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final exam = provider.exams[index];
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth < 600.w ? double.infinity : 600.w,
                        ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400.w;
        
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.work_outline,
                size: isSmallScreen ? 48.w : 64.w,
                color: AppTheme.textSecondary,
              ),
              SizedBox(height: 16.h),
              Text(
                'Career Section',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 20.sp : 24.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Career guidance and opportunities coming soon!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: isSmallScreen ? 14.sp : 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400.w;
        
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: isSmallScreen ? 48.w : 64.w,
                color: AppTheme.textSecondary,
              ),
              SizedBox(height: 16.h),
              Text(
                'AI Chatbot',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 20.sp : 24.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'AI-powered academic assistant coming soon!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: isSmallScreen ? 14.sp : 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
