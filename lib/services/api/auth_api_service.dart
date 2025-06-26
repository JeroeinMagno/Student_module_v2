import '../../../features/auth/model/auth_model.dart';
import 'base_api_service.dart';

/// Authentication API service interface
abstract class AuthApiService extends BaseApiService {
  /// Login with email and password
  Future<AuthResponse> login(LoginRequest request);
  
  /// Logout current user
  Future<void> logout();
  
  /// Request password reset
  Future<void> forgotPassword(String email);
  
  /// Refresh authentication token
  Future<AuthResponse> refreshToken(String refreshToken);
  
  /// Verify email address
  Future<void> verifyEmail(String token);
  
  /// Change password
  Future<void> changePassword(String currentPassword, String newPassword);
}
