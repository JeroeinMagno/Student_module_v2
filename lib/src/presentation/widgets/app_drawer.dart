import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatefulWidget {
  final String currentRoute;
  final Function(String) onRouteSelected;

  const AppDrawer({
    super.key,
    required this.currentRoute,
    required this.onRouteSelected,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isDashboardExpanded = true;
  bool _isCareerExpanded = false;

  @override
  void initState() {
    super.initState();
    _initializeExpandedState();
  }
  void _initializeExpandedState() {
    // Auto-expand sections based on current route
    if (widget.currentRoute == '/career' || widget.currentRoute == '/skill-profile' || widget.currentRoute == '/track-readiness') {
      _isCareerExpanded = true;
      _isDashboardExpanded = false;
    } else if (widget.currentRoute == '/performance' || widget.currentRoute == '/courses' || widget.currentRoute == '/exam-overview') {
      _isDashboardExpanded = true;
      _isCareerExpanded = false;
    } else {
      _isDashboardExpanded = true;
      _isCareerExpanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            
            // User info section
            _buildUserInfo(context),
            
            const Divider(height: 1),
            
            // Navigation items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [                  SizedBox(height: 8.h),
                  
                  // Student Performance Section (Clickable + Expandable)
                  _buildClickableExpandableSection(
                    context: context,
                    title: 'Student Performance',
                    icon: Icons.bar_chart_outlined,
                    selectedIcon: Icons.bar_chart,
                    route: 'performance',
                    isExpanded: _isDashboardExpanded,
                    onTap: () {
                      Navigator.pop(context);
                      widget.onRouteSelected('performance');
                      context.go('/performance');
                    },
                    onExpandTap: () {
                      setState(() {
                        _isDashboardExpanded = !_isDashboardExpanded;
                      });
                    },
                    children: [
                      _buildSubMenuItem(
                        context: context,
                        icon: Icons.book_outlined,
                        title: 'Courses',
                        route: 'courses',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onRouteSelected('courses');
                          context.go('/courses');
                        },
                      ),
                      _buildSubMenuItem(
                        context: context,
                        icon: Icons.quiz_outlined,
                        title: 'Exam Overview',
                        route: 'exam-overview',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onRouteSelected('exam-overview');
                          context.go('/exam-overview');
                        },
                      ),
                    ],
                  ),
                    // Career Section (Clickable + Expandable)
                  _buildClickableExpandableSection(
                    context: context,
                    title: 'Career',
                    icon: Icons.work_outline,
                    selectedIcon: Icons.work,
                    route: 'career',
                    isExpanded: _isCareerExpanded,                    onTap: () {
                      Navigator.pop(context);
                      widget.onRouteSelected('career');
                      context.go('/career'); // Navigate to dedicated career page
                    },
                    onExpandTap: () {
                      setState(() {
                        _isCareerExpanded = !_isCareerExpanded;
                      });
                    },
                    children: [
                      _buildSubMenuItem(
                        context: context,
                        icon: Icons.person_outline,
                        title: 'Skill Profile',
                        route: 'skill-profile',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onRouteSelected('skill-profile');
                          context.go('/skill-profile');
                        },
                      ),
                      _buildSubMenuItem(
                        context: context,
                        icon: Icons.trending_up_outlined,
                        title: 'Career Match',
                        route: 'career-match',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onRouteSelected('career-match');
                          context.go('/track-readiness');
                        },
                      ),
                    ],
                  ),
                  
                  // Chatbot (Single item)
                  _buildSingleMenuItem(
                    context: context,
                    icon: Icons.chat_bubble_outline,
                    selectedIcon: Icons.chat_bubble,
                    title: 'Chatbot',
                    route: 'chatbot',
                    onTap: () {
                      Navigator.pop(context);
                      widget.onRouteSelected('chatbot');
                      context.go('/chatbot');
                    },
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // Logout button
            _buildLogoutItem(context),
            
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.school,
              color: theme.colorScheme.primary,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                Text(
                  'Student Module',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.person,
              color: theme.colorScheme.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                Text(
                  'John Doe',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  '22-12345',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }  Widget _buildClickableExpandableSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required IconData selectedIcon,
    required String route,
    required bool isExpanded,
    required VoidCallback onTap,
    required VoidCallback onExpandTap,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final isSelected = _isRouteSelected(route);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected 
                      ? const Color(0xFFEF4444)
                      : theme.colorScheme.onSurface.withOpacity(0.8),
                  size: 22.sp,
                ),
                title: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected 
                        ? const Color(0xFFEF4444)
                        : theme.colorScheme.onSurface,
                    fontSize: 16.sp,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                onTap: onTap,
              ),
            ),
            IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
              onPressed: onExpandTap,
            ),
          ],
        ),
        if (isExpanded) ...children,
      ],
    );
  }

  Widget _buildSubMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isSelected = _isRouteSelected(route);

    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: ListTile(
        leading: Container(
          width: 6.w,
          height: 20.h,          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEF4444) : Colors.transparent,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        title: Row(
          children: [            Icon(
              icon,              color: isSelected 
                  ? const Color(0xFFEF4444)
                  : theme.colorScheme.onSurface.withOpacity(0.7),
              size: 18.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,                color: isSelected 
                    ? const Color(0xFFEF4444)
                    : theme.colorScheme.onSurface.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSingleMenuItem({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required String route,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isSelected = _isRouteSelected(route);    return ListTile(
      leading: Icon(
        isSelected ? selectedIcon : icon,
        color: isSelected 
            ? const Color(0xFFEF4444)
            : theme.colorScheme.onSurface.withOpacity(0.8),
        size: 22.sp,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected 
              ? const Color(0xFFEF4444)
              : theme.colorScheme.onSurface,
          fontSize: 16.sp,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      onTap: onTap,
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.error.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: theme.colorScheme.error,
          size: 20.sp,
        ),
        title: Text(
          'Log Out',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.error,
            fontSize: 14.sp,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        onTap: () {
          Navigator.pop(context);
          _showLogoutDialog(context);
        },
      ),
    );
  }  bool _isRouteSelected(String route) {
    switch (route) {
      case 'performance':
        return widget.currentRoute == '/performance' || widget.currentRoute == '/dashboard' || widget.currentRoute == '/';
      case 'courses':
        return widget.currentRoute == '/courses';
      case 'exam-overview':
        return widget.currentRoute == '/exam-overview';
      case 'career':
        return widget.currentRoute == '/career';
      case 'skill-profile':
        return widget.currentRoute == '/skill-profile';
      case 'career-match':
        return widget.currentRoute == '/track-readiness';
      case 'chatbot':
        return widget.currentRoute == '/chatbot';
      default:
        return false;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement logout logic
                // context.go('/login');
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
