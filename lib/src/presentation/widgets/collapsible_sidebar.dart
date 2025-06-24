import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollapsibleSidebar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final String selectedRoute;
  final Function(String) onRouteSelected;

  const CollapsibleSidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.selectedRoute,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExpanded ? 200.w : 60.w,
      decoration: BoxDecoration(
        color: isDarkMode ? theme.colorScheme.surface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
        border: Border(
          right: BorderSide(
            color: isDarkMode 
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          if (isExpanded) _buildUserInfo(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Static Dashboard Label
                  Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.dashboard_outlined,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          size: 20.sp,
                        ),
                        if (isExpanded) ...[
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildNavigationItem(
                    context: context,
                    icon: Icons.assessment_outlined,
                    title: 'Student Performance',
                    isSelected: selectedRoute == 'performance',
                    onTap: () => onRouteSelected('performance'),
                  ),
                  _buildNavigationItem(
                    context: context,
                    icon: Icons.work_outline,
                    title: 'Career',
                    isSelected: selectedRoute == 'career',
                    onTap: () => onRouteSelected('career'),
                  ),
                  _buildNavigationItem(
                    context: context,
                    icon: Icons.chat_bubble_outline,
                    title: 'Chatbot',
                    isSelected: selectedRoute == 'chatbot',
                    onTap: () => onRouteSelected('chatbot'),
                  ),
                ],
              ),
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color getTextColor() {
      if (isSelected) {
        return theme.colorScheme.primary;
      }
      return isDarkMode ? Colors.white70 : Colors.black87;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: getTextColor(),
                size: 20.sp,
              ),
              if (isExpanded) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: getTextColor(),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 56.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(
              isExpanded ? Icons.menu_open : Icons.menu,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            onPressed: onToggle,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: 32.w,
              minHeight: 32.h,
            ),
          ),
          if (isExpanded) ...[
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Student Module',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.person,
              size: 20.sp,
              color: theme.colorScheme.primary,
            ),
          ),
          if (isExpanded) ...[
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '22-12345',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isDarkMode ? Colors.white60 : Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        width: isExpanded ? 180.w : 44.w,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle logout
            },
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.error,
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    color: theme.colorScheme.error,
                    size: 16.sp,
                  ),
                  if (isExpanded) ...[
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.error,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
