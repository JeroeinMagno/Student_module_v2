import '../models/auth_models.dart';
import 'auth_datasource.dart';

/// Mock implementation of AuthApiService for development
class MockAuthApiService implements AuthApiService {
  static const Duration _mockDelay = Duration(seconds: 1);
  
  // Mock user data
  static const _mockUser = User(
    id: 'student_123',
    email: 'student@university.edu',
    name: 'John Doe',
    studentId: '2021-12345',
  );

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    await Future.delayed(_mockDelay);
    
    // Mock validation - accept any email with password length >= 6
    if (request.email.contains('@') && request.password.length >= 6) {
      return AuthResponse(
        user: _mockUser.copyWith(email: request.email),
        token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );
    } else {
      throw 'Invalid email or password';
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(_mockDelay);
    // Mock logout - always succeeds
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(_mockDelay);
    
    if (!email.contains('@')) {
      throw 'Invalid email address';
    }
    
    // Mock success - in real implementation would send reset email
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    await Future.delayed(_mockDelay);
    
    // Mock token refresh
    return AuthResponse(
      user: _mockUser,
      token: 'refreshed_mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
  }

  @override
  Future<void> verifyEmail(String token) async {
    await Future.delayed(_mockDelay);
    // Mock email verification - always succeeds
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await Future.delayed(_mockDelay);
    
    if (currentPassword.length < 6 || newPassword.length < 6) {
      throw 'Password must be at least 6 characters';
    }
    
    // Mock password change - always succeeds if validation passes
  }
}
