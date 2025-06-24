import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/mock/centralized_mock_data.dart';

class SidebarNavigation extends StatefulWidget {
  final String? currentRoute;
  final Function(String) onNavigate;
  final VoidCallback? onLogout;

  const SidebarNavigation({
    super.key,
    this.currentRoute,
    required this.onNavigate,
    this.onLogout,
  });

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  final Map<String, bool> _expandedSections = {
    'student_performance': false,
    'career': false,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header Section
          _buildHeader(theme),
          
          // User Profile Section
          _buildUserProfile(theme),
          
          const Divider(height: 1),
          
          // Navigation Menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  isSelected: widget.currentRoute == '/dashboard',
                  onTap: () => widget.onNavigate('/dashboard'),
                ),
                
                _buildExpandableMenuItem(
                  icon: Icons.trending_up_outlined,
                  title: 'Student Performance',
                  sectionKey: 'student_performance',
                  children: [
                    _buildSubMenuItem(
                      title: 'Courses',
                      isSelected: widget.currentRoute == '/courses',
                      onTap: () => widget.onNavigate('/courses'),
                    ),
                    _buildSubMenuItem(
                      title: 'Exam Overview',
                      isSelected: widget.currentRoute == '/exam-overview',
                      onTap: () => widget.onNavigate('/exam-overview'),
                    ),
                  ],
                ),
                
                _buildExpandableMenuItem(
                  icon: Icons.work_outline,
                  title: 'Career',
                  sectionKey: 'career',
                  children: [
                    _buildSubMenuItem(
                      title: 'Skill Profile',
                      isSelected: widget.currentRoute == '/skill-profile',
                      onTap: () => widget.onNavigate('/skill-profile'),
                    ),
                    _buildSubMenuItem(
                      title: 'Track Readiness',
                      isSelected: widget.currentRoute == '/track-readiness',
                      onTap: () => widget.onNavigate('/track-readiness'),
                    ),
                  ],
                ),
                
                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Chatbot',
                  isSelected: widget.currentRoute == '/chatbot',
                  onTap: () => widget.onNavigate('/chatbot'),
                ),
              ],
            ),
          ),
          
          // Logout Button
          if (widget.onLogout != null) _buildLogoutButton(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: SvgPicture.asset(
                'assets/icons/bsulogo.svg',
                width: 20.w,
                height: 20.h,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Student Module',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildUserProfile(ThemeData theme) {
    final userInfo = CentralizedMockData.getUserInfo();
    
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
            child: Text(
              userInfo['name']?.split(' ').map((name) => name[0]).join('').substring(0, 2) ?? 'JD',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo['name'] ?? 'John Doe',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  userInfo['srCode'] ?? '22-12345',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          hoverColor: AppTheme.primaryGreen.withOpacity(0.05),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryGreen.withOpacity(0.1) : null,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: isSelected ? AppTheme.primaryGreen : AppTheme.textSecondary,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppTheme.primaryGreen : theme.textTheme.bodyMedium?.color,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildExpandableMenuItem({
    required IconData icon,
    required String title,
    required String sectionKey,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final isExpanded = _expandedSections[sectionKey] ?? false;
    
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _expandedSections[sectionKey] = !isExpanded;
                });
              },
              borderRadius: BorderRadius.circular(8.r),
              hoverColor: AppTheme.primaryGreen.withOpacity(0.05),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 20.sp,
                      color: AppTheme.textSecondary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                      size: 20.sp,
                      color: AppTheme.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(children: children),
          ),
      ],
    );
  }
  Widget _buildSubMenuItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.r),
          hoverColor: AppTheme.primaryGreen.withOpacity(0.05),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryGreen.withOpacity(0.1) : null,
              borderRadius: BorderRadius.circular(6.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                SizedBox(width: 32.w), // Indent for sub-items
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? AppTheme.primaryGreen : theme.textTheme.bodySmall?.color,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildLogoutButton(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: widget.onLogout,
          icon: Icon(
            Icons.logout,
            size: 18.sp,
            color: theme.colorScheme.error,
          ),
          label: Text(
            'Log Out',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.error),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            overlayColor: theme.colorScheme.error.withOpacity(0.05),
          ),
        ),
      ),
    );
  }
}
