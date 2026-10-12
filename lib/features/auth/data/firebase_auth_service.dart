import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../domain/auth_method.dart';
import '../domain/auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  static const _cancelledCodes = {
    'popup-closed-by-user',
    'cancelled-popup-request',
    'web-context-cancelled',
    'web-context-canceled',
  };

  final FirebaseAuth _auth;
  Future<void>? _googleInit;

  /// Provider whose sign-in was rejected because the email already belongs to
  /// another sign-in method. It is linked later via [linkPendingProvider],
  /// while the user is signed in with the existing method.
  AuthMethod? _pendingLinkMethod;

  @override
  AuthMethod? get pendingLinkMethod => _pendingLinkMethod;

  @override
  Stream<AuthUser?> get authStateChanges =>
      _auth.userChanges().map(_toAuthUser);

  @override
  Future<void> signIn(AuthMethod method) async {
    switch (method) {
      case AuthMethod.google:
        await _signInGuard(method, _signInWithGoogle);
      case AuthMethod.microsoft:
        await _signInGuard(method, _signInWithMicrosoft);
      case AuthMethod.email:
        throw AuthNotConfiguredException(method);
    }
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _signInGuard(null, () async {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    });
  }

  @override
  Future<void> createAccountWithEmail({
    required String email,
    required String password,
  }) {
    return _signInGuard(null, () async {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      try {
        await credential.user?.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        debugPrint('Verification email failed: ${e.code}');
      }
    });
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return _guard(() => _auth.sendPasswordResetEmail(email: email));
  }

  @override
  Future<void> sendEmailVerification() {
    return _guard(() async => _auth.currentUser?.sendEmailVerification());
  }

  @override
  Future<AuthUser?> reloadUser() {
    return _guard(() async {
      await _auth.currentUser?.reload();
      return _toAuthUser(_auth.currentUser);
    });
  }

  @override
  Future<void> linkPendingProvider() {
    return _guard(() async {
      final method = _pendingLinkMethod;
      final user = _auth.currentUser;
      if (method == null || user == null) return;
      try {
        await _linkMethod(user, method);
        _pendingLinkMethod = null;
      } on FirebaseAuthException catch (e) {
        if (_cancelledCodes.contains(e.code)) return;
        if (e.code == 'provider-already-linked' ||
            e.code == 'credential-already-in-use') {
          _pendingLinkMethod = null;
          return;
        }
        rethrow;
      } on GoogleSignInException catch (e) {
        if (e.code == GoogleSignInExceptionCode.canceled) return;
        rethrow;
      }
    });
  }

  @override
  Future<void> signOut() {
    return _guard(() async {
      _pendingLinkMethod = null;
      if (!kIsWeb) {
        await _ensureGoogleInitialized();
        await GoogleSignIn.instance.signOut();
      }
      await _auth.signOut();
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      if (kIsWeb) {
        await _auth.signInWithPopup(GoogleAuthProvider());
        return;
      }
      await _ensureGoogleInitialized();
      final account = await GoogleSignIn.instance.authenticate();
      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      rethrow;
    } on FirebaseAuthException catch (e) {
      if (_cancelledCodes.contains(e.code)) return;
      rethrow;
    }
  }

  /// Microsoft Entra ID through Firebase's built-in `microsoft.com` provider.
  /// The tenant and client secret are configured in the Firebase console.
  Future<void> _signInWithMicrosoft() async {
    try {
      if (kIsWeb) {
        await _auth.signInWithPopup(_microsoftProvider());
      } else {
        await _auth.signInWithProvider(_microsoftProvider());
      }
    } on FirebaseAuthException catch (e) {
      if (_cancelledCodes.contains(e.code)) return;
      rethrow;
    }
  }

  OAuthProvider _microsoftProvider() {
    return OAuthProvider('microsoft.com')
      ..addScope('email')
      ..setCustomParameters({'prompt': 'select_account'});
  }

  Future<void> _linkMethod(User user, AuthMethod method) async {
    switch (method) {
      case AuthMethod.google:
        if (kIsWeb) {
          await user.linkWithPopup(GoogleAuthProvider());
          return;
        }
        await _ensureGoogleInitialized();
        final account = await GoogleSignIn.instance.authenticate();
        await user.linkWithCredential(
          GoogleAuthProvider.credential(
            idToken: account.authentication.idToken,
          ),
        );
      case AuthMethod.microsoft:
        if (kIsWeb) {
          await user.linkWithPopup(_microsoftProvider());
        } else {
          await user.linkWithProvider(_microsoftProvider());
        }
      case AuthMethod.email:
        return;
    }
  }

  Future<void> _ensureGoogleInitialized() {
    return _googleInit ??= GoogleSignIn.instance.initialize();
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase auth failed: ${e.code} ${e.message ?? ''}');
      throw AuthFailure(e.code);
    }
  }

  /// Runs a sign-in. If the email already belongs to another provider, the
  /// attempted [method] is remembered for linking and [AccountLinkRequired]
  /// is thrown instead.
  Future<void> _signInGuard(
    AuthMethod? method,
    Future<void> Function() action,
  ) {
    return _guard(() async {
      try {
        await action();
      } on FirebaseAuthException catch (e) {
        if (e.code != 'account-exists-with-different-credential') rethrow;
        _pendingLinkMethod = method;
        throw AccountLinkRequired(email: e.email ?? '');
      }
    });
  }

  AuthUser? _toAuthUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      providerIds: [for (final p in user.providerData) p.providerId],
    );
  }
}
