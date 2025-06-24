import 'package:go_router/go_router.dart';
import '../../presentation/layouts/main_layout.dart';
import '../../presentation/pages/dashboard/course/course_detail_page.dart' as detail;
import '../../presentation/pages/splash/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/performance', // Change initial location to performance
    routes: [
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
              return detail.CourseDetailPage(courseId: courseId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/exam-overview',
        builder: (context, state) => const MainLayout(currentRoute: '/exam-overview'),
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
