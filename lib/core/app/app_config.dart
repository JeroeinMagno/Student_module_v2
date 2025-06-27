import 'package:flutter/material.dart';

/// Application configuration and initialization
class AppConfig {
  // Design size for responsive layout (iPhone 11 Pro)
  static const Size designSize = Size(375, 812);
  
  // App metadata
  static const String appTitle = 'Student Module';
  static const bool debugShowCheckedModeBanner = false;
  
  // Development configuration
  static const bool useMockDataInDevelopment = true;
  
  // Google Fonts configuration
  static const bool allowGoogleFontsRuntimeFetching = false;
}
