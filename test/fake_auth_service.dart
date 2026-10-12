import 'dart:async';

import 'package:flutter_init/features/auth/domain/auth_method.dart';
import 'package:flutter_init/features/auth/domain/auth_service.dart';

/// In-memory [AuthService] for widget tests.
class FakeAuthService implements AuthService {
  FakeAuthService({this._user, this.pending});

  final _changes = StreamController<AuthUser?>.broadcast();
  AuthUser? _user;
  AuthMethod? pending;

  int linkCalls = 0;
  int verificationEmails = 0;

  @override
  Stream<AuthUser?> get authStateChanges async* {
    yield _user;
    yield* _changes.stream;
  }

  @override
  AuthMethod? get pendingLinkMethod => pending;

  @override
  Future<void> linkPendingProvider() async {
    linkCalls++;
    pending = null;
  }

  @override
  Future<void> signIn(AuthMethod method) async {}

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (password == 'wrong') throw const AuthFailure('invalid-credential');
    _emit(AuthUser(uid: 'u1', email: email, emailVerified: true));
  }

  @override
  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    _emit(AuthUser(uid: 'u1', email: email, providerIds: const ['password']));
  }

  @override
  Future<void> signOut() async => _emit(null);

  @override
  Future<void> sendPasswordReset(String email) async {}

  @override
  Future<void> sendEmailVerification() async => verificationEmails++;

  @override
  Future<AuthUser?> reloadUser() async => _user;

  void _emit(AuthUser? user) {
    _user = user;
    _changes.add(user);
  }
}
