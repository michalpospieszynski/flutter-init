import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/theme_controller.dart';
import 'language_switcher.dart';

/// Theme menu and language switcher shared by every app bar.
class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeModeMenu(controller: scope.themeController),
        const SizedBox(width: 4),
        LanguageSwitcher(controller: scope.localeController),
        const SizedBox(width: 16),
      ],
    );
  }
}

IconData themeModeIcon(ThemeMode mode) => switch (mode) {
  ThemeMode.light => Icons.light_mode_outlined,
  ThemeMode.dark => Icons.dark_mode_outlined,
  ThemeMode.system => Icons.brightness_auto_outlined,
};

String themeModeLabel(BuildContext context, ThemeMode mode) {
  final l10n = context.l10n;
  return switch (mode) {
    ThemeMode.light => l10n.themeLight,
    ThemeMode.dark => l10n.themeDark,
    ThemeMode.system => l10n.themeSystem,
  };
}

class ThemeModeMenu extends StatelessWidget {
  const ThemeModeMenu({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => PopupMenuButton<ThemeMode>(
        tooltip: context.l10n.themeLabel,
        icon: Icon(themeModeIcon(controller.mode)),
        initialValue: controller.mode,
        onSelected: controller.setMode,
        itemBuilder: (context) => [
          for (final mode in ThemeMode.values)
            PopupMenuItem(
              value: mode,
              child: Row(
                children: [
                  Icon(themeModeIcon(mode), size: 20),
                  const SizedBox(width: 12),
                  Text(themeModeLabel(context, mode)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
