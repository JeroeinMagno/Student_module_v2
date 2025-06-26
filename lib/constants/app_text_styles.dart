import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Typography constants for consistent text styling
class AppTextStyles {
  AppTextStyles._();

  // Base font family
  static TextStyle get _baseTextStyle => GoogleFonts.inter();

  // Headings
  static TextStyle get heading1 => _baseTextStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle get heading2 => _baseTextStyle.copyWith(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static TextStyle get heading3 => _baseTextStyle.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get heading4 => _baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static TextStyle get heading5 => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle get heading6 => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body text
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodySmall => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Labels
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle get labelMedium => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle get labelSmall => _baseTextStyle.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // Captions and overlines
  static TextStyle get caption => _baseTextStyle.copyWith(
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static TextStyle get overline => _baseTextStyle.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 1.5,
  );

  // Button text
  static TextStyle get buttonLarge => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get buttonMedium => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get buttonSmall => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
