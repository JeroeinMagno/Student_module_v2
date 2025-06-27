import '../models/auth_models.dart';
import '../datasources/datasources.dart';
import 'base_repository.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Login with credentials
  Future<RepositoryResult<AuthResponse>> login(String email, String password);
  
  /// Logout current user
  Future<RepositoryResult<void>> logout();
  
  /// Request password reset
  Future<RepositoryResult<void>> forgotPassword(String email);
  
  /// Refresh authentication token
  Future<RepositoryResult<AuthResponse>> refreshToken(String refreshToken);
  
  /// Verify email address
  Future<RepositoryResult<void>> verifyEmail(String token);
  
  /// Change password
  Future<RepositoryResult<void>> changePassword(String currentPassword, String newPassword);
  
  /// Get current user
  User? getCurrentUser();
  
  /// Check if user is authenticated
  bool isAuthenticated();
  
  /// Save user session
  Future<void> saveUserSession(AuthResponse authResponse);
  
  /// Clear user session
  Future<void> clearUserSession();
}

/// Authentication repository implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  User? _currentUser;
  String? _currentToken;
  
  AuthRepositoryImpl(this._authApiService);
  
  @override
  Future<RepositoryResult<AuthResponse>> login(String email, String password) async {
    try {
      final loginRequest = LoginRequest(email: email, password: password);
      final authResponse = await _authApiService.login(loginRequest);
      
      // Save session locally
      await saveUserSession(authResponse);
      
      return RepositoryResult.success(authResponse);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  Future<RepositoryResult<void>> logout() async {
    try {
      await _authApiService.logout();
      await clearUserSession();
      return RepositoryResult.success(null);
    } catch (e) {
      // Clear session even if API call fails
      await clearUserSession();
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  Future<RepositoryResult<void>> forgotPassword(String email) async {
    try {
      await _authApiService.forgotPassword(email);
      return RepositoryResult.success(null);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  Future<RepositoryResult<AuthResponse>> refreshToken(String refreshToken) async {
    try {
      final authResponse = await _authApiService.refreshToken(refreshToken);
      
      // Update session with new token
      await saveUserSession(authResponse);
      
      return RepositoryResult.success(authResponse);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  Future<RepositoryResult<void>> verifyEmail(String token) async {
    try {
      await _authApiService.verifyEmail(token);
      return RepositoryResult.success(null);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  Future<RepositoryResult<void>> changePassword(String currentPassword, String newPassword) async {
    try {
      await _authApiService.changePassword(currentPassword, newPassword);
      return RepositoryResult.success(null);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }
  
  @override
  User? getCurrentUser() => _currentUser;
  
  @override
  bool isAuthenticated() => _currentUser != null && _currentToken != null;
  
  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    _currentUser = authResponse.user;
    _currentToken = authResponse.effectiveToken;
    // Secure storage implementation will be added when backend is integrated
  }
  
  @override
  Future<void> clearUserSession() async {
    _currentUser = null;
    _currentToken = null;
    // Secure storage cleanup will be added when backend is integrated
  }
}

/// Mock authentication repository for development
class MockAuthRepository implements AuthRepository {
  User? _currentUser;
  bool _isAuthenticated = false;
  
  @override
  Future<RepositoryResult<AuthResponse>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock validation
    if (email.contains('@') && password.length >= 6) {
      final user = User(
        id: 'user_123',
        email: email,
        name: 'John Doe',
        studentId: '2021-12345',
        lastLogin: DateTime.now(),
      );
      
      final authResponse = AuthResponse(
        user: user,
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );
      
      await saveUserSession(authResponse);
      
      return RepositoryResult.success(authResponse);
    } else {
      return RepositoryResult.failure('Invalid email or password');
    }
  }
  
  @override
  Future<RepositoryResult<void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await clearUserSession();
    return RepositoryResult.success(null);
  }
  
  @override
  Future<RepositoryResult<void>> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!email.contains('@')) {
      return RepositoryResult.failure('Invalid email address');
    }
    
    return RepositoryResult.success(null);
  }
  
  @override
  Future<RepositoryResult<AuthResponse>> refreshToken(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser != null) {
      final authResponse = AuthResponse(
        user: _currentUser,
        token: 'refreshed_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );
      
      await saveUserSession(authResponse);
      return RepositoryResult.success(authResponse);
    }
    
    return RepositoryResult.failure('No user session found');
  }
  
  @override
  Future<RepositoryResult<void>> verifyEmail(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RepositoryResult.success(null);
  }
  
  @override
  Future<RepositoryResult<void>> changePassword(String currentPassword, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (currentPassword.length < 6 || newPassword.length < 6) {
      return RepositoryResult.failure('Password must be at least 6 characters');
    }
    
    return RepositoryResult.success(null);
  }
  
  @override
  User? getCurrentUser() => _currentUser;
  
  @override
  bool isAuthenticated() => _isAuthenticated && _currentUser != null;
  
  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    _currentUser = authResponse.user;
    _isAuthenticated = true;
  }
  
  @override
  Future<void> clearUserSession() async {
    _currentUser = null;
    _isAuthenticated = false;
  }
}
