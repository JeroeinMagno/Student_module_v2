import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/widgets/system_theme_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services with mock data for development
  initializeServices(useMockData: true);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // iPhone 11 Pro design size
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SystemThemeListener(
                child: MaterialApp.router(
                  title: 'Student Module',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeProvider.themeMode,
                  routerConfig: AppRouter.router,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
