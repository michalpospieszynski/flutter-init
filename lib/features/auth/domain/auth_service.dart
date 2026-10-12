import 'auth_method.dart';

/// Thrown when an [AuthMethod] is requested but no backend is wired up yet.
class AuthNotConfiguredException implements Exception {
  const AuthNotConfiguredException(this.method);

  final AuthMethod method;

  @override
  String toString() => 'AuthNotConfiguredException(${method.name})';
}

/// Thrown when a sign-in or account operation fails. [code] is a
/// provider-specific error code (e.g. `wrong-password`).
class AuthFailure implements Exception {
  const AuthFailure(this.code);

  final String code;

  @override
  String toString() => 'AuthFailure($code)';
}

/// Thrown when the email is already registered with another sign-in method.
/// The user must sign in with that existing method; the new method is then
/// linked to the same account automatically.
class AccountLinkRequired implements Exception {
  const AccountLinkRequired({required this.email});

  final String email;

  @override
  String toString() => 'AccountLinkRequired($email)';
}

/// Signed-in user, independent of the auth backend.
class AuthUser {
  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    this.providerIds = const [],
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;

  /// Linked sign-in providers, e.g. `password`, `google.com`, `microsoft.com`.
  final List<String> providerIds;

  bool get usesPassword => providerIds.contains('password');

  /// Best human-readable label for greetings and lists.
  String get label => displayName?.trim().isNotEmpty == true
      ? displayName!.trim()
      : (email ?? uid);
}

/// Contract for authentication. Implement it (e.g. with Firebase Auth) and
/// pass the implementation to the app; the UI does not need to change.
abstract interface class AuthService {
  /// Emits the current user (also after profile or provider changes), or
  /// `null` when signed out.
  Stream<AuthUser?> get authStateChanges;

  /// Starts a social sign-in. Cancelling the flow is not an error.
  Future<void> signIn(AuthMethod method);

  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendPasswordReset(String email);

  Future<void> sendEmailVerification();

  /// Reloads the user from the backend (e.g. after email verification or
  /// linking) and returns the fresh value.
  Future<AuthUser?> reloadUser();

  /// Provider whose sign-in was held back by [AccountLinkRequired]. It can be
  /// linked to the signed-in account with [linkPendingProvider].
  AuthMethod? get pendingLinkMethod;

  Future<void> linkPendingProvider();
}
