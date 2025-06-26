/// Base API service interface
abstract class BaseApiService {
  /// Base URL for the API
  String get baseUrl;
  
  /// Headers for API requests
  Map<String, String> get headers;
  
  /// GET request
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params});
  
  /// POST request
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? data});
  
  /// PUT request
  Future<T> put<T>(String endpoint, {Map<String, dynamic>? data});
  
  /// DELETE request
  Future<T> delete<T>(String endpoint);
}
