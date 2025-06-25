import 'package:flutter/material.dart';
import '../pages/dashboard/course/course_page.dart';
import '../pages/dashboard/exam/exam_page.dart';
import '../pages/dashboard/career/career_page.dart';
import '../pages/dashboard/bot/bot_page.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/student_performance_content.dart';
import '../widgets/blank_page.dart';

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
  String _selectedRoute = 'performance';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        case '/courses':
          _selectedRoute = 'courses';
          break;
        case '/exam-overview':
          _selectedRoute = 'exam-overview';
          break;
        case '/career':
          _selectedRoute = 'career';
          break;
        case '/skill-profile':
          _selectedRoute = 'skill-profile';
          break;
        case '/track-readiness':
          _selectedRoute = 'career-match';
          break;
        case '/chatbot':
          _selectedRoute = 'chatbot';
          break;
        default:
          _selectedRoute = 'performance';
          break;
      }
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
      case '/career':
        return 'Career';
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
      case '/career':
        return const CareerPage();
      case '/skill-profile':
        return const BlankPage(title: 'Skill Profile');
      case '/track-readiness':
        return const BlankPage(title: 'Career Match');
      case '/chatbot':
        return const BotPage();
      default:
        return const StudentPerformanceContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: _getPageTitle(widget.currentRoute),
        showMenuButton: true,
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: AppDrawer(
        currentRoute: widget.currentRoute,
        onRouteSelected: (route) {
          setState(() {
            _selectedRoute = route;
          });
        },
      ),
      body: SafeArea(
        child: _getPageContent(widget.currentRoute),
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
