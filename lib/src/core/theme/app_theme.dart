import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  // Colors matching the CSS design system
  static const Color primaryGreen = AppColors.primaryLight; // Using the CSS green primary
  static const Color backgroundLight = AppColors.backgroundLight;
  static const Color backgroundDark = AppColors.backgroundDark;
  static const Color cardLight = AppColors.cardLight;
  static const Color cardDark = AppColors.cardDark;
  static const Color mutedLight = AppColors.mutedLight;
  static const Color mutedDark = AppColors.mutedDark;
  static const Color borderLight = AppColors.borderLight;
  static const Color borderDark = AppColors.borderDark;

  // Text colors from CSS design system
  static const Color textPrimary = AppColors.foregroundLight;
  static const Color textSecondary = AppColors.mutedForegroundLight;
  static const Color destructive = AppColors.destructiveLight;
  static const Color success = AppColors.success;
  static const Color warning = AppColors.warning;

  // Chart colors matching CSS variables
  static const List<Color> chartColors = [
    AppColors.chartBlue,
    AppColors.chartCorrect,
    AppColors.chartYellow,
    AppColors.chartRed,
    AppColors.chartOrange,
  ];

  // Border radius matching CSS --radius variables (0.625rem = 10px)
  static double get borderRadius => 10.r;
  static double get borderRadiusSm => 6.r;  // calc(var(--radius) - 4px)
  static double get borderRadiusMd => 8.r;  // calc(var(--radius) - 2px)
  static double get borderRadiusLg => 10.r; // var(--radius)
  static double get borderRadiusXl => 14.r; // calc(var(--radius) + 4px)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        background: backgroundLight,
        surface: cardLight,
        surfaceContainerHighest: mutedLight,
        outline: borderLight,
        error: destructive,
        primary: primaryGreen,
        onPrimary: AppColors.primaryForegroundLight,
        onBackground: AppColors.foregroundLight,
        onSurface: AppColors.cardForegroundLight,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryForegroundLight,
        onSurfaceVariant: AppColors.foregroundLight,
        onSecondaryContainer: AppColors.foregroundLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderLight, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cardLight,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardLight,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardLight,
        elevation: 8,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: _buildTextTheme(Brightness.light),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.light),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.light),
      outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.light),
      chipTheme: _buildChipTheme(Brightness.light),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFEF4444), // Red color for all progress indicators
        linearTrackColor: mutedLight,
        circularTrackColor: mutedLight,
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryDark,
        brightness: Brightness.dark,
        background: backgroundDark,
        surface: cardDark,
        surfaceContainerHighest: mutedDark,
        outline: borderDark,
        error: AppColors.destructiveDark,
        primary: AppColors.primaryDark,
        onPrimary: AppColors.primaryForegroundDark,
        onBackground: AppColors.foregroundDark,
        onSurface: AppColors.cardForegroundDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryForegroundDark,
        onSurfaceVariant: AppColors.mutedForegroundDark,
        onSecondaryContainer: AppColors.foregroundDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderDark, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cardDark,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardDark,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardDark,
        elevation: 8,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      inputDecorationTheme: _buildInputDecorationTheme(Brightness.dark),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.dark),
      outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.dark),
      chipTheme: _buildChipTheme(Brightness.dark),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFEF4444), // Red color for all progress indicators
        linearTrackColor: mutedDark,
        circularTrackColor: mutedDark,
      ),
    );
  }  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light 
        ? AppColors.foregroundLight 
        : AppColors.foregroundDark;
    final textSecondaryColor = brightness == Brightness.light 
        ? AppColors.mutedForegroundLight 
        : AppColors.mutedForegroundDark;
    
    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.3,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.5,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.5,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.6,
        letterSpacing: 0.15,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: textSecondaryColor,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: textSecondaryColor,
        height: 1.4,
        letterSpacing: 0.1,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: textSecondaryColor,
        height: 1.4,
        letterSpacing: 0.1,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(Brightness brightness) {
    final borderColor = brightness == Brightness.light ? borderLight : borderDark;
    final fillColor = brightness == Brightness.light ? mutedLight : mutedDark;
    
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: destructive),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(Brightness brightness) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(Brightness brightness) {
    final borderColor = brightness == Brightness.light ? borderLight : borderDark;
    
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: BorderSide(color: borderColor),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static ChipThemeData _buildChipTheme(Brightness brightness) {
    final backgroundColor = brightness == Brightness.light ? mutedLight : mutedDark;
    
    return ChipThemeData(
      backgroundColor: backgroundColor,
      selectedColor: primaryGreen.withOpacity(0.1),
      labelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSm),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    );
  }
}
