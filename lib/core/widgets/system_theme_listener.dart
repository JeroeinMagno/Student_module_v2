import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// Widget that listens to system theme changes and updates the ThemeProvider
class SystemThemeListener extends StatefulWidget {
  final Widget child;

  const SystemThemeListener({
    super.key,
    required this.child,
  });

  @override
  State<SystemThemeListener> createState() => _SystemThemeListenerState();
}

class _SystemThemeListenerState extends State<SystemThemeListener> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Update theme on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemTheme();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _updateSystemTheme();
  }

  void _updateSystemTheme() {
    if (mounted) {
      final brightness = MediaQuery.of(context).platformBrightness;
      final themeProvider = context.read<ThemeProvider>();
      themeProvider.updateSystemDarkMode(brightness == Brightness.dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
