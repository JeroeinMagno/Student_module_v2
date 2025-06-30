import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';

/// Toggle component for switching between Completed and In Progress assessments
class AssessmentStatusToggle extends StatelessWidget {
  final bool isCompleted;
  final Function(bool) onToggle;

  const AssessmentStatusToggle({
    Key? key,
    required this.isCompleted,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildToggleButton(
          text: 'Completed',
          isSelected: isCompleted,
          onTap: () => onToggle(true),
          isLeft: true,
          isDarkMode: isDarkMode,
        ),
        _buildToggleButton(
          text: 'In Progress',
          isSelected: !isCompleted,
          onTap: () => onToggle(false),
          isLeft: false,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isLeft,
    required bool isDarkMode,
  }) {
    final backgroundColor = isSelected 
        ? (isDarkMode ? AppColors.accentDark : AppColors.accent)
        : Colors.transparent;
        
    final borderColor = isDarkMode 
        ? AppColors.borderDark 
        : AppColors.border;
        
    final textColor = isSelected 
        ? (isDarkMode ? AppColors.foregroundDark : AppColors.foreground)
        : (isDarkMode ? AppColors.mutedForegroundDark : AppColors.mutedForeground);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: isLeft 
            ? BorderRadius.only(
                topLeft: Radius.circular(6.r),
                bottomLeft: Radius.circular(6.r),
              )
            : BorderRadius.only(
                topRight: Radius.circular(6.r),
                bottomRight: Radius.circular(6.r),
              ),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.labelMedium.copyWith(
            color: textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
