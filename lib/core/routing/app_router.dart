import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_session.dart';
import '../../features/home/presentation/app_shell.dart';
import '../../features/home/presentation/dashboard_page.dart';
import '../../features/home/presentation/landing_page.dart';
import '../../features/home/presentation/not_found_page.dart';
import '../../features/legal/domain/legal_document.dart';
import '../../features/legal/presentation/legal_page.dart';
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
      // Legal pages are readable while signed out, e.g. from the sign-in card.
      if (state.matchedLocation.startsWith(AppRoutes.legalPrefix)) return null;
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
      GoRoute(
        path: AppRoutes.privacy,
        builder: (context, state) =>
            const LegalPage(document: LegalDocument.privacy),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (context, state) =>
            const LegalPage(document: LegalDocument.terms),
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
