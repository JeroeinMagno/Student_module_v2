import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final Color? backgroundColor;
  final Border? border;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.elevation,
    this.backgroundColor,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? AppTheme.cardDark : AppTheme.cardLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Container(
        padding: padding ?? EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: backgroundColor ?? defaultColor,
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          border: border ?? Border.all(color: borderColor, width: 1),
          boxShadow: elevation != null && elevation! > 0
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: elevation!,
                    offset: Offset(0, elevation! / 2),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    Color bgColor;
    Color fgColor;
    
    switch (variant) {
      case BadgeVariant.success:
        bgColor = AppTheme.success.withOpacity(0.1);
        fgColor = AppTheme.success;
        break;
      case BadgeVariant.destructive:
        bgColor = AppTheme.destructive.withOpacity(0.1);
        fgColor = AppTheme.destructive;
        break;      case BadgeVariant.outline:
        bgColor = Colors.transparent;
        fgColor = theme.colorScheme.onSurface;
        break;
      case BadgeVariant.default_:
        bgColor = isDark ? AppTheme.mutedDark : AppTheme.mutedLight;
        fgColor = theme.colorScheme.onSurface;
        break;
    }

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
        border: variant == BadgeVariant.outline
            ? Border.all(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
              )
            : null,
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor ?? fgColor,
          fontSize: fontSize ?? 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

enum BadgeVariant { default_, success, destructive, outline }

class AppProgress extends StatelessWidget {
  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final double? height;
  final bool showPercentage;

  const AppProgress({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.height,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height ?? 8.h,
          decoration: BoxDecoration(
            color: backgroundColor ?? 
                (isDark ? AppTheme.mutedDark : AppTheme.mutedLight),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: valueColor ?? AppTheme.primaryGreen,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
              ),
            ),
          ),
        ),
        if (showPercentage) ...[
          SizedBox(height: 4.h),
          Text(
            '${(value * 100).round()}%',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = ButtonVariant.outline;

  const AppButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = ButtonVariant.ghost;

  const AppButton.destructive({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = ButtonVariant.destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Size configuration
    late final EdgeInsetsGeometry padding;
    late final double fontSize;
    late final double height;
    
    switch (size) {
      case ButtonSize.small:
        padding = EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h);
        fontSize = 12.sp;
        height = 32.h;
        break;
      case ButtonSize.medium:
        padding = EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
        fontSize = 14.sp;
        height = 40.h;
        break;
      case ButtonSize.large:
        padding = EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h);
        fontSize = 16.sp;
        height = 48.h;
        break;
    }

    // Variant configuration
    late final Color backgroundColor;
    late final Color foregroundColor;
    late final Color? borderColor;
    
    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = AppTheme.primaryGreen;
        foregroundColor = Colors.white;
        borderColor = null;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        borderColor = null;
        break;
      case ButtonVariant.destructive:
        backgroundColor = AppTheme.destructive;
        foregroundColor = Colors.white;
        borderColor = null;
        break;
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),            side: borderColor != null 
                ? BorderSide(color: borderColor) 
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 16.w,
                height: 16.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

enum ButtonVariant { primary, outline, ghost, destructive }
enum ButtonSize { small, medium, large }

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final buttonSize = size ?? 40.w;
    
    final button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? 
            (isDark ? AppTheme.mutedDark : AppTheme.mutedLight),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconColor ?? theme.colorScheme.onSurface,
        splashRadius: buttonSize / 2,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

class AppSeparator extends StatelessWidget {
  final Axis direction;
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;

  const AppSeparator({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  });

  const AppSeparator.vertical({
    super.key,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  }) : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final separatorColor = color ?? 
        (isDark ? AppTheme.borderDark : AppTheme.borderLight);

    if (direction == Axis.vertical) {
      return VerticalDivider(
        thickness: thickness ?? 1,
        color: separatorColor,
        indent: indent,
        endIndent: endIndent,
      );
    }

    return Divider(
      thickness: thickness ?? 1,
      color: separatorColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
