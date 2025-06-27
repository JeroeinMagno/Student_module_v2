import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/viewmodel/auth_viewmodel.dart';
import '../widgets/login/login_widgets.dart';

/// Refactored login screen with improved widget separation
class LoginScreenRefactored extends StatefulWidget {
  const LoginScreenRefactored({super.key});

  @override
  State<LoginScreenRefactored> createState() => _LoginScreenRefactoredState();
}

class _LoginScreenRefactoredState extends State<LoginScreenRefactored> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  late AuthViewModel _authViewModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authViewModel = context.read<AuthViewModel>();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle user login
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authViewModel.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (_authViewModel.isAuthenticated) {
          _showSuccessMessage();
          context.go('/dashboard');
        } else if (_authViewModel.errorMessage != null) {
          _showErrorMessage(_authViewModel.errorMessage!);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorMessage(e.toString());
      }
    }
  }

  /// Handle forgot password action
  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forgot password feature will be implemented soon'),
      ),
    );
  }

  /// Show success message
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful! Redirecting to dashboard...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Show error message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
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
              child: _buildLoginCard(),
            ),
          ),
        ),
      ),
    );
  }

  /// Build the main login card
  Widget _buildLoginCard() {
    return Container(
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
            const LoginLogo(),
            SizedBox(height: 32.h),
            const LoginWelcomeText(),
            SizedBox(height: 32.h),
            LoginFormFields(
              usernameController: _usernameController,
              passwordController: _passwordController,
              onForgotPassword: _handleForgotPassword,
            ),
            SizedBox(height: 24.h),
            const LoginCaptchaPlaceholder(),
            SizedBox(height: 24.h),
            LoginSignInButton(
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
