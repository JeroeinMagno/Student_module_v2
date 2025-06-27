import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../features/auth/viewmodel/auth_viewmodel.dart';

/// Login form fields widget containing username and password fields
class LoginFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback? onForgotPassword;

  const LoginFormFields({
    super.key,
    required this.usernameController,
    required this.passwordController,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUsernameField(),
        SizedBox(height: 16.h),
        _buildPasswordField(),
        SizedBox(height: 8.h),
        _buildForgotPasswordLink(),
      ],
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: usernameController,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Enter your username',
        prefixIcon: Icon(
          Icons.person_outline,
          size: 20.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red, width: 2),
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

  Widget _buildPasswordField() {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return TextFormField(
          controller: passwordController,
          obscureText: authViewModel.obscurePassword,
          style: TextStyle(fontSize: 16.sp),
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: Icon(
              Icons.lock_outline,
              size: 20.sp,
              color: Colors.grey[600],
            ),
            suffixIcon: IconButton(
              icon: Icon(
                authViewModel.obscurePassword 
                    ? Icons.visibility 
                    : Icons.visibility_off,
                size: 20.sp,
                color: Colors.grey[600],
              ),
              onPressed: authViewModel.togglePasswordVisibility,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red, width: 2),
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

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onForgotPassword,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
