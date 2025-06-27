import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';
import '../widgets/system_theme_listener.dart';
import 'app_config.dart';

/// Root application widget with all providers and configuration
class StudentModuleApp extends StatelessWidget {
  const StudentModuleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: _buildResponsiveApp(),
    );
  }

  /// Build the responsive app with ScreenUtil
  Widget _buildResponsiveApp() {
    return ScreenUtilInit(
      designSize: AppConfig.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => _buildThemedApp(context),
    );
  }

  /// Build the themed Material app
  Widget _buildThemedApp(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SystemThemeListener(
          child: MaterialApp.router(
            title: AppConfig.appTitle,
            debugShowCheckedModeBanner: AppConfig.debugShowCheckedModeBanner,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
