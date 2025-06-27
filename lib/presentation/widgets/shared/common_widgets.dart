import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Reusable statistic display widget
class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return AppCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: EdgeInsets.all(AppDimensions.paddingSM),
                      decoration: BoxDecoration(
                        color: (backgroundColor ?? iconColor ?? AppColors.primary).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? AppColors.primary,
                        size: AppDimensions.iconMD,
                      ),
                    ),
                    SizedBox(width: AppDimensions.paddingSM),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingSM),
              Text(
                value,
                style: AppTextStyles.heading4.copyWith(
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDarkMode ? Colors.white60 : AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable progress indicator widget with labels
class LabeledProgressIndicator extends StatelessWidget {
  final String label;
  final double progress;
  final String? progressText;
  final Color? progressColor;
  final Color? backgroundColor;
  final double height;

  const LabeledProgressIndicator({
    super.key,
    required this.label,
    required this.progress,
    this.progressText,
    this.progressColor,
    this.backgroundColor,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDarkMode ? Colors.white70 : AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (progressText != null)
              Text(
                progressText!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDarkMode ? Colors.white60 : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingXS),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? (isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.1)),
          valueColor: AlwaysStoppedAnimation<Color>(
            progressColor ?? (isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary),
          ),
          minHeight: height,
        ),
      ],
    );
  }
}

/// Reusable info row widget
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;
  final FontWeight? valueFontWeight;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
    this.valueFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconSM,
              color: isDarkMode ? Colors.white60 : AppColors.textSecondary,
            ),
            SizedBox(width: AppDimensions.paddingSM),
          ],
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: valueColor ?? (isDarkMode ? Colors.white : AppColors.textPrimary),
              fontWeight: valueFontWeight ?? FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final IconData? icon;
  final Color? iconColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: iconColor ?? (isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary),
            size: AppDimensions.iconMD,
          ),
          SizedBox(width: AppDimensions.paddingSM),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.heading6.copyWith(
                  color: isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

/// Reusable circular progress widget with center text
class CircularProgressWidget extends StatelessWidget {
  final double progress;
  final String centerText;
  final String? bottomText;
  final Color? progressColor;
  final Color? backgroundColor;
  final double size;
  final double strokeWidth;

  const CircularProgressWidget({
    super.key,
    required this.progress,
    required this.centerText,
    this.bottomText,
    this.progressColor,
    this.backgroundColor,
    this.size = 160.0,
    this.strokeWidth = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              backgroundColor: backgroundColor ?? (isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.1)),
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor ?? (isDarkMode ? const Color(0xFF4ADE80) : AppColors.primary),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                centerText,
                style: AppTextStyles.heading1.copyWith(
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (bottomText != null) ...[
                SizedBox(height: 4.h),
                Text(
                  bottomText!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
