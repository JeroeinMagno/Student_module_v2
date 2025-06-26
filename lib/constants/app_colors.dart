import 'package:flutter/material.dart';

/// App Colors - Consistent color palette for the entire application
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4ADE80);
  static const Color primaryDark = Color(0xFF22C55E);
  static const Color primaryLight = Color(0xFF86EFAC);

  // Secondary Colors
  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryDark = Color(0xFF475569);
  static const Color secondaryLight = Color(0xFF94A3B8);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1A2C3E);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);

  // Border Colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Yellow
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFF84CC16), // Lime
  ];

  // Muted Colors
  static const Color mutedLight = Color(0xFFF1F5F9);
  static const Color mutedDark = Color(0xFF0F172A);

  // Opacity variants
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color backgroundWithOpacity(double opacity) => backgroundLight.withOpacity(opacity);
}
