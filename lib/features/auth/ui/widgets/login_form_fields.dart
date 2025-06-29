import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../viewmodel/auth_viewmodel.dart';

/// Form fields for username and password
class LoginFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginFormFields({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUsernameField(context),
        SizedBox(height: 16.h),
        _buildPasswordField(context),
      ],
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.getForeground(context),
      ),
      decoration: InputDecoration(
        hintText: 'Enter your username',
        hintStyle: TextStyle(
          color: AppColors.getMutedForeground(context),
          fontSize: 16.sp,
        ),
        prefixIcon: Icon(
          Icons.person_outline,
          size: 20.sp,
          color: AppColors.getMutedForeground(context),
        ),
        filled: true,
        fillColor: AppColors.getMuted(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.getBorder(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.getBorder(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.destructive, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return TextFormField(
          controller: passwordController,
          obscureText: authViewModel.obscurePassword,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.getForeground(context),
          ),
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(
              color: AppColors.getMutedForeground(context),
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 20.sp,
              color: AppColors.getMutedForeground(context),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                authViewModel.obscurePassword 
                    ? Icons.visibility_off 
                    : Icons.visibility,
                size: 20.sp,
                color: AppColors.getMutedForeground(context),
              ),
              onPressed: authViewModel.togglePasswordVisibility,
            ),
            filled: true,
            fillColor: AppColors.getMuted(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.getBorder(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.getBorder(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.destructive, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        );
      },
    );
  }
}
