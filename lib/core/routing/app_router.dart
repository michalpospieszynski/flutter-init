import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_session.dart';
import '../../features/home/presentation/app_shell.dart';
import '../../features/home/presentation/dashboard_page.dart';
import '../../features/home/presentation/landing_page.dart';
import '../../features/home/presentation/not_found_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import 'app_routes.dart';

/// Signed-out users see only the landing page; signed-in users get the shell.
GoRouter createRouter(AuthSession session) {
  return GoRouter(
    initialLocation: AppRoutes.landing,
    refreshListenable: session,
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      if (!session.isReady) return null;
      final atLanding = state.matchedLocation == AppRoutes.landing;
      if (session.isSignedIn && atLanding) return AppRoutes.home;
      if (!session.isSignedIn && !atLanding) return AppRoutes.landing;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) => const LandingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
