import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../domain/auth_method.dart';
import '../domain/auth_service.dart';
import 'provider_marks.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({super.key, required this.authService});

  final AuthService authService;

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool _busy = false;

  Future<void> _signIn(AuthMethod method) async {
    final messenger = ScaffoldMessenger.of(context);
    final notConfiguredMessage = context.l10n.authNotConfigured;
    setState(() => _busy = true);
    try {
      await widget.authService.signIn(method);
    } on AuthNotConfiguredException {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(notConfiguredMessage),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final onPressed = _busy ? null : _signIn;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.authTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.authSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: onPressed == null
                  ? null
                  : () => onPressed(AuthMethod.google),
              icon: const GoogleMark(),
              label: Text(l10n.continueWithGoogle),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onPressed == null
                  ? null
                  : () => onPressed(AuthMethod.microsoft),
              icon: const MicrosoftMark(),
              label: Text(l10n.continueWithMicrosoft),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.authDivider,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onPressed == null
                  ? null
                  : () => onPressed(AuthMethod.email),
              icon: const Icon(Icons.mail_outline_rounded, size: 20),
              label: Text(l10n.createAccountWithEmail),
            ),
          ],
        ),
      ),
    );
  }
}
