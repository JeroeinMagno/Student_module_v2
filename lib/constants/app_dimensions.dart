import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App dimensions and spacing constants
class AppDimensions {
  AppDimensions._();

  // Padding and Margins
  static double get paddingXS => 4.w;
  static double get paddingSM => 8.w;
  static double get paddingMD => 16.w;
  static double get paddingLG => 24.w;
  static double get paddingXL => 32.w;
  static double get paddingXXL => 48.w;

  // Border Radius
  static double get borderRadiusSM => 4.r;
  static double get borderRadiusMD => 8.r;
  static double get borderRadiusLG => 12.r;
  static double get borderRadiusXL => 16.r;
  static double get borderRadiusRound => 999.r;

  // Icon Sizes
  static double get iconXS => 12.sp;
  static double get iconSM => 16.sp;
  static double get iconMD => 20.sp;
  static double get iconLG => 24.sp;
  static double get iconXL => 32.sp;
  static double get iconXXL => 48.sp;

  // Button Heights
  static double get buttonHeightSM => 32.h;
  static double get buttonHeightMD => 40.h;
  static double get buttonHeightLG => 48.h;
  static double get buttonHeightXL => 56.h;

  // Card dimensions
  static double get cardElevation => 2.0;
  static double get cardBorderWidth => 1.0;

  // App Bar
  static double get appBarHeight => 56.h;
  static double get appBarElevation => 0.0;

  // Drawer
  static double get drawerWidth => 280.w;

  // Grid and List spacing
  static double get gridSpacing => 16.w;
  static double get listSpacing => 8.h;

  // Breakpoints for responsive design
  static double get mobileBreakpoint => 600;
  static double get tabletBreakpoint => 900;
  static double get desktopBreakpoint => 1200;

  // Animation durations (in milliseconds)
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
