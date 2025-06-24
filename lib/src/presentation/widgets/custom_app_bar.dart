import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: onMenuPressed,
        icon: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: [
        // Year Filter
        Container(
          margin: EdgeInsets.only(right: 8.w),
          child: TextButton.icon(
            onPressed: () {
              // Show year filter dialog
            },
            icon: const Icon(Icons.filter_list),
            label: const Text('2024'),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        // Notifications
        Container(
          margin: EdgeInsets.only(right: 8.w),
          child: IconButton(
            onPressed: () {
              // Show notifications
            },
            icon: const Icon(Icons.notifications_outlined),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        // Theme toggle
        Container(
          margin: EdgeInsets.only(right: 16.w),
          child: IconButton(
            onPressed: () {
              // Toggle theme
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
