import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/page_body.dart';
import '../../home/presentation/app_bar_actions.dart';
import '../../home/presentation/language_switcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scope = AppScope.of(context);

    Widget section(String title, Widget child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm + 4),
        child,
        const SizedBox(height: AppSpacing.xl),
      ],
    );

    return PageBody(
      child: FadeSlideIn(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.settingsTitle,
                style: theme.textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            section(
              l10n.settingsAppearance,
              ListenableBuilder(
                listenable: scope.themeController,
                builder: (context, _) => SegmentedButton<ThemeMode>(
                  showSelectedIcon: false,
                  segments: [
                    for (final mode in ThemeMode.values)
                      ButtonSegment(
                        value: mode,
                        icon: Icon(themeModeIcon(mode), size: 18),
                        label: Text(themeModeLabel(context, mode)),
                      ),
                  ],
                  selected: {scope.themeController.mode},
                  onSelectionChanged: (s) =>
                      scope.themeController.setMode(s.first),
                ),
              ),
            ),
            section(
              l10n.settingsLanguage,
              Align(
                alignment: Alignment.centerLeft,
                child: LanguageSwitcher(controller: scope.localeController),
              ),
            ),
            section(
              l10n.settingsAccount,
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton(
                  style: AppButtonStyle.outlined,
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  onPressed: scope.authService.signOut,
                  label: l10n.authSignOut,
                ),
              ),
            ),
            section(
              l10n.settingsLegal,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton(
                    style: AppButtonStyle.text,
                    onPressed: () => context.push(AppRoutes.privacy),
                    label: l10n.legalPrivacy,
                  ),
                  AppButton(
                    style: AppButtonStyle.text,
                    onPressed: () => context.push(AppRoutes.terms),
                    label: l10n.legalTerms,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
