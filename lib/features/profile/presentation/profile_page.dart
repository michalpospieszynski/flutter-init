import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/page_body.dart';
import '../../auth/presentation/account_notices.dart';
import '../../auth/presentation/auth_labels.dart';
import '../../auth/presentation/provider_marks.dart';
import '../../auth/presentation/user_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.appColors;
    final scope = AppScope.of(context);

    return ListenableBuilder(
      listenable: scope.session,
      builder: (context, _) {
        final user = scope.session.user;
        if (user == null) return const SizedBox.shrink();
        final verified = user.emailVerified || !user.usesPassword;

        return PageBody(
          child: FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountNotices(user: user),
                Semantics(
                  header: true,
                  child: Text(
                    l10n.profileTitle,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        UserAvatar(user: user, radius: 32),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.label,
                                style: theme.textTheme.titleLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (user.email != null &&
                                  user.email != user.label)
                                Text(
                                  user.email!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    verified
                                        ? Icons.verified_outlined
                                        : Icons.error_outline_rounded,
                                    size: 16,
                                    color: verified
                                        ? colors.success
                                        : colors.warning,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      verified
                                          ? l10n.profileEmailVerified
                                          : l10n.profileEmailNotVerified,
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.profileProviders, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  child: Column(
                    children: [
                      for (var i = 0; i < user.providerIds.length; i++) ...[
                        if (i > 0) const Divider(),
                        ListTile(
                          leading: providerIcon(user.providerIds[i]),
                          title: Text(providerLabel(l10n, user.providerIds[i])),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppButton(
                    style: AppButtonStyle.outlined,
                    icon: const Icon(Icons.logout_rounded, size: 20),
                    onPressed: scope.authService.signOut,
                    label: l10n.authSignOut,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
