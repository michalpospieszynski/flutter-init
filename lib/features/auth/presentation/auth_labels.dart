import '../../../l10n/generated/app_localizations.dart';
import '../domain/auth_method.dart';

/// Maps a backend error [code] to a message the user can act on.
String authErrorMessage(AppLocalizations l10n, String code) {
  return switch (code) {
    'invalid-credential' ||
    'wrong-password' ||
    'user-not-found' ||
    'invalid-login-credentials' => l10n.authErrorInvalidCredentials,
    'email-already-in-use' => l10n.authErrorEmailInUse,
    'weak-password' => l10n.authErrorWeakPassword,
    'invalid-email' => l10n.authErrorInvalidEmail,
    'too-many-requests' => l10n.authErrorTooManyRequests,
    'network-request-failed' => l10n.authErrorNetwork,
    'popup-blocked' => l10n.authErrorPopupBlocked,
    'user-disabled' => l10n.authErrorUserDisabled,
    'operation-not-allowed' ||
    'operation-not-supported-in-this-environment' => l10n.authErrorNotEnabled,
    _ => l10n.authFailed,
  };
}

String providerLabel(AppLocalizations l10n, String providerId) {
  return switch (providerId) {
    'google.com' => l10n.providerGoogle,
    'microsoft.com' => l10n.providerMicrosoft,
    'password' => l10n.providerPassword,
    _ => providerId,
  };
}

String methodLabel(AppLocalizations l10n, AuthMethod method) {
  return switch (method) {
    AuthMethod.google => l10n.providerGoogle,
    AuthMethod.microsoft => l10n.providerMicrosoft,
    AuthMethod.email => l10n.providerPassword,
  };
}
