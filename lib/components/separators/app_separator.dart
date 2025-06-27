import 'package:flutter/material.dart';
import '../../constants/constants.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final separatorColor = color ?? 
        (isDark ? AppColors.borderDark : AppColors.border);

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
