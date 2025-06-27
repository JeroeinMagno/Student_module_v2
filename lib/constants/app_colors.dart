import 'package:flutter/material.dart';

/// App Colors - Modern color palette based on design system
class AppColors {
  AppColors._();

  // Light Theme Colors
  static const Color background = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color foreground = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color card = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color cardForeground = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color popover = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color popoverForeground = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color primary = Color(0xFF22C55E); // oklch(0.6846 0.1721 146.32)
  static const Color primaryForeground = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color secondary = Color(0xFFEA580C); // oklch(0.627 0.257 29.23)
  static const Color secondaryForeground = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color muted = Color(0xFFF7F8F9); // oklch(0.967 0.003 264.542)
  static const Color mutedForeground = Color(0xFF6B7280); // oklch(0.551 0.027 264.364)
  static const Color accent = Color(0xFFF7F8F9); // oklch(0.967 0.003 264.542)
  static const Color accentForeground = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color destructive = Color(0xFFDC2626); // oklch(0.577 0.245 27.325)
  static const Color destructiveForeground = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color success = Color(0xFF16A34A); // oklch(0.648 0.1759 147.86)
  static const Color successForeground = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color warning = Color(0xFFF59E0B); // oklch(0.807 0.1611 75.53)
  static const Color warningForeground = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color info = Color(0xFF3B82F6); // oklch(0.5271 0.1275 243.04)
  static const Color infoForeground = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color border = Color(0xFFE5E7EB); // oklch(0.928 0.006 264.531)
  static const Color input = Color(0xFFE5E7EB); // oklch(0.928 0.006 264.531)
  static const Color ring = Color(0xFF9CA3AF); // oklch(0.707 0.022 261.325)

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color foregroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color cardDark = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color cardForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color popoverDark = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color popoverForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color primaryDark = Color(0xFF34D399); // oklch(0.74 0.2133 146.87)
  static const Color primaryForegroundDark = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color secondaryDark = Color(0xFFEA580C); // oklch(0.627 0.257 29.23)
  static const Color secondaryForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color mutedDark = Color(0xFF374151); // oklch(0.278 0.033 256.848)
  static const Color mutedForegroundDark = Color(0xFF9CA3AF); // oklch(0.707 0.022 261.325)
  static const Color accentDark = Color(0xFF374151); // oklch(0.278 0.033 256.848)
  static const Color accentForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color destructiveDark = Color(0xFFDC2626); // oklch(0.5574 0.2076 25.8)
  static const Color destructiveForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color successDark = Color(0xFF34D399); // oklch(0.74 0.2133 146.87)
  static const Color successForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color warningDark = Color(0xFFF59E0B); // oklch(0.807 0.1611 75.53)
  static const Color warningForegroundDark = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color infoDark = Color(0xFF3B82F6); // oklch(0.5271 0.1275 243.04)
  static const Color infoForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color borderDark = Color(0x1AFFFFFF); // oklch(1 0 0 / 10%)
  static const Color inputDark = Color(0x26FFFFFF); // oklch(1 0 0 / 15%)
  static const Color ringDark = Color(0xFF6B7280); // oklch(0.551 0.027 264.364)

  // Chart Colors
  static const Color chart1 = Color(0xFFDC2626); // oklch(0.5574 0.2076 25.8)
  static const Color chart2 = Color(0xFFEA580C); // oklch(0.6609 0.1954 37.35)
  static const Color chart3 = Color(0xFFF59E0B); // oklch(0.807 0.1611 75.53)
  static const Color chart4 = Color(0xFF3B82F6); // oklch(0.5271 0.1275 243.04)
  static const Color chartCorrect = Color(0xFF16A34A); // oklch(0.648 0.1759 147.86)
  static const Color chartMistakes = Color(0xFFDC2626); // oklch(0.5574 0.2076 25.8)
  static const Color chartCorrectDark = Color(0xFF34D399); // oklch(0.74 0.2133 146.87)
  static const Color chartMistakesDark = Color(0xFFDC2626); // oklch(0.5574 0.2076 25.8)

  // Sidebar Colors
  static const Color sidebar = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color sidebarForeground = Color(0xFF1A1B23); // oklch(0.13 0.028 261.692)
  static const Color sidebarPrimary = Color(0xFFEA580C); // oklch(0.627 0.257 29.23)
  static const Color sidebarPrimaryForeground = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color sidebarAccent = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color sidebarAccentForeground = Color(0xFFDC2626); // oklch(0.5574 0.2076 25.8)
  static const Color sidebarActiveText = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color sidebarBorder = Color(0xFFE5E7EB); // oklch(0.928 0.006 264.531)
  static const Color sidebarRing = Color(0xFF9CA3AF); // oklch(0.707 0.022 261.325)

  // Sidebar Dark Colors
  static const Color sidebarDark = Color(0xFF1E1F26); // oklch(0.21 0.034 264.665)
  static const Color sidebarForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color sidebarPrimaryDark = Color(0xFFEA580C); // oklch(0.627 0.257 29.23)
  static const Color sidebarPrimaryForegroundDark = Color(0xFFFCFDFE); // oklch(0.985 0.002 247.839)
  static const Color sidebarAccentDark = Color(0xFF374151); // oklch(0.278 0.033 256.848)
  static const Color sidebarAccentForegroundDark = Color(0xFFDC2626); // oklch(0.6341 0.2106 22.76)
  static const Color sidebarActiveTextDark = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const Color sidebarBorderDark = Color(0x1AFFFFFF); // oklch(1 0 0 / 10%)
  static const Color sidebarRingDark = Color(0xFF6B7280); // oklch(0.551 0.027 264.364)

  // Legacy color mappings for backward compatibility
  static const Color textPrimary = foreground;
  static const Color textSecondary = mutedForeground;
  static const Color textPrimaryDark = foregroundDark;
  static const Color textSecondaryDark = mutedForegroundDark;
  static const Color surfaceLight = card;
  static const Color surfaceDark = cardDark;
  static const Color backgroundLight = background;
  static const Color borderLight = border;
  static const Color mutedLight = muted;
  static const Color error = destructive;

  // Chart color list for compatibility
  static const List<Color> chartColors = [
    chart4, // Blue
    success, // Green
    warning, // Yellow
    chart1, // Red
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFF84CC16), // Lime
  ];

  // Utility methods
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color backgroundWithOpacity(double opacity) => background.withOpacity(opacity);
  
  // Theme-aware color getters
  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? backgroundDark : background;
  }
  
  static Color getForeground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? foregroundDark : foreground;
  }
  
  static Color getCard(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? cardDark : card;
  }
  
  static Color getPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? primaryDark : primary;
  }
  
  static Color getSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? secondaryDark : secondary;
  }
  
  static Color getMuted(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? mutedDark : muted;
  }
  
  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? borderDark : border;
  }
  
  static Color getSidebar(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? sidebarDark : sidebar;
  }
  
  static Color getMutedForeground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? mutedForegroundDark : mutedForeground;
  }
}
