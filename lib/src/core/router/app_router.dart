import 'package:go_router/go_router.dart';
import '../../presentation/pages/dashboard/dashboard_page.dart';
import '../../presentation/pages/dashboard/course/course_page.dart';
import '../../presentation/pages/dashboard/course/course_detail_page.dart' as detail;
import '../../presentation/pages/dashboard/exam/exam_page.dart';
import '../../presentation/pages/dashboard/career/career_page.dart';
import '../../presentation/pages/dashboard/bot/bot_page.dart';
import '../../presentation/pages/splash/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: '/course',
            builder: (context, state) => const CoursePage(),
            routes: [
              GoRoute(
                path: '/:courseId',
                builder: (context, state) {
                  final courseId = state.pathParameters['courseId']!;
                  return detail.CourseDetailPage(courseId: courseId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/exam',
            builder: (context, state) => const ExamPage(),
          ),
          GoRoute(
            path: '/career',
            builder: (context, state) => const CareerPage(),
          ),
          GoRoute(
            path: '/bot',
            builder: (context, state) => const BotPage(),
          ),
        ],
      ),
    ],
  );
}
