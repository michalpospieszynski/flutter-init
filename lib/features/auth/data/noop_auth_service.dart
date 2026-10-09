import '../domain/auth_method.dart';
import '../domain/auth_service.dart';

/// Placeholder used until Firebase is integrated.
class NoopAuthService implements AuthService {
  const NoopAuthService();

  @override
  Future<void> signIn(AuthMethod method) async {
    throw AuthNotConfiguredException(method);
  }
}
