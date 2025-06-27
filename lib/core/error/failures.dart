/// Base class for all failures in the application
abstract class Failure {
  const Failure([this.message]);
  
  final String? message;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Failure due to server error
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Failure due to cache error
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

/// Failure due to network error
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// Failure due to invalid input
class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message]);
}

/// Failure due to authentication error
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

/// Failure due to authorization error
class AuthorizationFailure extends Failure {
  const AuthorizationFailure([super.message]);
}

/// Failure due to not found error
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

/// Generic failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message]);
}
