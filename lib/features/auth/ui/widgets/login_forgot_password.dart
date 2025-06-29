import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';

/// Forgot password link widget
class LoginForgotPassword extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginForgotPassword({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.success,
          ),
        ),
      ),
    );
  }
}
