import 'package:flutter/foundation.dart';
import '../../../services/api/api_services.dart';
import '../../../core/service_locator.dart';
import '../model/auth_model.dart';

/// ViewModel for handling authentication logic
class AuthViewModel extends ChangeNotifier {
  final AuthApiService _authApiService = serviceLocator<AuthApiService>();
  
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;
  bool _obscurePassword = true;

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated && _user != null;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Clear any existing error messages
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Attempt to login with email and password
  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _setError('Please enter both email and password');
      return;
    }

    if (!_isValidEmail(email)) {
      _setError('Please enter a valid email address');
      return;
    }

    if (password.length < 6) {
      _setError('Password must be at least 6 characters');
      return;
    }

    _setStatus(AuthStatus.loading);
    
    try {
      final loginRequest = LoginRequest(email: email.trim(), password: password);
      final authResponse = await _authApiService.login(loginRequest);
      
      _user = authResponse.user;
      _setStatus(AuthStatus.authenticated);
      
      // Save authentication state if needed
      await _saveAuthState(authResponse);
      
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setStatus(AuthStatus.error);
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    _setStatus(AuthStatus.loading);
    
    try {
      await _authApiService.logout();
      await _clearAuthState();
      
      _user = null;
      _setStatus(AuthStatus.unauthenticated);
      
    } catch (e) {
      // Even if logout fails on server, clear local state
      _user = null;
      _setStatus(AuthStatus.unauthenticated);
      await _clearAuthState();
    }
  }

  /// Check if user is already authenticated (e.g., from saved state)
  Future<void> checkAuthState() async {
    _setStatus(AuthStatus.loading);
    
    try {
      final savedAuth = await _loadAuthState();
      
      if (savedAuth != null && _isTokenValid(savedAuth)) {
        _user = savedAuth.user;
        _setStatus(AuthStatus.authenticated);
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
      
    } catch (e) {
      _setStatus(AuthStatus.unauthenticated);
    }
  }

  /// Forgot password functionality
  Future<void> forgotPassword(String email) async {
    if (email.trim().isEmpty) {
      _setError('Please enter your email address');
      return;
    }

    if (!_isValidEmail(email)) {
      _setError('Please enter a valid email address');
      return;
    }

    _setStatus(AuthStatus.loading);
    
    try {
      await _authApiService.forgotPassword(email.trim());
      _setStatus(AuthStatus.initial);
      // Show success message through UI
      
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setStatus(AuthStatus.error);
    }
  }

  // Private helper methods
  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  String _getErrorMessage(dynamic error) {
    if (error is String) return error;
    
    // Handle different types of API errors
    if (error.toString().contains('network')) {
      return 'Network error. Please check your connection.';
    } else if (error.toString().contains('unauthorized')) {
      return 'Invalid email or password.';
    } else if (error.toString().contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    
    return 'An unexpected error occurred. Please try again.';
  }

  Future<void> _saveAuthState(AuthResponse authResponse) async {
    // TODO: Implement secure storage for auth state
    // For now, this is a placeholder for saving to secure storage
  }

  Future<AuthResponse?> _loadAuthState() async {
    // TODO: Implement loading from secure storage
    // For now, return null (no saved state)
    return null;
  }

  Future<void> _clearAuthState() async {
    // TODO: Implement clearing secure storage
    // For now, this is a placeholder
  }

  bool _isTokenValid(AuthResponse authResponse) {
    if (authResponse.expiresAt == null) return true;
    return DateTime.now().isBefore(authResponse.expiresAt!);
  }
}
