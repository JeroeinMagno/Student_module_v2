import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import 'base_datasource.dart';

/// Authentication API service interface
abstract class AuthApiService {
  /// Login with username and password
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

/// Concrete implementation of AuthApiService using Dio
class AuthApiServiceImpl implements AuthApiService {
  static const String _baseUrl = 'http://192.168.21.33:8000/api/v1';
  
  late final Dio _dio;
  
  AuthApiServiceImpl() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ));
    
    // Add interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      // Format as OAuth2 form data
      final formData = {
        'username': request.email, // Using email as username
        'password': request.password,
      };

      final response = await _dio.post(
        '/auth/login',
        data: formData,
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw ApiException('Login failed: ${response.statusCode} ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw ApiException('Login failed: ${e.message}');
    } catch (e) {
      throw ApiException('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } on DioException catch (e) {
      throw ApiException('Logout failed: ${e.message}');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post('/auth/forgot-password', data: {'email': email});
    } on DioException catch (e) {
      throw ApiException('Forgot password failed: ${e.message}');
    }
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Token refresh failed: ${e.message}');
    }
  }

  @override
  Future<void> verifyEmail(String token) async {
    try {
      await _dio.post('/auth/verify-email', data: {'token': token});
    } on DioException catch (e) {
      throw ApiException('Email verification failed: ${e.message}');
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _dio.post('/auth/change-password', data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      });
    } on DioException catch (e) {
      throw ApiException('Password change failed: ${e.message}');
    }
  }
}
