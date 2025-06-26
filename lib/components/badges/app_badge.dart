import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/constants.dart';

class AppBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final BadgeVariant variant;

  const AppBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
    this.variant = BadgeVariant.default_,
  });

  const AppBadge.success({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  }) : variant = BadgeVariant.success;

  const AppBadge.destructive({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  }) : variant = BadgeVariant.destructive;

  const AppBadge.outline({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  }) : variant = BadgeVariant.outline;

  const AppBadge.warning({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  }) : variant = BadgeVariant.warning;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color bgColor;
    Color fgColor;
    
    switch (variant) {
      case BadgeVariant.success:
        bgColor = AppColors.success.withOpacity(0.1);
        fgColor = AppColors.success;
        break;
      case BadgeVariant.destructive:
        bgColor = AppColors.error.withOpacity(0.1);
        fgColor = AppColors.error;
        break;
      case BadgeVariant.warning:
        bgColor = AppColors.warning.withOpacity(0.1);
        fgColor = AppColors.warning;
        break;
      case BadgeVariant.outline:
        bgColor = Colors.transparent;
        fgColor = isDark 
            ? AppColors.textPrimaryDark 
            : AppColors.textPrimary;
        break;
      case BadgeVariant.default_:
        bgColor = isDark 
            ? AppColors.mutedDark 
            : AppColors.mutedLight;
        fgColor = isDark 
            ? AppColors.textSecondaryDark 
            : AppColors.textSecondary;
        break;
    }

    return Container(
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM, 
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
        border: variant == BadgeVariant.outline
            ? Border.all(
                color: isDark 
                    ? AppColors.borderDark 
                    : AppColors.borderLight,
              )
            : null,
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor ?? fgColor,
          fontSize: fontSize ?? 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

enum BadgeVariant { 
  default_, 
  success, 
  destructive, 
  outline, 
  warning,
}
