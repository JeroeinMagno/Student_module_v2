import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../../../constants/constants.dart';

/// Login screen for user authentication - matches web design
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthViewModel _authViewModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      _authViewModel.clearError();
      
      await _authViewModel.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (_authViewModel.isAuthenticated && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful! Redirecting to dashboard...'),
            backgroundColor: AppColors.success,
          ),
        );
        
        // Navigate to dashboard on successful login
        context.go('/dashboard');
      } else if (_authViewModel.errorMessage != null && mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_authViewModel.errorMessage!),
            backgroundColor: AppColors.destructive,
          ),
        );
      }
    }
  }

  void _handleForgotPassword() {
    // Handle forgot password logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forgot password feature will be implemented soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authViewModel,
      child: Scaffold(
        backgroundColor: AppColors.getBackground(context),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.w),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: AppColors.getCard(context),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.getForeground(context).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLogo(),
                      SizedBox(height: 32.h),
                      _buildWelcomeText(),
                      SizedBox(height: 8.h),
                      _buildSubtitle(),
                      SizedBox(height: 32.h),
                      _buildUsernameField(),
                      SizedBox(height: 16.h),
                      _buildPasswordField(),
                      SizedBox(height: 8.h),
                      _buildForgotPasswordLink(),
                      SizedBox(height: 24.h),
                      _buildCaptchaPlaceholder(),
                      SizedBox(height: 24.h),
                      _buildSignInButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.getCard(context),
        border: Border.all(color: AppColors.destructive.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.destructive.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: SvgPicture.asset(
          'assets/icons/bsulogo.svg',
          width: 56.w,
          height: 56.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Welcome Back',
      style: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.destructive,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Sign in to your account to continue',
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.getMutedForeground(context),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
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

  Widget _buildPasswordField() {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return TextFormField(
          controller: _passwordController,
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

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _handleForgotPassword,
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

  Widget _buildCaptchaPlaceholder() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.getMuted(context),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.getBorder(context)),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "I'm not a robot",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.getForeground(context),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.refresh,
            size: 20.sp,
            color: AppColors.getMutedForeground(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: AppColors.successForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.successForeground),
                ),
              )
            : Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
