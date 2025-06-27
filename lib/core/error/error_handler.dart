import 'dart:io';
import 'package:dio/dio.dart';
import 'app_error.dart';
import 'result.dart';
import 'failures.dart';

/// Centralized error handler for the application
class ErrorHandler {
  /// Convert any error to an AppError
  static AppError handleError(Object error, StackTrace stackTrace) {
    if (error is AppError) {
      return error;
    }
    
    if (error is DioException) {
      return _handleDioError(error);
    }
    
    if (error is SocketException) {
      return NetworkError('No internet connection');
    }
    
    if (error is FormatException) {
      return ValidationError('Invalid data format: ${error.message}');
    }
    
    // Log the error for debugging
    _logError(error, stackTrace);
    
    return GenericError('An unexpected error occurred: ${error.toString()}');
  }
  
  /// Safely execute an async operation and return a Result
  static Future<Result<T>> safeCall<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Result.success(result);
    } catch (error, stackTrace) {
      final failure = _convertToFailure(error, stackTrace);
      return Result.failure(failure);
    }
  }
  
  /// Convert an error to a Failure
  static Failure _convertToFailure(Object error, StackTrace stackTrace) {
    if (error is DioException) {
      return _handleDioFailure(error);
    }
    
    if (error is SocketException) {
      return const NetworkFailure('No internet connection');
    }
    
    if (error is FormatException) {
      return InvalidInputFailure('Invalid data format: ${error.message}');
    }
    
    // Log the error for debugging
    _logError(error, stackTrace);
    
    return UnexpectedFailure('An unexpected error occurred: ${error.toString()}');
  }
  
  static AppError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkError('Connection timeout');
        
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return ValidationError('Bad request');
          case 401:
            return AuthenticationError('Authentication failed');
          case 403:
            return AuthenticationError('Access denied');
          case 404:
            return ServerError('Resource not found');
          case 500:
            return ServerError('Internal server error');
          default:
            return ServerError('Server error ($statusCode)');
        }
        
      case DioExceptionType.cancel:
        return GenericError('Request was cancelled');
        
      case DioExceptionType.connectionError:
        return NetworkError('Connection failed');
        
      case DioExceptionType.badCertificate:
        return NetworkError('Certificate error');
        
      case DioExceptionType.unknown:
        return GenericError('Network error: ${error.message}');
    }
  }
  
  static Failure _handleDioFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
        
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return const InvalidInputFailure('Bad request');
          case 401:
            return const AuthFailure('Authentication failed');
          case 403:
            return const AuthorizationFailure('Access denied');
          case 404:
            return const NotFoundFailure('Resource not found');
          case 500:
            return const ServerFailure('Internal server error');
          default:
            return ServerFailure('Server error ($statusCode)');
        }
        
      case DioExceptionType.cancel:
        return const UnexpectedFailure('Request was cancelled');
        
      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection failed');
        
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificate error');
        
      case DioExceptionType.unknown:
        return UnexpectedFailure('Network error: ${error.message}');
    }
  }
  
  static void _logError(Object error, StackTrace stackTrace) {
    // In a real app, you might want to send this to a logging service
    print('Error: $error');
    print('StackTrace: $stackTrace');
  }
}
