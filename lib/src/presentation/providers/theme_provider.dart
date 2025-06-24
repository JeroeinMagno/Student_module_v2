import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    switch (state) {
      case ThemeMode.system:
        state = ThemeMode.light;
        break;
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.system;
        break;
    }
    await prefs.setInt('theme_mode', state.index);
  }

  void setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    state = themeMode;
    await prefs.setInt('theme_mode', themeMode.index);
  }
}
