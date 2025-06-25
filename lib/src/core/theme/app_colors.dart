import 'package:flutter/material.dart';

/// App color scheme based on the provided CSS color variables
class AppColors {
  // Primary colors (green)
  static const Color primaryLight = Color(0xFF4ADE80); // oklch(0.6846 0.1721 146.32)
  static const Color primaryDark = Color(0xFF4ADE80); // oklch(0.74 0.2133 146.87)
  static const Color primaryForegroundLight = Color(0xFFFAFAFA); // oklch(0.985 0.002 247.839)
  static const Color primaryForegroundDark = Color(0xFF1A2C3E); // oklch(0.21 0.034 264.665)

  // Secondary colors (red)
  static const Color secondary = Color(0xFFEF4444); // oklch(0.627 0.257 29.23)
  static const Color secondaryForegroundLight = Color(0xFF1A2C3E); // oklch(0.21 0.034 264.665)
  static const Color secondaryForegroundDark = Color(0xFFFAFAFA); // oklch(0.985 0.002 247.839)

  // Background colors
  static const Color backgroundLight = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color backgroundDark = Color(0xFF1A2C3E); // oklch(0.13 0.028 261.692)
  
  // Foreground colors
  static const Color foregroundLight = Color(0xFF1A2C3E); // oklch(0.13 0.028 261.692)
  static const Color foregroundDark = Color(0xFFFAFAFA); // oklch(0.985 0.002 247.839)

  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color cardDark = Color(0xFF1A2C3E); // oklch(0.21 0.034 264.665)
  static const Color cardForegroundLight = Color(0xFF1A2C3E); // oklch(0.13 0.028 261.692)
  static const Color cardForegroundDark = Color(0xFFFAFAFA); // oklch(0.985 0.002 247.839)

  // Muted colors
  static const Color mutedLight = Color(0xFFF5F5F5); // oklch(0.967 0.003 264.542)
  static const Color mutedDark = Color(0xFF374151); // oklch(0.278 0.033 256.848)
  static const Color mutedForegroundLight = Color(0xFF6B7280); // oklch(0.551 0.027 264.364)
  static const Color mutedForegroundDark = Color(0xFF9CA3AF); // oklch(0.707 0.022 261.325)

  // Border colors
  static const Color borderLight = Color(0xFFE5E7EB); // oklch(0.928 0.006 264.531)
  static const Color borderDark = Color(0x1AFFFFFF); // oklch(1 0 0 / 10%)

  // Chart colors
  static const Color chartRed = Color(0xFFEF4444); // oklch(0.5574 0.2076 25.8)
  static const Color chartOrange = Color(0xFFF97316); // oklch(0.6609 0.1954 37.35)
  static const Color chartYellow = Color(0xFFEAB308); // oklch(0.807 0.1611 75.53)
  static const Color chartBlue = Color(0xFF3B82F6); // oklch(0.5271 0.1275 243.04)
  static const Color chartCorrect = Color(0xFF10B981); // oklch(0.648 0.1759 147.86)
  static const Color chartMistakes = Color(0xFFEF4444); // oklch(0.5574 0.2076 25.8)

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Destructive colors
  static const Color destructiveLight = Color(0xFFDC2626); // oklch(0.577 0.245 27.325)
  static const Color destructiveDark = Color(0xFFF87171); // oklch(0.704 0.191 22.216)

  // Surface colors for elevated components
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF111827);

  // Text colors with opacity
  static Color textPrimaryLight = foregroundLight;
  static Color textPrimaryDark = foregroundDark;
  static Color textSecondaryLight = foregroundLight.withOpacity(0.7);
  static Color textSecondaryDark = foregroundDark.withOpacity(0.7);
  static Color textTertiaryLight = foregroundLight.withOpacity(0.5);
  static Color textTertiaryDark = foregroundDark.withOpacity(0.5);
}
