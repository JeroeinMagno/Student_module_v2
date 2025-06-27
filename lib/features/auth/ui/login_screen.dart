import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/auth_viewmodel.dart';

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
          const SnackBar(
            content: Text('Login successful! Redirecting to dashboard...'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate to dashboard on successful login
        context.go('/dashboard');
      } else if (_authViewModel.errorMessage != null && mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_authViewModel.errorMessage!),
            backgroundColor: Colors.red,
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
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.w),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
        color: Colors.white,
        border: Border.all(color: Colors.red.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
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
        color: Colors.red,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Sign in to your account to continue',
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
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
          controller: _passwordController,
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
        onPressed: _handleForgotPassword,
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.green,
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
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "I'm not a robot",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.refresh,
            size: 20.sp,
            color: Colors.grey[600],
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
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
