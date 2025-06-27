import 'package:flutter/material.dart';
import 'core/app/app_initializer.dart';
import 'core/app/student_module_app.dart';

/// Main entry point of the Student Module application
void main() async {
  // Initialize the application
  await AppInitializer.initialize();
  
  // Run the app
  runApp(const StudentModuleApp());
}
