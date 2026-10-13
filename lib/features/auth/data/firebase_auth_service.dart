import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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

  static const _microsoftClientId = '72b99c5d-ac6f-42c0-a82d-1029e399ebcc';
  static const _microsoftTenant = 'common';
  static const _microsoftCallbackScheme = 'flutterinit';
  static const _microsoftRedirectUrl =
      '$_microsoftCallbackScheme://oauth2redirect';
  static const _microsoftScopes = 'openid profile email offline_access';

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
      } on PlatformException catch (e) {
        if (e.code == 'CANCELED') return;
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
  /// On web Firebase handles the popup. On mobile the browser is opened by
  /// flutter_web_auth_2, which returns to the app directly (Firebase's redirect
  /// page fails on Android), and the resulting token is passed to Firebase.
  Future<void> _signInWithMicrosoft() async {
    try {
      await _auth.signInWithProvider(_microsoftProvider());
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

  /// Authorization code flow with PKCE. The browser returns the callback URL
  /// directly to the app, and the code is exchanged for tokens here.
  Future<OAuthCredential> _microsoftMobileCredential() async {
    final verifier = _randomUrlSafe(64);
    final challenge = base64UrlEncode(
      sha256.convert(utf8.encode(verifier)).bytes,
    ).replaceAll('=', '');
    final state = _randomUrlSafe(32);
    final rawNonce = _randomUrlSafe(32);
    final nonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final authorizeUrl = Uri.https(
      'login.microsoftonline.com',
      '/$_microsoftTenant/oauth2/v2.0/authorize',
      {
        'client_id': _microsoftClientId,
        'response_type': 'code',
        'redirect_uri': _microsoftRedirectUrl,
        'response_mode': 'query',
        'scope': _microsoftScopes,
        'state': state,
        'nonce': nonce,
        'code_challenge': challenge,
        'code_challenge_method': 'S256',
        'prompt': 'select_account',
      },
    );

    final callbackUrl = await FlutterWebAuth2.authenticate(
      url: authorizeUrl.toString(),
      callbackUrlScheme: _microsoftCallbackScheme,
    );
    final params = Uri.parse(callbackUrl).queryParameters;
    if (params['error'] != null) {
      throw FirebaseAuthException(
        code: 'microsoft-auth-failed',
        message: params['error_description'] ?? params['error'],
      );
    }
    if (params['state'] != state) {
      throw FirebaseAuthException(code: 'microsoft-invalid-state');
    }
    final code = params['code'];
    if (code == null) {
      throw FirebaseAuthException(code: 'microsoft-missing-code');
    }

    final response = await http.post(
      Uri.https(
        'login.microsoftonline.com',
        '/$_microsoftTenant/oauth2/v2.0/token',
      ),
      body: {
        'client_id': _microsoftClientId,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': _microsoftRedirectUrl,
        'code_verifier': verifier,
        'scope': _microsoftScopes,
      },
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw FirebaseAuthException(
        code: 'microsoft-token-failed',
        message:
            json['error_description'] as String? ?? json['error'] as String?,
      );
    }
    return _microsoftProvider().credential(
      idToken: json['id_token'] as String?,
      rawNonce: rawNonce,
    );
  }

  static String _randomUrlSafe(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
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
        await user.linkWithProvider(_microsoftProvider());
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
