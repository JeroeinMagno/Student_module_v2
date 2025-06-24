import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';
import '../common/app_components.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;
              
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 24.w,
                          color: isSelected 
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isSelected 
                                ? AppTheme.primaryGreen
                                : AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Student? student;
  final List<DrawerItem> items;
  final Function(DrawerItem) onItemTap;
  final VoidCallback? onLogout;

  const AppDrawer({
    super.key,
    this.student,
    required this.items,
    required this.onItemTap,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: Column(
        children: [
          // Header with logo and title
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: SvgPicture.asset(
                          'assets/icons/bsulogo.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Student Module',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // User info
                if (student != null) ...[
                  Text(
                    student!.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    student!.studentId,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Navigation items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                
                if (item.children.isNotEmpty) {
                  return ExpansionTile(
                    leading: Icon(item.icon),
                    title: Text(
                      item.title,
                      style: theme.textTheme.bodyMedium,
                    ),
                    children: item.children.map((child) {
                      return ListTile(
                        leading: SizedBox(width: 24.w),
                        title: Text(
                          child.title,
                          style: theme.textTheme.bodyMedium,
                        ),
                        onTap: () => onItemTap(child),
                      );
                    }).toList(),
                  );
                }
                
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(
                    item.title,
                    style: theme.textTheme.bodyMedium,
                  ),
                  onTap: () => onItemTap(item),
                );
              },
            ),
          ),
          
          // Logout button
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.destructive),
            title: Text(
              'Log Out',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.destructive,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onLogout,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showFilter;
  final VoidCallback? onFilterTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;

  const DashboardAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showFilter = true,
    this.onFilterTap,
    this.onNotificationTap,
    this.onThemeToggle,
    this.isDarkMode = false,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      scrolledUnderElevation: 1,
      actions: [
        if (showFilter && onFilterTap != null)
          AppIconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterTap,
            tooltip: 'Filter',
          ),
        
        SizedBox(width: 8.w),
        
        if (onNotificationTap != null)
          AppIconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: onNotificationTap,
            tooltip: 'Notifications',
          ),
        
        SizedBox(width: 8.w),
        
        if (onThemeToggle != null)
          AppIconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: onThemeToggle,
            tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
          ),
        
        if (actions != null) ...actions!,
        
        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class InsightsWidget extends StatelessWidget {
  final List<InsightData> insights;

  const InsightsWidget({
    super.key,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Insights',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          Column(
            children: insights.map((insight) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: insight.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    SizedBox(width: 12.w),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight.title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            insight.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    if (insight.value != null)
                      Text(
                        insight.value!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: insight.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Data Models
class BottomNavItem {
  final IconData icon;
  final String label;
  final String route;

  BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class DrawerItem {
  final String title;
  final IconData icon;
  final String route;
  final List<DrawerItem> children;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
    this.children = const [],
  });
}

class Student {
  final String name;
  final String studentId;
  final String email;
  final String? profileImage;

  Student({
    required this.name,
    required this.studentId,
    required this.email,
    this.profileImage,
  });
}

class InsightData {
  final String title;
  final String description;
  final String? value;
  final Color color;

  InsightData({
    required this.title,
    required this.description,
    this.value,
    required this.color,
  });
}
