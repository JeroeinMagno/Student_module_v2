// Core state management exports
export 'providers/student_provider.dart';
export 'providers/courses_provider.dart';
export 'providers/assessments_provider.dart';
export 'providers/connectivity_provider.dart';
export 'providers/dashboard_provider.dart';

// State models exports
export 'models/app_async_value.dart';

// Common provider dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/connectivity_provider.dart';

/// Initialize all state management services
Future<void> initializeStateManagement() async {
  // Initialize connectivity service
  final container = ProviderContainer();
  final connectivityService = container.read(connectivityServiceProvider);
  await connectivityService.initialize();
  container.dispose();
}

/// Global provider overrides for testing
final stateManagementOverrides = <Override>[];

/// App-wide state management configuration
class StateManagementConfig {
  static const Duration cacheExpiration = Duration(hours: 6);
  static const Duration offlineTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
