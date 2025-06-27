import 'package:dio/dio.dart';

/// Base API service interface for all data sources
abstract class BaseApiService {
  /// Base URL for the API
  String get baseUrl;
  
  /// Headers for API requests
  Map<String, String> get headers;
  
  /// GET request
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params});
  
  /// POST request
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data});
  
  /// PUT request
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data});
  
  /// DELETE request
  Future<T> delete<T>(String endpoint);
}

/// Implementation of BaseApiService using Dio
class DioApiService implements BaseApiService {
  late final Dio _dio;
  
  DioApiService({String? baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? this.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: headers,
    ));
    
    // Add interceptors for logging, error handling, etc.
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
  
  @override
  String get baseUrl => 'https://api.student-module.dev/v1';
  
  @override
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  @override
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  @override
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  @override
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  @override
  Future<T> delete<T>(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Handle Dio errors and convert to custom exceptions
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        return ApiException('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return ApiException('Request was cancelled.');
      case DioExceptionType.unknown:
      default:
        return ApiException('Network error: ${error.message}');
    }
  }
}

/// Mock implementation for development
class MockApiService implements BaseApiService {
  @override
  String get baseUrl => 'https://mock-api.dev/v1';
  
  @override
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  @override
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params}) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Return mock data based on endpoint
    switch (endpoint) {
      case '/students/profile':
        return _mockStudentProfile() as T;
      case '/courses':
        return _mockCourses() as T;
      default:
        return {} as T;
    }
  }
  
  @override
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'data': data} as T;
  }
  
  @override
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'data': data} as T;
  }
  
  @override
  Future<T> delete<T>(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true} as T;
  }
  
  /// Mock student profile data
  Map<String, dynamic> _mockStudentProfile() {
    return {
      'id': 'student_123',
      'name': 'John Doe',
      'email': 'john.doe@university.edu',
      'studentNumber': '2021-12345',
      'program': 'Computer Science',
      'yearLevel': 3,
    };
  }
  
  /// Mock courses data
  List<Map<String, dynamic>> _mockCourses() {
    return [
      {
        'id': 'cs101',
        'code': 'CS101',
        'name': 'Introduction to Programming',
        'progress': 85.0,
        'professor': 'Dr. Smith',
      },
      {
        'id': 'math201',
        'code': 'MATH201', 
        'name': 'Calculus II',
        'progress': 92.0,
        'professor': 'Dr. Johnson',
      },
    ];
  }
}

/// Custom API exception class
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}
