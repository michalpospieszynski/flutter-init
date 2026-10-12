import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('404', style: theme.textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(l10n.notFoundTitle, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                l10n.notFoundBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: () => context.go(AppRoutes.landing),
                label: l10n.notFoundAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
