import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import '../../../core/error/app_error.dart';

/// Generic async state for managing loading, success, and error states
sealed class AppAsyncValue<T> {
  const AppAsyncValue();
}

/// Loading state
class AsyncLoading<T> extends AppAsyncValue<T> {
  const AsyncLoading();

  @override
  String toString() => 'AsyncLoading()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AsyncLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Data state
class AsyncData<T> extends AppAsyncValue<T> {
  final T value;

  const AsyncData(this.value);

  @override
  String toString() => 'AsyncData(value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncData<T> && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Error state
class AsyncError<T> extends AppAsyncValue<T> {
  final AppError error;
  final StackTrace? stackTrace;

  const AsyncError(this.error, [this.stackTrace]);

  @override
  String toString() => 'AsyncError(error: $error, stackTrace: $stackTrace)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncError<T> &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;
}

/// Extensions for AppAsyncValue
extension AppAsyncValueExtensions<T> on AppAsyncValue<T> {
  /// Check if the state is loading
  bool get isLoading => this is AsyncLoading<T>;

  /// Check if the state has data
  bool get hasData => this is AsyncData<T>;

  /// Check if the state has error
  bool get hasError => this is AsyncError<T>;

  /// Get the data value, null if not in data state
  T? get data => switch (this) {
    AsyncData<T>(value: final value) => value,
    _ => null,
  };

  /// Get the error, null if not in error state
  AppError? get error => switch (this) {
    AsyncError<T>(error: final error) => error,
    _ => null,
  };

  /// Transform the data if available
  AppAsyncValue<R> map<R>(R Function(T) transform) => switch (this) {
    AsyncLoading<T>() => AsyncLoading<R>(),
    AsyncData<T>(value: final value) => AsyncData(transform(value)),
    AsyncError<T>(error: final error, stackTrace: final stackTrace) => 
        AsyncError(error, stackTrace),
  };

  /// Pattern matching for the async value
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(AppError error, StackTrace? stackTrace) error,
  }) => switch (this) {
    AsyncLoading<T>() => loading(),
    AsyncData<T>(value: final value) => data(value),
    AsyncError<T>(error: final err, stackTrace: final st) => error(err, st),
  };

  /// Pattern matching with optional handlers
  R maybeWhen<R>({
    R Function()? loading,
    R Function(T data)? data,
    R Function(AppError error, StackTrace? stackTrace)? error,
    required R Function() orElse,
  }) => switch (this) {
    AsyncLoading<T>() => loading?.call() ?? orElse(),
    AsyncData<T>(value: final value) => data?.call(value) ?? orElse(),
    AsyncError<T>(error: final err, stackTrace: final st) => 
        error?.call(err, st) ?? orElse(),
  };

  /// Convert to Riverpod's AsyncValue if needed
  riverpod.AsyncValue<T> toRiverpodAsyncValue() => switch (this) {
    AsyncLoading<T>() => const riverpod.AsyncValue.loading(),
    AsyncData<T>(value: final value) => riverpod.AsyncValue.data(value),
    AsyncError<T>(error: final error, stackTrace: final stackTrace) => 
        riverpod.AsyncValue.error(error, stackTrace ?? StackTrace.current),
  };
}
