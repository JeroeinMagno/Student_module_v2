import 'package:go_router/go_router.dart';
import '../../components/layouts/main_layout.dart';
import '../../features/courses/ui/course_detail_page.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/splash/ui/splash_page.dart';

/// App router that matches the original routing structure exactly
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash', // Start with splash screen
    routes: [
      // Splash route
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Auth routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Main app routes with layout
      GoRoute(
        path: '/',
        redirect: (_, __) => '/performance', // Redirect root to performance
      ),
      GoRoute(
        path: '/performance',
        builder: (context, state) => const MainLayout(currentRoute: '/performance'),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const MainLayout(currentRoute: '/dashboard'),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const MainLayout(currentRoute: '/courses'),
        routes: [
          GoRoute(
            path: ':courseId',
            builder: (context, state) {
              final courseId = state.pathParameters['courseId']!;
              return CourseDetailPage(courseId: courseId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/exam-overview',
        builder: (context, state) => const MainLayout(currentRoute: '/exam-overview'),
      ),
      GoRoute(
        path: '/career',
        builder: (context, state) => const MainLayout(currentRoute: '/career'),
      ),
      GoRoute(
        path: '/skill-profile',
        builder: (context, state) => const MainLayout(currentRoute: '/skill-profile'),
      ),
      GoRoute(
        path: '/track-readiness',
        builder: (context, state) => const MainLayout(currentRoute: '/track-readiness'),
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) => const MainLayout(currentRoute: '/chatbot'),
      ),
    ],
  );
}
