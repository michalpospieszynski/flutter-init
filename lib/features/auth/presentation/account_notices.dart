import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/inline_banner.dart';
import '../domain/auth_service.dart';
import 'auth_labels.dart';

/// Banners that ask the signed-in user to finish account setup: verify the
/// email, or link a provider that was blocked by an existing account.
class AccountNotices extends StatefulWidget {
  const AccountNotices({super.key, required this.user});

  final AuthUser user;

  @override
  State<AccountNotices> createState() => _AccountNoticesState();
}

class _AccountNoticesState extends State<AccountNotices> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() task) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      await task();
    } on AuthFailure catch (e) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(authErrorMessage(l10n, e.code))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scope = AppScope.of(context);
    final user = widget.user;
    final pending = scope.authService.pendingLinkMethod;
    final needsVerification = user.usesPassword && !user.emailVerified;

    if (pending == null && !needsVerification) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (needsVerification)
            InlineBanner(
              kind: BannerKind.warning,
              title: l10n.authVerifyTitle,
              message: l10n.authVerifyBody(user.email ?? ''),
              actions: [
                AppButton(
                  style: AppButtonStyle.outlined,
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          await scope.authService.sendEmailVerification();
                          _toast(l10n.authVerifySent);
                        }),
                  label: l10n.authVerifyResend,
                ),
                AppButton(
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          await scope.session.refresh();
                          if (!mounted) return;
                          if (!(scope.session.user?.emailVerified ?? false)) {
                            _toast(l10n.authVerifyStillPending);
                          }
                        }),
                  label: l10n.authVerifyConfirm,
                ),
              ],
            ),
          if (needsVerification && pending != null)
            const SizedBox(height: AppSpacing.md),
          if (pending != null)
            InlineBanner(
              kind: BannerKind.info,
              title: l10n.authLinkTitle(methodLabel(l10n, pending)),
              message: l10n.authLinkBody(methodLabel(l10n, pending)),
              actions: [
                AppButton(
                  busy: _busy,
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          await scope.authService.linkPendingProvider();
                          await scope.session.refresh();
                          if (!mounted) return;
                          if (scope.authService.pendingLinkMethod == null) {
                            _toast(l10n.authLinked(methodLabel(l10n, pending)));
                          }
                        }),
                  label: l10n.authLinkAccount(methodLabel(l10n, pending)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
