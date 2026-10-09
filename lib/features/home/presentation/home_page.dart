import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/localization/locale_controller.dart';
import '../../auth/domain/auth_service.dart';
import '../../auth/presentation/auth_card.dart';
import 'app_footer.dart';
import 'app_wordmark.dart';
import 'feature_card.dart';
import 'language_switcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.authService,
    required this.localeController,
  });

  final AuthService authService;
  final LocaleController localeController;

  static const double _maxContentWidth = 1040;
  static const double _wideBreakpoint = 820;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppWordmark(),
        actions: [
          LanguageSwitcher(controller: localeController),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= _wideBreakpoint;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Hero(
                        isWide: isWide,
                        authCard: AuthCard(authService: authService),
                      ),
                      const SizedBox(height: 72),
                      const _Features(),
                      const SizedBox(height: 56),
                      const AppFooter(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
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
            color: scheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            l10n.heroBadge,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.heroTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
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
        children: [intro, const SizedBox(height: 32), authCard],
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
        icon: Icons.account_tree_outlined,
        title: l10n.featureStructureTitle,
        description: l10n.featureStructureDescription,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.featuresTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 16.0;
            final columns = constraints.maxWidth >= 820
                ? 4
                : constraints.maxWidth >= 520
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
