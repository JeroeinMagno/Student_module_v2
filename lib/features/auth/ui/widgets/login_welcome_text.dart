import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';

/// Welcome text header for the login screen
class LoginWelcomeText extends StatelessWidget {
  const LoginWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.destructive,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Sign in to your account to continue',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.getMutedForeground(context),
          ),
        ),
      ],
    );
  }
}
