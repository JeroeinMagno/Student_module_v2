import 'package:flutter/material.dart';
import '../components.dart';
import '../../features/courses/ui/courses_page.dart';
import '../../features/exam/ui/exam_page.dart';
import '../../features/career/ui/career_page.dart';
import '../../features/chatbot/ui/chatbot_page.dart';

/// Main layout with navigation that matches original design exactly
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
        return const CoursesPage();
      case '/exam-overview':
        return const ExamPage();
      case '/career':
        return const CareerPage();
      case '/skill-profile':
        return const BlankPage(title: 'Skill Profile');
      case '/track-readiness':
        return const BlankPage(title: 'Track Readiness');
      case '/chatbot':
        return const ChatbotPage();
      default:
        return const StudentPerformanceContent();
    }
  }

  void _handleRouteSelection(String route) {
    setState(() {
      _selectedRoute = route;
    });
    
    // Close drawer if open
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _getPageTitle(widget.currentRoute),
      ),
      drawer: AppDrawer(
        currentRoute: widget.currentRoute,
        onRouteSelected: _handleRouteSelection,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _getPageContent(widget.currentRoute),
      ),
    );
  }
}
