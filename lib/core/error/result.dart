import 'failures.dart';

/// Represents a result that can be either a success or a failure
abstract class Result<T> {
  const Result();

  /// Create a success result
  const factory Result.success(T data) = Success<T>;

  /// Create a failure result
  const factory Result.failure(Failure failure) = FailureResult<T>;

  /// Check if this is a success result
  bool get isSuccess;

  /// Check if this is a failure result
  bool get isFailure;

  /// Get the data (throws if failure)
  T get data;

  /// Get the failure (throws if success)
  Failure get failure;

  /// Get the data or null if failure
  T? get dataOrNull => isSuccess ? data : null;

  /// Fold the result into a single value
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess);

  /// Map the success data
  Result<R> map<R>(R Function(T data) transform);

  /// FlatMap/bind the success data
  Result<R> flatMap<R>(Result<R> Function(T data) transform);
}

/// Success result containing data
class Success<T> extends Result<T> {
  const Success(this._data);

  final T _data;

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;

  @override
  T get data => _data;

  @override
  Failure get failure => throw StateError('Cannot get failure from Success');

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) {
    return onSuccess(_data);
  }

  @override
  Result<R> map<R>(R Function(T data) transform) {
    return Success(transform(_data));
  }

  @override
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    return transform(_data);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> && _data == other._data;

  @override
  int get hashCode => _data.hashCode;

  @override
  String toString() => 'Success($_data)';
}

/// Failure result containing error information
class FailureResult<T> extends Result<T> {
  const FailureResult(this._failure);

  final Failure _failure;

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;

  @override
  T get data => throw StateError('Cannot get data from Failure');

  @override
  Failure get failure => _failure;

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) {
    return onFailure(_failure);
  }

  @override
  Result<R> map<R>(R Function(T data) transform) {
    return FailureResult<R>(_failure);
  }

  @override
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    return FailureResult<R>(_failure);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FailureResult<T> && _failure == other._failure;

  @override
  int get hashCode => _failure.hashCode;

  @override
  String toString() => 'Failure($_failure)';
}
