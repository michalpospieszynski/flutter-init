import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/page_body.dart';
import '../../auth/presentation/account_notices.dart';
import 'feature_card.dart';

/// Signed-in home: greeting, account notices and shortcuts.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final session = AppScope.of(context).session;

    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final user = session.user;
        if (user == null) return const SizedBox.shrink();

        return PageBody(
          child: FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountNotices(user: user),
                Semantics(
                  header: true,
                  child: Text(
                    l10n.homeGreeting(user.label),
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.homeSubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const _Shortcuts(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Independent of the session, so it is const and never rebuilt by user updates.
class _Shortcuts extends StatelessWidget {
  const _Shortcuts();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cards = [
      _Shortcut(
        icon: Icons.person_outline_rounded,
        title: l10n.homeCardProfileTitle,
        description: l10n.homeCardProfileDescription,
        route: AppRoutes.profile,
      ),
      _Shortcut(
        icon: Icons.tune_rounded,
        title: l10n.homeCardSettingsTitle,
        description: l10n.homeCardSettingsDescription,
        route: AppRoutes.settings,
      ),
      _Shortcut(
        icon: Icons.verified_user_outlined,
        title: l10n.homeCardSecurityTitle,
        description: l10n.homeCardSecurityDescription,
        route: AppRoutes.profile,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        final columns = constraints.maxWidth >= AppBreakpoints.wide
            ? 3
            : constraints.maxWidth >= AppBreakpoints.medium
            ? 2
            : 1;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final card in cards) SizedBox(width: width, child: card),
          ],
        );
      },
    );
  }
}

class _Shortcut extends StatelessWidget {
  const _Shortcut({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String description;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () => context.go(route),
        child: FeatureCard(icon: icon, title: title, description: description),
      ),
    );
  }
}
