import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Network connectivity states
enum NetworkStatus {
  online,
  offline,
  unknown,
}

/// Service for monitoring network connectivity
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamController<NetworkStatus> _statusController;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  Stream<NetworkStatus> get statusStream => _statusController.stream;
  NetworkStatus _currentStatus = NetworkStatus.unknown;

  /// Get current network status
  NetworkStatus get currentStatus => _currentStatus;

  /// Initialize the service
  Future<void> initialize() async {
    _statusController = StreamController<NetworkStatus>.broadcast();
    
    // Check initial connectivity
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);
    
    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateStatus,
      onError: (error) {
        _statusController.add(NetworkStatus.unknown);
      },
    );
  }

  /// Update network status based on connectivity result
  void _updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _currentStatus = NetworkStatus.offline;
    } else {
      _currentStatus = NetworkStatus.online;
    }
    
    _statusController.add(_currentStatus);
  }

  /// Check if device is currently online
  bool get isOnline => _currentStatus == NetworkStatus.online;

  /// Check if device is currently offline
  bool get isOffline => _currentStatus == NetworkStatus.offline;

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _statusController.close();
  }
}

/// Provider for connectivity service
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for network status stream
final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.statusStream;
});

/// Provider for current network status
final currentNetworkStatusProvider = Provider<NetworkStatus>((ref) {
  final asyncValue = ref.watch(networkStatusProvider);
  return asyncValue.when(
    data: (status) => status,
    loading: () => NetworkStatus.unknown,
    error: (_, __) => NetworkStatus.unknown,
  );
});
