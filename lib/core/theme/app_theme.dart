import 'package:flutter/material.dart';
import '../../constants/constants.dart';

/// Centralized theme configuration
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _lightCardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: _dividerTheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: _getFontFamily(),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: _dividerTheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: _getFontFamily(),
    );
  }

  /// Get font family with fallback support
  static String? _getFontFamily() {
    // Don't use Google Fonts when runtime fetching is disabled
    // Return null to use system default fonts
    return null;
  }

  // Color Schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryLight,
    surface: AppColors.surfaceLight,
    background: AppColors.backgroundLight,
    error: AppColors.error,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimary,
    onBackground: AppColors.textPrimary,
    onError: Colors.white,
    outline: AppColors.borderLight,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryDark,
    surface: AppColors.surfaceDark,
    background: AppColors.backgroundDark,
    error: AppColors.error,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimaryDark,
    onBackground: AppColors.textPrimaryDark,
    onError: Colors.white,
    outline: AppColors.borderDark,
  );

  // Text Theme
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      displaySmall: AppTextStyles.heading3,
      headlineLarge: AppTextStyles.heading4,
      headlineMedium: AppTextStyles.heading5,
      headlineSmall: AppTextStyles.heading6,
      titleLarge: AppTextStyles.heading6,
      titleMedium: AppTextStyles.labelLarge,
      titleSmall: AppTextStyles.labelMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  // App Bar Themes
  static AppBarTheme get _lightAppBarTheme {
    return AppBarTheme(
      elevation: AppDimensions.appBarElevation,
      backgroundColor: AppColors.surfaceLight,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: AppTextStyles.heading6.copyWith(
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
      ),
    );
  }

  static AppBarTheme get _darkAppBarTheme {
    return AppBarTheme(
      elevation: AppDimensions.appBarElevation,
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      titleTextStyle: AppTextStyles.heading6.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDark,
      ),
    );
  }

  // Card Themes
  static CardThemeData get _lightCardTheme {
    return CardThemeData(
      color: AppColors.cardLight,
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLG),
        side: BorderSide(
          color: AppColors.borderLight,
          width: AppDimensions.cardBorderWidth,
        ),
      ),
    );
  }

  static CardThemeData get _darkCardTheme {
    return CardThemeData(
      color: AppColors.cardDark,
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLG),
        side: BorderSide(
          color: AppColors.borderDark,
          width: AppDimensions.cardBorderWidth,
        ),
      ),
    );
  }

  // Button Themes
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLG,
          vertical: AppDimensions.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        ),
        textStyle: AppTextStyles.buttonMedium,
        elevation: 0,
        minimumSize: Size(0, AppDimensions.buttonHeightMD),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLG,
          vertical: AppDimensions.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        ),
        side: const BorderSide(color: AppColors.primary),
        textStyle: AppTextStyles.buttonMedium,
        minimumSize: Size(0, AppDimensions.buttonHeightMD),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: AppDimensions.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        ),
        textStyle: AppTextStyles.buttonMedium,
        minimumSize: Size(0, AppDimensions.buttonHeightMD),
      ),
    );
  }

  // Input Decoration Theme
  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMD,
        vertical: AppDimensions.paddingSM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  // Divider Theme
  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
      space: 1,
    );
  }
}
