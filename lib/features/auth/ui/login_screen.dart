import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../viewmodel/auth_viewmodel.dart';

/// Login screen for user authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _authViewModel.clearError();
      
      await _authViewModel.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (_authViewModel.isAuthenticated && mounted) {
        // Navigate to dashboard on successful login
        context.go('/dashboard');
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first'),
        ),
      );
      return;
    }

    await _authViewModel.forgotPassword(email);
    
    if (mounted && _authViewModel.errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authViewModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;
              final maxWidth = isLandscape 
                  ? constraints.maxWidth * 0.5 
                  : constraints.maxWidth * 0.9;
              
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                    vertical: AppDimensions.paddingMD,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth.clamp(280.w, 400.w),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildLogo(isLandscape),
                          SizedBox(height: isLandscape ? 24.h : 48.h),
                          _buildTitle(isLandscape),
                          SizedBox(height: 8.h),
                          _buildSubtitle(),
                          SizedBox(height: isLandscape ? 24.h : 48.h),
                          _buildEmailField(),
                          SizedBox(height: AppDimensions.paddingMD),
                          _buildPasswordField(),
                          SizedBox(height: AppDimensions.paddingLG),
                          _buildLoginButton(),
                          SizedBox(height: AppDimensions.paddingMD),
                          _buildForgotPasswordButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isLandscape) {
    return SizedBox(
      height: isLandscape ? 80.h : 120.h,
      child: Icon(
        Icons.school,
        size: isLandscape ? 60.sp : 80.sp,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTitle(bool isLandscape) {
    return Text(
      AppStrings.appName,
      style: AppTextStyles.heading2.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: isLandscape ? 24.sp : 28.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Sign in to continue',
      style: AppTextStyles.bodyLarge.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: 16.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailField() {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16.sp),
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email_outlined),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingMD,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onChanged: (_) => authViewModel.clearError(),
        );
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
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                authViewModel.obscurePassword 
                    ? Icons.visibility 
                    : Icons.visibility_off,
              ),
              onPressed: authViewModel.togglePasswordVisibility,
            ),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingMD,
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
          onChanged: (_) => authViewModel.clearError(),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return SizedBox(
          height: 48.h,
          child: AppButton(
            text: 'Sign In',
            onPressed: authViewModel.isLoading ? null : _handleLogin,
            isLoading: authViewModel.isLoading,
          ),
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return Column(
          children: [
            TextButton(
              onPressed: authViewModel.isLoading ? null : _handleForgotPassword,
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            if (authViewModel.errorMessage != null) ...[
              SizedBox(height: AppDimensions.paddingSM),
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingSM),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSM),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Text(
                  authViewModel.errorMessage!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
