import 'package:flutter/material.dart';
import 'package:mobile_app_student_module_v2/src/auth/presentation/login_screen.dart';
import 'package:mobile_app_student_module_v2/src/core/utils/color_schemes.dart';
import 'package:mobile_app_student_module_v2/src/core/providers/theme_provider.dart';
import 'package:mobile_app_student_module_v2/src/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app_student_module_v2/src/core/utils/service_locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(repository: di.sl()),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Student Module',
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode: themeProvider.themeMode,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
