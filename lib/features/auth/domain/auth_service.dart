import 'auth_method.dart';

/// Thrown when an [AuthMethod] is requested but no backend is wired up yet.
class AuthNotConfiguredException implements Exception {
  const AuthNotConfiguredException(this.method);

  final AuthMethod method;

  @override
  String toString() => 'AuthNotConfiguredException(${method.name})';
}

/// Contract for authentication. Implement it (e.g. with Firebase Auth) and
/// pass the implementation to the app; the UI does not need to change.
abstract interface class AuthService {
  Future<void> signIn(AuthMethod method);
}
