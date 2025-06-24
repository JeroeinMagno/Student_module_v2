import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive utilities for consistent sizing across the app
class ResponsiveUtils {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _desktopBreakpoint;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding({
    double? mobile,
    double? tablet,
    double? desktop,
    required BuildContext context,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    double padding;
    
    if (screenWidth < _mobileBreakpoint) {
      padding = mobile ?? 16.w;
    } else if (screenWidth < _tabletBreakpoint) {
      padding = tablet ?? 24.w;
    } else {
      padding = desktop ?? 32.w;
    }
    
    return EdgeInsets.all(padding);
  }

  /// Get responsive spacing based on screen size
  static double getResponsiveSpacing({
    double? mobile,
    double? tablet,
    double? desktop,
    required BuildContext context,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return mobile ?? 16.h;
    } else if (screenWidth < _tabletBreakpoint) {
      return tablet ?? 24.h;
    } else {
      return desktop ?? 32.h;
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize({
    double? mobile,
    double? tablet,
    double? desktop,
    required BuildContext context,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return mobile?.sp ?? 14.sp;
    } else if (screenWidth < _tabletBreakpoint) {
      return tablet?.sp ?? 16.sp;
    } else {
      return desktop?.sp ?? 18.sp;
    }
  }

  /// Get responsive column count for grids
  static int getResponsiveColumnCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return 1;
    } else if (screenWidth < _tabletBreakpoint) {
      return 2;
    } else {
      return 3;
    }
  }

  /// Get responsive aspect ratio for cards
  static double getResponsiveAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return 16 / 9; // Mobile: wider cards
    } else if (screenWidth < _tabletBreakpoint) {
      return 4 / 3; // Tablet: square-ish cards
    } else {
      return 3 / 2; // Desktop: landscape cards
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize({
    double? mobile,
    double? tablet,
    double? desktop,
    required BuildContext context,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return mobile?.w ?? 24.w;
    } else if (screenWidth < _tabletBreakpoint) {
      return tablet?.w ?? 28.w;
    } else {
      return desktop?.w ?? 32.w;
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return 48.h;
    } else if (screenWidth < _tabletBreakpoint) {
      return 52.h;
    } else {
      return 56.h;
    }
  }

  /// Get responsive max width for content
  static double getResponsiveMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return screenWidth * 0.95;
    } else if (screenWidth < _tabletBreakpoint) {
      return screenWidth * 0.8;
    } else {
      return 1200.w; // Max width for desktop
    }
  }

  /// Get responsive chart height
  static double getResponsiveChartHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < _mobileBreakpoint) {
      return 200.h;
    } else if (screenWidth < _tabletBreakpoint) {
      return 250.h;
    } else {
      return 300.h;
    }
  }
}

/// Extension methods for responsive design
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  
  EdgeInsets responsivePadding({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtils.getResponsivePadding(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      context: this,
    );
  }
  
  double responsiveSpacing({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtils.getResponsiveSpacing(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      context: this,
    );
  }
  
  double responsiveFontSize({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtils.getResponsiveFontSize(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      context: this,
    );
  }
  
  int get responsiveColumnCount => ResponsiveUtils.getResponsiveColumnCount(this);
  double get responsiveAspectRatio => ResponsiveUtils.getResponsiveAspectRatio(this);
  double get responsiveButtonHeight => ResponsiveUtils.getResponsiveButtonHeight(this);
  double get responsiveMaxWidth => ResponsiveUtils.getResponsiveMaxWidth(this);
  double get responsiveChartHeight => ResponsiveUtils.getResponsiveChartHeight(this);
  
  double responsiveIconSize({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtils.getResponsiveIconSize(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      context: this,
    );
  }
}

/// Responsive breakpoint constants
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

/// Responsive text styles
class ResponsiveTextStyles {
  static TextStyle getHeadlineStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.responsiveFontSize(
        mobile: 24,
        tablet: 28,
        desktop: 32,
      ),
      fontWeight: FontWeight.bold,
    );
  }
  
  static TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.responsiveFontSize(
        mobile: 18,
        tablet: 20,
        desktop: 22,
      ),
      fontWeight: FontWeight.w600,
    );
  }
  
  static TextStyle getBodyStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.responsiveFontSize(
        mobile: 14,
        tablet: 16,
        desktop: 16,
      ),
      fontWeight: FontWeight.normal,
    );
  }
  
  static TextStyle getCaptionStyle(BuildContext context) {
    return TextStyle(
      fontSize: context.responsiveFontSize(
        mobile: 12,
        tablet: 13,
        desktop: 14,
      ),
      fontWeight: FontWeight.normal,
    );
  }
}
