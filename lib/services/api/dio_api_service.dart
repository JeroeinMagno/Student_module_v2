import 'package:dio/dio.dart';
import 'base_api_service.dart';

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
  
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.unknown:
        return Exception('Network error. Please try again.');
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }
}
