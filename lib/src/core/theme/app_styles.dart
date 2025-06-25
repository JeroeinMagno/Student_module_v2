import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// Utility class for consistent styling matching the CSS design system
class AppStyles {
  
  // Card styling matching CSS design system
  static BoxDecoration cardDecoration(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
      borderRadius: BorderRadius.circular(10.r), // --radius: 0.625rem
      border: Border.all(
        color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
        width: 1,
      ),
      boxShadow: isDarkMode ? [] : [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Primary button styling
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton.styleFrom(
      backgroundColor: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      foregroundColor: isDarkMode 
          ? AppColors.primaryForegroundDark 
          : AppColors.primaryForegroundLight,
      elevation: isDarkMode ? 0 : 2,
      shadowColor: isDarkMode ? Colors.transparent : Colors.black.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    );
  }

  // Secondary button styling
  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: isDarkMode 
          ? AppColors.secondaryForegroundDark 
          : AppColors.secondaryForegroundLight,
      elevation: isDarkMode ? 0 : 2,
      shadowColor: isDarkMode ? Colors.transparent : Colors.black.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    );
  }

  // Status badge styling (for assessment statuses)
  static BoxDecoration statusBadgeDecoration(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = AppColors.success;
        break;
      case 'upcoming':
        backgroundColor = AppColors.info;
        break;
      case 'missing':
        backgroundColor = AppColors.error;
        break;
      case 'in progress':
        backgroundColor = AppColors.warning;
        break;
      default:
        backgroundColor = AppColors.mutedLight;
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  // Text styles matching CSS design system
  static TextStyle headingStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle subheadingStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDarkMode 
          ? AppColors.mutedForegroundDark 
          : AppColors.mutedForegroundLight,
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle bodyStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDarkMode ? AppColors.foregroundDark : AppColors.foregroundLight,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle primaryTextStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDarkMode ? AppColors.foregroundDark : AppColors.foregroundLight,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle secondaryTextStyle(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDarkMode 
          ? AppColors.mutedForegroundDark 
          : AppColors.mutedForegroundLight,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }
  // Progress bar styling
  static Color progressBarColor(BuildContext context) {
    return const Color(0xFFEF4444); // Always use red for progress indicators
  }

  static Color progressBarBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode 
        ? AppColors.mutedDark 
        : AppColors.mutedLight;
  }

  // Chart colors matching CSS variables
  static List<Color> get chartColors => [
    AppColors.chartRed,
    AppColors.chartOrange,
    AppColors.chartYellow,
    AppColors.chartBlue,
    AppColors.chartCorrect,
  ];

  // Border radius values matching CSS --radius variables
  static double get radiusSm => 6.r;   // calc(var(--radius) - 4px)
  static double get radiusMd => 8.r;   // calc(var(--radius) - 2px)
  static double get radiusLg => 10.r;  // var(--radius)
  static double get radiusXl => 14.r;  // calc(var(--radius) + 4px)

  // Surface colors for elevated components
  static Color surfaceColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
  }

  // Input field styling
  static InputDecorationTheme inputDecorationTheme(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InputDecorationTheme(
      filled: true,
      fillColor: isDarkMode ? AppColors.mutedDark : AppColors.mutedLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        borderSide: BorderSide(
          color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        borderSide: BorderSide(
          color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        borderSide: BorderSide(
          color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
          width: 2,
        ),
      ),
    );
  }
}
