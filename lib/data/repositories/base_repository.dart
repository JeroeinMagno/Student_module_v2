/// Base repository interface for common CRUD operations
abstract class BaseRepository<T, ID> {
  /// Get all items
  Future<List<T>> getAll();
  
  /// Get item by ID
  Future<T?> getById(ID id);
  
  /// Create new item
  Future<T> create(T item);
  
  /// Update existing item
  Future<T> update(ID id, T item);
  
  /// Delete item by ID
  Future<bool> delete(ID id);
  
  /// Check if item exists
  Future<bool> exists(ID id);
}

/// Result wrapper for repository operations
class RepositoryResult<T> {
  final T? data;
  final String? error;
  final int? statusCode;
  final bool isSuccess;
  
  const RepositoryResult._({
    this.data,
    this.error,
    this.statusCode,
    required this.isSuccess,
  });
  
  /// Create a successful result
  factory RepositoryResult.success(T data) {
    return RepositoryResult._(
      data: data,
      isSuccess: true,
    );
  }
  
  /// Create a failure result
  factory RepositoryResult.failure(String error, [int? statusCode]) {
    return RepositoryResult._(
      error: error,
      statusCode: statusCode,
      isSuccess: false,
    );
  }
  
  /// Get data or throw exception if failed
  T get dataOrThrow {
    if (isSuccess && data != null) {
      return data as T;
    }
    throw Exception(error ?? 'Unknown repository error');
  }
  
  /// Execute action if successful
  void onSuccess(void Function(T data) action) {
    if (isSuccess && data != null) {
      action(data!);
    }
  }
  
  /// Execute action if failed
  void onFailure(void Function(String error) action) {
    if (!isSuccess && error != null) {
      action(error!);
    }
  }
}
