import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../home/presentation/app_bar_actions.dart';
import '../../home/presentation/app_wordmark.dart';

/// Signed-in frame: bottom navigation on narrow screens, a rail on wide ones.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _select(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isWide = MediaQuery.sizeOf(context).width >= AppBreakpoints.wide;

    final destinations = [
      (Icons.home_outlined, Icons.home_rounded, l10n.navHome),
      (Icons.person_outline_rounded, Icons.person_rounded, l10n.navProfile),
      (Icons.settings_outlined, Icons.settings_rounded, l10n.navSettings),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const AppWordmark(),
        actions: const [AppBarActions()],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _select,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.$1),
                    selectedIcon: Icon(d.$2),
                    label: Text(d.$3),
                  ),
              ],
            ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _select,
              destinations: [
                for (final d in destinations)
                  NavigationDestination(
                    icon: Icon(d.$1),
                    selectedIcon: Icon(d.$2),
                    label: d.$3,
                  ),
              ],
            ),
    );
  }
}
