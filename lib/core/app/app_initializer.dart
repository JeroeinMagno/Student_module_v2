import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service_locator.dart';
import 'app_config.dart';

/// Handles application initialization and setup
class AppInitializer {
  /// Initialize the application with all required services and configurations
  static Future<void> initialize() async {
    // Ensure Flutter binding is initialized
    WidgetsFlutterBinding.ensureInitialized();
    
    // Configure Google Fonts
    _configureGoogleFonts();
    
    // Initialize services (with mock data for development)
    _initializeServices();
  }
  
  /// Configure Google Fonts settings
  static void _configureGoogleFonts() {
    GoogleFonts.config.allowRuntimeFetching = AppConfig.allowGoogleFontsRuntimeFetching;
  }
  
  /// Initialize all application services
  static void _initializeServices() {
    initializeServices(useMockData: AppConfig.useMockDataInDevelopment);
  }
}
