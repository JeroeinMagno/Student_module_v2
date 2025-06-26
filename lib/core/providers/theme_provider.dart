import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme provider for managing light/dark mode
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;
  bool _isInitialized = false;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;
  
  ThemeProvider() {
    _loadTheme();
  }
  
  /// Load theme preference from storage
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      _themeMode = ThemeMode.values[savedThemeIndex];
      
      // Determine if dark mode based on theme mode and system settings
      _updateDarkModeState();
      
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }
  
  /// Save theme preference to storage
  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, _themeMode.index);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }
  
  /// Update dark mode state based on theme mode
  void _updateDarkModeState() {
    switch (_themeMode) {
      case ThemeMode.light:
        _isDarkMode = false;
        break;
      case ThemeMode.dark:
        _isDarkMode = true;
        break;
      case ThemeMode.system:
        // This will be determined by the system, but we default to false here
        // The actual system theme will be handled by MaterialApp
        _isDarkMode = false;
        break;
    }
  }
  
  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    _updateDarkModeState();
    notifyListeners();
    await _saveTheme();
  }
  
  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newMode = _isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
  
  /// Set light theme
  Future<void> setLightTheme() async {
    await setThemeMode(ThemeMode.light);
  }
  
  /// Set dark theme
  Future<void> setDarkTheme() async {
    await setThemeMode(ThemeMode.dark);
  }
  
  /// Set system theme
  Future<void> setSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }
  
  /// Update dark mode state from system (called by app when system theme changes)
  void updateSystemDarkMode(bool isSystemDark) {
    if (_themeMode == ThemeMode.system) {
      final wasChanged = _isDarkMode != isSystemDark;
      _isDarkMode = isSystemDark;
      if (wasChanged) {
        // Use post-frame callback to avoid calling notifyListeners during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
    }
  }
}
