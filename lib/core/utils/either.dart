/// Represents a value that can be either a failure (Left) or a success (Right)
abstract class Either<L, R> {
  const Either();

  /// Create a Left (failure) value
  const factory Either.left(L value) = Left<L, R>;

  /// Create a Right (success) value
  const factory Either.right(R value) = Right<L, R>;

  /// Check if this is a Left (failure) value
  bool get isLeft;

  /// Check if this is a Right (success) value
  bool get isRight;

  /// Get the Left value (throws if Right)
  L get left;

  /// Get the Right value (throws if Left)
  R get right;

  /// Fold the Either into a single value
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);

  /// Map the Right value
  Either<L, T> map<T>(T Function(R right) f);

  /// FlatMap/bind the Right value
  Either<L, T> flatMap<T>(Either<L, T> Function(R right) f);
}

/// Left represents a failure value
class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  final L value;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  L get left => value;

  @override
  R get right => throw StateError('Cannot get right value from Left');

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }

  @override
  Either<L, T> map<T>(T Function(R right) f) {
    return Left<L, T>(value);
  }

  @override
  Either<L, T> flatMap<T>(Either<L, T> Function(R right) f) {
    return Left<L, T>(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Left<L, R> && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Left($value)';
}

/// Right represents a success value
class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  final R value;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  L get left => throw StateError('Cannot get left value from Right');

  @override
  R get right => value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onRight(value);
  }

  @override
  Either<L, T> map<T>(T Function(R right) f) {
    return Right<L, T>(f(value));
  }

  @override
  Either<L, T> flatMap<T>(Either<L, T> Function(R right) f) {
    return f(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Right<L, R> && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Right($value)';
}
