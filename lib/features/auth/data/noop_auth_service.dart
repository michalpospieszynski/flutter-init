import '../domain/auth_method.dart';
import '../domain/auth_service.dart';

/// Placeholder for tests and previews that must not reach a real backend.
class NoopAuthService implements AuthService {
  const NoopAuthService();

  @override
  Stream<AuthUser?> get authStateChanges => Stream.value(null);

  @override
  Future<void> signIn(AuthMethod method) async {
    throw AuthNotConfiguredException(method);
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    throw const AuthNotConfiguredException(AuthMethod.email);
  }

  @override
  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    throw const AuthNotConfiguredException(AuthMethod.email);
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordReset(String email) async {
    throw const AuthNotConfiguredException(AuthMethod.email);
  }

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<AuthUser?> reloadUser() async => null;

  @override
  AuthMethod? get pendingLinkMethod => null;

  @override
  Future<void> linkPendingProvider() async {}
}
