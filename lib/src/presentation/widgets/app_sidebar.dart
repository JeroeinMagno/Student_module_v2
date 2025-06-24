import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and title
            Container(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/bsulogo.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Student Module',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // User info section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '22-12345',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Navigation menu
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.dashboard_outlined,
                    title: 'Student Performance',
                    isActive: true,
                    onTap: () => context.go('/dashboard'),
                  ),
                  _buildSubMenuItem(
                    context,
                    title: 'Courses',
                    onTap: () => context.go('/dashboard/course'),
                  ),
                  _buildSubMenuItem(
                    context,
                    title: 'Exam Overview',
                    onTap: () => context.go('/dashboard/exam'),
                  ),
                  SizedBox(height: 8.h),
                  _buildMenuItem(
                    context,
                    icon: Icons.work_outline,
                    title: 'Career',
                    onTap: () => context.go('/dashboard/career'),
                  ),
                  SizedBox(height: 8.h),
                  _buildMenuItem(
                    context,
                    icon: Icons.chat_bubble_outline,
                    title: 'Chatbot',
                    onTap: () => context.go('/dashboard/bot'),
                  ),
                ],
              ),
            ),
            
            // Logout button
            Container(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Handle logout
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        tileColor: isActive
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : null,
      ),
    );
  }

  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 32.w, bottom: 4.h),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        dense: true,
      ),
    );
  }
}
