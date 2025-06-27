import 'package:flutter/material.dart';
import '../../constants/constants.dart';

/// Custom card component with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.onTap,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final cardColor = backgroundColor ?? 
        (isDark ? AppColors.cardDark : AppColors.card);
    
    final cardBorder = border ?? Border.all(
      color: isDark ? AppColors.borderDark : AppColors.border,
      width: AppDimensions.cardBorderWidth,
    );

    Widget cardWidget = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: borderRadius ?? 
            BorderRadius.circular(AppDimensions.borderRadiusLG),
        border: cardBorder,
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
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppDimensions.paddingMD),
        child: child,
      ),
    );

    if (onTap != null) {
      cardWidget = InkWell(
        onTap: onTap,
        borderRadius: (borderRadius as BorderRadius?) ?? 
            BorderRadius.circular(AppDimensions.borderRadiusLG),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
