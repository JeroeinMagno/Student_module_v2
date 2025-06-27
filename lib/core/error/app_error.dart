/// Base class for all application errors
abstract class AppError implements Exception {
  const AppError(this.message, [this.code]);
  
  final String message;
  final String? code;
  
  @override
  String toString() => 'AppError: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Network-related errors
class NetworkError extends AppError {
  const NetworkError(super.message, [super.code]);
}

/// Validation errors
class ValidationError extends AppError {
  const ValidationError(super.message, [super.code]);
}

/// Authentication errors
class AuthenticationError extends AppError {
  const AuthenticationError(super.message, [super.code]);
}

/// Offline/connectivity errors
class OfflineError extends AppError {
  const OfflineError(super.message, [super.code]);
}

/// Server errors
class ServerError extends AppError {
  const ServerError(super.message, [super.code]);
}

/// Generic application error
class GenericError extends AppError {
  const GenericError(super.message, [super.code]);
}
