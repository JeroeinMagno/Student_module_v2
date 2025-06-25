import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/dashboard/course/course_page.dart';
import '../pages/dashboard/exam/exam_page.dart';
import '../pages/dashboard/career/career_page.dart';
import '../pages/dashboard/bot/bot_page.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/collapsible_sidebar.dart';
import '../widgets/student_performance_content.dart';

class MainLayout extends StatefulWidget {
  final String currentRoute;

  const MainLayout({
    super.key,
    required this.currentRoute,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isExpanded = true;
  String _selectedRoute = 'performance';

  @override
  void initState() {
    super.initState();
    _initializeRoute();
  }

  void _initializeRoute() {
    setState(() {
      switch (widget.currentRoute) {
        case '/performance':
          _selectedRoute = 'performance';
          break;
        case '/skill-profile':
          _selectedRoute = 'career';
          break;
        case '/chatbot':
          _selectedRoute = 'chatbot';
          break;
      }
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String _getPageTitle(String route) {
    switch (route) {
      case '/dashboard':
      case '/':
      case '/performance':
        return 'Student Performance';
      case '/courses':
        return 'Courses';
      case '/exam-overview':
        return 'Exam Overview';
      case '/skill-profile':
        return 'Skill Profile';
      case '/track-readiness':
        return 'Track Readiness';
      case '/chatbot':
        return 'Chatbot';
      default:
        return 'Student Performance';
    }
  }

  Widget _getPageContent(String route) {
    switch (route) {
      case '/dashboard':
      case '/':
      case '/performance':
        return const StudentPerformanceContent();
      case '/courses':
        return const CoursePage();
      case '/exam-overview':
        return const ExamPage();
      case '/skill-profile':
      case '/track-readiness':
        return const CareerPage();
      case '/chatbot':
        return const BotPage();
      default:
        return const StudentPerformanceContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(left: 60.w),
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize: Size.fromHeight(56.h),
                      child: CustomAppBar(
                        title: _getPageTitle(widget.currentRoute),
                        showMenuButton: false,
                      ),
                    ),
                    Expanded(
                      child: _getPageContent(widget.currentRoute),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Material(
                elevation: 4,
                child: CollapsibleSidebar(
                  isExpanded: _isExpanded,
                  onToggle: _toggleSidebar,
                  selectedRoute: _selectedRoute,
                  onRouteSelected: (route) {
                    setState(() {
                      _selectedRoute = route;
                    });
                    switch (route) {
                      case 'career':
                        context.go('/skill-profile');
                        break;
                      case 'chatbot':
                        context.go('/chatbot');
                        break;
                      case 'performance':
                        context.go('/performance');
                        break;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentPerformanceScreen extends StatelessWidget {
  const StudentPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column( // Wrap the children in a Column widget
            children: [
              // Curriculum Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Curriculum',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        '27/47',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Course Progress Overview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Progress Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              'Course ${index + 1}',
                              style: TextStyle(color: textColor),
                            ),
                            subtitle: Text(
                              'Progress details',
                              style: TextStyle(color: subtitleColor),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Assessment Tracker
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assessment Tracker',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'Total Assessments',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // GWA Trend
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GWA Trend',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'Trend Analysis',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
