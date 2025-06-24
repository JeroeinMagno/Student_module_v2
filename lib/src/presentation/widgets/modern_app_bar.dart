import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';

class ModernAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const ModernAppBar({
    super.key,
    this.title = 'Dashboard',
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        // Year Filter Button
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: TextButton.icon(
            onPressed: () => _showYearFilter(context),
            icon: Icon(
              Icons.filter_list,
              size: 16.w,
            ),
            label: const Text('2024-2025'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
        
        // Notifications
        IconButton(
          onPressed: () => _showNotifications(context),
          icon: Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                size: 24.w,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Theme Toggle
        IconButton(
          onPressed: () => _toggleTheme(context, ref),
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
            size: 20.w,
          ),
        ),
        
        // User Profile
        Container(
          margin: EdgeInsets.only(right: 16.w, left: 8.w),
          child: ref.watch(studentInfoProvider).when(
            loading: () => _buildProfileSkeleton(context),
            error: (error, stack) => _buildProfileError(context),
            data: (student) => _buildProfileButton(context, student),
          ),
        ),
        
        ...?actions,
      ],
    );
  }

  Widget _buildProfileButton(BuildContext context, dynamic student) {
    return GestureDetector(
      onTap: () => _showProfileMenu(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              student?.name?.substring(0, 2).toUpperCase() ?? 'ST',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16.w,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSkeleton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Icon(
          Icons.keyboard_arrow_down,
          size: 16.w,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildProfileError(BuildContext context) {
    return Icon(
      Icons.account_circle,
      size: 32.w,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
    );
  }

  void _showYearFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Academic Year',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            ...['2024-2025', '2023-2024', '2022-2023'].map(
              (year) => ListTile(
                title: Text(year),
                trailing: year == '2024-2025' 
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement year filter
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications clicked')),
    );
  }

  void _toggleTheme(BuildContext context, WidgetRef ref) {
    // TODO: Implement theme toggle with provider
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Theme toggle clicked')),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement logout
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
