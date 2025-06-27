import 'app_error.dart';

/// Result type for handling success and error cases
sealed class Result<T> {
  const Result();
}

/// Success result containing data
class Success<T> extends Result<T> {
  const Success(this.data);
  
  final T data;

  @override
  String toString() => 'Success($data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// Failure result containing error
class Failure<T> extends Result<T> {
  const Failure(this.error);
  
  final AppError error;

  @override
  String toString() => 'Failure($error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

/// Extensions for Result type
extension ResultExtensions<T> on Result<T> {
  /// Returns true if this is a Success
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a Failure
  bool get isFailure => this is Failure<T>;

  /// Returns the data if Success, null otherwise
  T? get dataOrNull => switch (this) {
    Success<T>(data: final data) => data,
    Failure<T>() => null,
  };

  /// Returns the error if Failure, null otherwise
  AppError? get errorOrNull => switch (this) {
    Success<T>() => null,
    Failure<T>(error: final error) => error,
  };

  /// Transforms the data if Success
  Result<R> map<R>(R Function(T) transform) => switch (this) {
    Success<T>(data: final data) => Success(transform(data)),
    Failure<T>(error: final error) => Failure(error),
  };

  /// Handles both success and failure cases
  R fold<R>(
    R Function(AppError) onFailure,
    R Function(T) onSuccess,
  ) => switch (this) {
    Success<T>(data: final data) => onSuccess(data),
    Failure<T>(error: final error) => onFailure(error),
  };

  /// Executes action if Success
  Result<T> onSuccess(void Function(T) action) {
    if (this is Success<T>) {
      action((this as Success<T>).data);
    }
    return this;
  }

  /// Executes action if Failure
  Result<T> onFailure(void Function(AppError) action) {
    if (this is Failure<T>) {
      action((this as Failure<T>).error);
    }
    return this;
  }
}
