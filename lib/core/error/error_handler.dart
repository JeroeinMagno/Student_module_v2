import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'app_error.dart';
import 'result.dart';

/// Centralized error handler for converting exceptions to AppError
class ErrorHandler {
  static final _logger = Logger('ErrorHandler');

  /// Converts various exception types to AppError
  static AppError handleError(Object error, [StackTrace? stackTrace]) {
    _logger.severe('Error occurred: $error', error, stackTrace);

    return switch (error) {
      DioException dioError => _handleDioError(dioError, stackTrace),
      SocketException() => NetworkError(
          message: 'Network connection failed',
          code: 'NETWORK_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        ),
      HttpException httpError => ServerError(
          message: httpError.message,
          code: 'HTTP_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        ),
      FormatException() => ValidationError(
          message: 'Invalid data format',
          code: 'FORMAT_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        ),
      TimeoutException() => NetworkError(
          message: 'Request timeout',
          code: 'TIMEOUT',
          isRetryable: true,
          originalError: error,
          stackTrace: stackTrace,
        ),
      _ => UnknownError(
          message: error.toString(),
          code: 'UNKNOWN_ERROR',
          originalError: error,
          stackTrace: stackTrace,
        ),
    };
  }

  /// Handles Dio-specific errors
  static AppError _handleDioError(DioException error, StackTrace? stackTrace) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkError(
          message: 'Connection timeout',
          code: 'TIMEOUT',
          isRetryable: true,
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 
                       error.response?.statusMessage ?? 
                       'Server error occurred';

        return switch (statusCode) {
          401 => AuthenticationError(
              message: message,
              code: 'UNAUTHORIZED',
              originalError: error,
              stackTrace: stackTrace,
            ),
          403 => AuthorizationError(
              message: message,
              code: 'FORBIDDEN',
              originalError: error,
              stackTrace: stackTrace,
            ),
          400 => ValidationError(
              message: message,
              code: 'BAD_REQUEST',
              fieldErrors: _extractFieldErrors(error.response?.data),
              originalError: error,
              stackTrace: stackTrace,
            ),
          404 => ServerError(
              message: 'Resource not found',
              code: 'NOT_FOUND',
              statusCode: statusCode,
              originalError: error,
              stackTrace: stackTrace,
            ),
          int statusCode when statusCode >= 500 => ServerError(
              message: message,
              code: 'SERVER_ERROR',
              statusCode: statusCode,
              isRetryable: true,
              originalError: error,
              stackTrace: stackTrace,
            ),
          _ => ServerError(
              message: message,
              code: 'HTTP_ERROR',
              statusCode: statusCode,
              originalError: error,
              stackTrace: stackTrace,
            ),
        };

      case DioExceptionType.connectionError:
        return NetworkError(
          message: 'No internet connection',
          code: 'NO_INTERNET',
          isRetryable: true,
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.cancel:
        return NetworkError(
          message: 'Request was cancelled',
          code: 'CANCELLED',
          originalError: error,
          stackTrace: stackTrace,
        );

      case DioExceptionType.unknown:
      default:
        return UnknownError(
          message: error.message ?? 'Unknown error occurred',
          code: 'UNKNOWN',
          originalError: error,
          stackTrace: stackTrace,
        );
    }
  }

  /// Extracts field errors from API response
  static Map<String, String>? _extractFieldErrors(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final errors = responseData['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map((key, value) => MapEntry(key, value.toString()));
      }
    }
    return null;
  }

  /// Wraps a function call with error handling
  static Future<Result<T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Success(result);
    } catch (error, stackTrace) {
      return Failure(handleError(error, stackTrace));
    }
  }

  /// Wraps a synchronous function call with error handling
  static Result<T> safeSyncCall<T>(T Function() call) {
    try {
      final result = call();
      return Success(result);
    } catch (error, stackTrace) {
      return Failure(handleError(error, stackTrace));
    }
  }
}
