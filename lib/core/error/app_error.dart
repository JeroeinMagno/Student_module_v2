/// Enhanced error model with comprehensive error categorization
abstract class AppError {
  const AppError({
    required this.message,
    this.code,
    this.isRetryable = false,
    this.originalError,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final bool isRetryable;
  final Object? originalError;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppError: $message (code: $code)';
}

class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    super.code,
    super.isRetryable = true,
    super.originalError,
    super.stackTrace,
  });
}

class ServerError extends AppError {
  const ServerError({
    required super.message,
    super.code,
    this.statusCode,
    super.isRetryable = false,
    super.originalError,
    super.stackTrace,
  });

  final int? statusCode;
}

class AuthenticationError extends AppError {
  const AuthenticationError({
    required super.message,
    super.code,
    super.isRetryable = false,
    super.originalError,
    super.stackTrace,
  });
}

class AuthorizationError extends AppError {
  const AuthorizationError({
    required super.message,
    super.code,
    super.isRetryable = false,
    super.originalError,
    super.stackTrace,
  });
}

class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    super.code,
    this.fieldErrors,
    super.originalError,
    super.stackTrace,
  });

  final Map<String, String>? fieldErrors;
}

class CacheError extends AppError {
  const CacheError({
    required super.message,
    super.code,
    super.isRetryable = true,
    super.originalError,
    super.stackTrace,
  });
}

class UnknownError extends AppError {
  const UnknownError({
    required super.message,
    super.code,
    super.isRetryable = false,
    super.originalError,
    super.stackTrace,
  });
}

class OfflineError extends AppError {
  const OfflineError({
    super.message = 'No internet connection',
    super.code,
    super.isRetryable = true,
    super.originalError,
    super.stackTrace,
  });
}
