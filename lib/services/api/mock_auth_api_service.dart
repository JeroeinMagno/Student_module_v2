import '../../../features/auth/model/auth_model.dart';
import 'auth_api_service.dart';

/// Mock implementation of AuthApiService for development
class MockAuthApiService implements AuthApiService {
  static const Duration _mockDelay = Duration(seconds: 1);
  
  @override
  String get baseUrl => 'http://localhost:3000/api';
  
  @override
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
  };
  
  @override
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params}) async {
    throw UnimplementedError('GET not implemented in mock service');
  }
  
  @override
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data}) async {
    throw UnimplementedError('POST not implemented in mock service');
  }
  
  @override
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data}) async {
    throw UnimplementedError('PUT not implemented in mock service');
  }
  
  @override
  Future<T> delete<T>(String endpoint) async {
    throw UnimplementedError('DELETE not implemented in mock service');
  }
  
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
