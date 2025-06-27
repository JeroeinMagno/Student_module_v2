import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/constants.dart';

class AppProgress extends StatelessWidget {
  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final double? height;
  final bool showPercentage;
  final bool showLabel;
  final String? label;

  const AppProgress({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.height,
    this.showPercentage = false,
    this.showLabel = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && label != null) ...[
          Text(
            label!,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark 
                  ? AppColors.textSecondaryDark 
                  : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingXS),
        ],
        Container(
          height: height ?? 8.h,
          decoration: BoxDecoration(
            color: backgroundColor ?? 
                (isDark ? AppColors.mutedDark : AppColors.muted),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: valueColor ?? AppColors.primary,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
              ),
            ),
          ),
        ),
        if (showPercentage) ...[
          SizedBox(height: AppDimensions.paddingXS),
          Text(
            '${(value * 100).round()}%',
            style: AppTextStyles.caption.copyWith(
              color: isDark 
                  ? AppColors.textSecondaryDark 
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

class AppProgressRing extends StatelessWidget {
  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final double size;
  final double strokeWidth;
  final Widget? child;

  const AppProgressRing({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.size = 48,
    this.strokeWidth = 4,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      width: size.w,
      height: size.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor ?? 
                (isDark ? AppColors.mutedDark : AppColors.muted),
            valueColor: AlwaysStoppedAnimation<Color>(
              valueColor ?? AppColors.primary,
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
