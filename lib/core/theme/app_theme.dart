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
      scaffoldBackgroundColor: AppColors.background,
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
    primaryContainer: AppColors.accent,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.accent,
    surface: AppColors.card,
    background: AppColors.background,
    error: AppColors.destructive,
    onPrimary: AppColors.primaryForeground,
    onSecondary: AppColors.secondaryForeground,
    onSurface: AppColors.foreground,
    onBackground: AppColors.foreground,
    onError: AppColors.destructiveForeground,
    outline: AppColors.border,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryDark,
    primaryContainer: AppColors.accentDark,
    secondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.accentDark,
    surface: AppColors.cardDark,
    background: AppColors.backgroundDark,
    error: AppColors.destructiveDark,
    onPrimary: AppColors.primaryForegroundDark,
    onSecondary: AppColors.secondaryForegroundDark,
    onSurface: AppColors.foregroundDark,
    onBackground: AppColors.foregroundDark,
    onError: AppColors.destructiveForegroundDark,
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
      backgroundColor: AppColors.card,
      foregroundColor: AppColors.foreground,
      titleTextStyle: AppTextStyles.heading6.copyWith(
        color: AppColors.foreground,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.foreground,
      ),
    );
  }

  static AppBarTheme get _darkAppBarTheme {
    return AppBarTheme(
      elevation: AppDimensions.appBarElevation,
      backgroundColor: AppColors.cardDark,
      foregroundColor: AppColors.foregroundDark,
      titleTextStyle: AppTextStyles.heading6.copyWith(
        color: AppColors.foregroundDark,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.foregroundDark,
      ),
    );
  }

  // Card Themes
  static CardThemeData get _lightCardTheme {
    return CardThemeData(
      color: AppColors.card,
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLG),
        side: BorderSide(
          color: AppColors.border,
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
        foregroundColor: AppColors.primaryForeground,
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
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.destructive),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        borderSide: const BorderSide(color: AppColors.destructive, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.mutedForeground,
      ),
    );
  }

  // Divider Theme
  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    );
  }
}
