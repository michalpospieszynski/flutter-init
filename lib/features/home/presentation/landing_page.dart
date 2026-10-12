import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/page_body.dart';
import '../../auth/presentation/auth_card.dart';
import 'app_bar_actions.dart';
import 'app_footer.dart';
import 'app_wordmark.dart';
import 'feature_card.dart';

/// Public landing page with the sign-in card.
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const AppWordmark(),
        actions: const [AppBarActions()],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.7, -1.1),
                    radius: 1.1,
                    colors: [
                      scheme.primary.withValues(alpha: 0.16),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          PageBody(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= AppBreakpoints.wide;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeSlideIn(
                      child: _Hero(
                        isWide: isWide,
                        authCard: AuthCard(
                          authService: AppScope.of(context).authService,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.section),
                    const FadeSlideIn(child: _Features()),
                    const SizedBox(height: 56),
                    const AppFooter(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.isWide, required this.authCard});

  final bool isWide;
  final Widget authCard;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: Text(
            l10n.heroBadge,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Semantics(
          header: true,
          child: Text(l10n.heroTitle, style: theme.textTheme.displaySmall),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.heroSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );

    if (!isWide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          authCard,
          const SizedBox(height: AppSpacing.xl),
          intro,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: intro),
        const SizedBox(width: 56),
        Expanded(flex: 5, child: authCard),
      ],
    );
  }
}

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    final features = [
      FeatureCard(
        icon: Icons.translate_rounded,
        title: l10n.featureLocalizationTitle,
        description: l10n.featureLocalizationDescription,
      ),
      FeatureCard(
        icon: Icons.palette_outlined,
        title: l10n.featureThemeTitle,
        description: l10n.featureThemeDescription,
      ),
      FeatureCard(
        icon: Icons.lock_outline_rounded,
        title: l10n.featureAuthTitle,
        description: l10n.featureAuthDescription,
      ),
      FeatureCard(
        icon: Icons.devices_rounded,
        title: l10n.featureStructureTitle,
        description: l10n.featureStructureDescription,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(l10n.featuresTitle, style: theme.textTheme.headlineSmall),
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 16.0;
            final columns = constraints.maxWidth >= AppBreakpoints.wide
                ? 4
                : constraints.maxWidth >= AppBreakpoints.medium
                ? 2
                : 1;
            final itemWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final feature in features)
                  SizedBox(width: itemWidth, child: feature),
              ],
            );
          },
        ),
      ],
    );
  }
}
