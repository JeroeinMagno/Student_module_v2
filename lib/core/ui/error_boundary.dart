import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../error/app_error.dart';
import '../error/error_handler.dart';

/// Error boundary widget to catch and handle errors in widgets
class ErrorBoundary extends ConsumerStatefulWidget {
  const ErrorBoundary({
    super.key,
    required this.child,
    this.onError,
    this.fallbackBuilder,
  });

  final Widget child;
  final void Function(AppError error, StackTrace stackTrace)? onError;
  final Widget Function(AppError error, StackTrace stackTrace)? fallbackBuilder;

  @override
  ConsumerState<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends ConsumerState<ErrorBoundary> {
  AppError? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.fallbackBuilder?.call(_error!, _stackTrace!) ??
          ErrorDisplayWidget(
            error: _error!,
            onRetry: _clearError,
          );
    }

    return ErrorCatcher(
      onError: _handleError,
      child: widget.child,
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    final appError = ErrorHandler.handleError(error, stackTrace);
    setState(() {
      _error = appError;
      _stackTrace = stackTrace;
    });
    widget.onError?.call(appError, stackTrace);
  }

  void _clearError() {
    setState(() {
      _error = null;
      _stackTrace = null;
    });
  }
}

/// Widget to catch errors in child widgets
class ErrorCatcher extends StatelessWidget {
  const ErrorCatcher({
    super.key,
    required this.child,
    required this.onError,
  });

  final Widget child;
  final void Function(Object error, StackTrace stackTrace) onError;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Generic error display widget
class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.showDetails = false,
  });

  final AppError error;
  final VoidCallback? onRetry;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(),
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _getErrorTitle(),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    return switch (error) {
      NetworkError() => Icons.wifi_off,
      ValidationError() => Icons.error_outline,
      AuthenticationError() => Icons.lock_outline,
      OfflineError() => Icons.cloud_off,
      _ => Icons.error_outline,
    };
  }

  String _getErrorTitle() {
    return switch (error) {
      NetworkError() => 'Connection Problem',
      ValidationError() => 'Invalid Input',
      AuthenticationError() => 'Authentication Required',
      OfflineError() => 'No Connection',
      _ => 'Something Went Wrong',
    };
  }
}

/// Async error widget for handling AsyncValue errors
class AsyncErrorWidget<T> extends StatelessWidget {
  const AsyncErrorWidget({
    super.key,
    required this.asyncValue,
    required this.onRetry,
    this.showDetails = false,
  });

  final AsyncValue<T> asyncValue;
  final VoidCallback onRetry;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (_) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) {
        final appError = error is AppError 
            ? error 
            : ErrorHandler.handleError(error, stackTrace);
        
        return ErrorDisplayWidget(
          error: appError,
          onRetry: onRetry,
          showDetails: showDetails,
        );
      },
    );
  }
}

/// Loading widget for async states
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.size = 24.0,
  });

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: size * 0.1,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
