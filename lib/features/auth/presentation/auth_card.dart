import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/inline_banner.dart';
import '../domain/auth_method.dart';
import '../domain/auth_service.dart';
import 'auth_labels.dart';
import 'provider_marks.dart';

enum _AuthAction { google, microsoft, email, reset }

/// Sign-in / create-account card shown to signed-out users.
class AuthCard extends StatefulWidget {
  const AuthCard({super.key, required this.authService});

  final AuthService authService;

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  static const _minPasswordLength = 6;
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState<String>>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Which action is running, so only that button shows a spinner.
  _AuthAction? _busyAction;
  bool _creatingAccount = false;
  String? _message;
  BannerKind _messageKind = BannerKind.error;

  bool get _busy => _busyAction != null;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _run(_AuthAction action, Future<void> Function() task) async {
    final l10n = context.l10n;
    setState(() {
      _busyAction = action;
      _message = null;
    });
    try {
      await task();
    } on AuthNotConfiguredException {
      _setMessage(l10n.authNotConfigured, BannerKind.info);
    } on AccountLinkRequired {
      _setMessage(l10n.authAccountLinkRequired, BannerKind.info);
    } on AuthFailure catch (e) {
      _setMessage(authErrorMessage(l10n, e.code), BannerKind.error);
    } finally {
      if (mounted) setState(() => _busyAction = null);
    }
  }

  void _setMessage(String text, BannerKind kind) {
    if (!mounted) return;
    setState(() {
      _message = text;
      _messageKind = kind;
    });
  }

  void _submitEmail() {
    if (_busy || !(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    _run(
      _AuthAction.email,
      () => _creatingAccount
          ? widget.authService.createAccountWithEmail(
              email: email,
              password: password,
            )
          : widget.authService.signInWithEmail(
              email: email,
              password: password,
            ),
    );
  }

  Future<void> _forgotPassword() async {
    if (_busy || !(_emailKey.currentState?.validate() ?? false)) return;
    final l10n = context.l10n;
    final email = _emailController.text.trim();
    await _run(_AuthAction.reset, () async {
      await widget.authService.sendPasswordReset(email);
      _setMessage(l10n.authResetSent(email), BannerKind.success);
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.authFieldRequired;
    }
    return null;
  }

  String? _emailValidator(String? value) {
    final required = _requiredValidator(value);
    if (required != null) return required;
    if (!_emailPattern.hasMatch(value!.trim())) {
      return context.l10n.authInvalidEmail;
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    final required = _requiredValidator(value);
    if (required != null) return required;
    if (_creatingAccount && value!.length < _minPasswordLength) {
      return context.l10n.authPasswordTooShort;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CardHeader(),
            const SizedBox(height: AppSpacing.lg),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: _message == null
                  ? const SizedBox(width: double.infinity)
                  : Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: InlineBanner(
                        kind: _messageKind,
                        message: _message!,
                      ),
                    ),
            ),
            AppButton(
              style: AppButtonStyle.outlined,
              busy: _busyAction == _AuthAction.google,
              onPressed: _busy
                  ? null
                  : () => _run(
                      _AuthAction.google,
                      () => widget.authService.signIn(AuthMethod.google),
                    ),
              icon: const GoogleMark(),
              label: l10n.continueWithGoogle,
            ),
            const SizedBox(height: 12),
            AppButton(
              style: AppButtonStyle.outlined,
              busy: _busyAction == _AuthAction.microsoft,
              onPressed: _busy
                  ? null
                  : () => _run(
                      _AuthAction.microsoft,
                      () => widget.authService.signIn(AuthMethod.microsoft),
                    ),
              icon: const MicrosoftMark(),
              label: l10n.continueWithMicrosoft,
            ),
            const SizedBox(height: AppSpacing.lg - 4),
            _Divider(label: l10n.authDivider),
            const SizedBox(height: AppSpacing.lg - 4),
            _emailForm(),
          ],
        ),
      ),
    );
  }

  Widget _emailForm() {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              fieldKey: _emailKey,
              controller: _emailController,
              label: l10n.authEmailLabel,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              validator: _emailValidator,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _passwordController,
              label: l10n.authPasswordLabel,
              obscure: true,
              autofillHints: [
                _creatingAccount
                    ? AutofillHints.newPassword
                    : AutofillHints.password,
              ],
              textInputAction: TextInputAction.done,
              validator: _passwordValidator,
              onSubmitted: (_) => _submitEmail(),
            ),
            if (!_creatingAccount)
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  style: AppButtonStyle.text,
                  busy: _busyAction == _AuthAction.reset,
                  onPressed: _busy ? null : _forgotPassword,
                  label: l10n.authForgotPassword,
                ),
              )
            else
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            AppButton(
              busy: _busyAction == _AuthAction.email,
              onPressed: _busy ? null : _submitEmail,
              label: _creatingAccount
                  ? l10n.authCreateAccount
                  : l10n.authSignInWithEmail,
            ),
            const SizedBox(height: 4),
            AppButton(
              style: AppButtonStyle.text,
              onPressed: _busy
                  ? null
                  : () => setState(() {
                      _creatingAccount = !_creatingAccount;
                      _message = null;
                      _formKey.currentState?.reset();
                    }),
              label: _creatingAccount
                  ? l10n.authSwitchToSignIn
                  : l10n.authSwitchToCreate,
            ),
          ],
        ),
      ),
    );
  }
}

/// Static title block, const so card state changes never rebuild it.
class _CardHeader extends StatelessWidget {
  const _CardHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.authTitle, style: theme.textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          l10n.authSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
