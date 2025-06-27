import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final bool isSelected;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonSize = size ?? AppDimensions.iconXL;
    
    final effectiveBackgroundColor = backgroundColor ?? 
        (isSelected 
            ? AppColors.primary.withOpacity(0.1)
            : (isDark ? AppColors.cardDark : AppColors.card));
    
    final effectiveIconColor = iconColor ?? 
        (isSelected 
            ? AppColors.primary
            : (isDark ? AppColors.foregroundDark : AppColors.foreground));
    
    final button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMD),
        border: isSelected 
            ? Border.all(color: AppColors.primary, width: 1)
            : Border.all(
                color: isDark 
                    ? AppColors.borderDark 
                    : AppColors.border,
                width: 1,
              ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: effectiveIconColor,
        splashRadius: buttonSize / 2,
        padding: EdgeInsets.zero,
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
