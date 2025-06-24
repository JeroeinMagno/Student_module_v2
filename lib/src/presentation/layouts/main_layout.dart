import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/dashboard/course/course_page_new.dart';
import '../pages/dashboard/exam/exam_page_new.dart';
import '../pages/dashboard/career/career_page_new.dart';
import '../pages/dashboard/bot/bot_page_new.dart';
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
