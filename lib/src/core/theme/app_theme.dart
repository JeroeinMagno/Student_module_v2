import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Colors matching the web system
  static const Color primaryGreen = Color(0xFF6B9B8A);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color mutedLight = Color(0xFFF5F5F5);
  static const Color mutedDark = Color(0xFF262626);
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color borderDark = Color(0xFF404040);
  static const Color textPrimary = Color(0xFF0A0A0A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color destructive = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Chart colors
  static const List<Color> chartColors = [
    Color(0xFF3B82F6), // chart-1
    Color(0xFF10B981), // chart-2
    Color(0xFFF59E0B), // chart-3
    Color(0xFFEF4444), // chart-4
    Color(0xFF8B5CF6), // chart-5
  ];

  // Border radius matching web (0.625rem = 10px)
  static double get borderRadius => 10.r;
  static double get borderRadiusSm => 6.r;
  static double get borderRadiusMd => 8.r;
  static double get borderRadiusLg => 10.r;
  static double get borderRadiusXl => 14.r;

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
        onPrimary: Colors.white,
        onBackground: textPrimary,
        onSurface: textPrimary,
        secondary: textSecondary,
      ),      scaffoldBackgroundColor: backgroundLight,
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderLight, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cardLight,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
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
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.dark,
        background: backgroundDark,
        surface: cardDark,
        surfaceContainerHighest: mutedDark,
        outline: borderDark,
        error: destructive,
        primary: primaryGreen,
        onPrimary: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
        secondary: textSecondary,
      ),      scaffoldBackgroundColor: backgroundDark,
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
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
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light ? textPrimary : Colors.white;
    
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
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        height: 1.4,
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
