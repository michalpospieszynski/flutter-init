import 'dart:async';

import 'package:flutter/foundation.dart';

import 'auth_service.dart';

/// Holds the current user for the whole app and notifies the router and UI.
/// [isReady] turns true after the backend reports the initial state.
class AuthSession extends ChangeNotifier {
  AuthSession(this.service) {
    _subscription = service.authStateChanges.listen(
      _update,
      onError: (Object _) => _update(null),
    );
  }

  final AuthService service;
  late final StreamSubscription<AuthUser?> _subscription;

  AuthUser? _user;
  bool _isReady = false;

  AuthUser? get user => _user;
  bool get isReady => _isReady;
  bool get isSignedIn => _user != null;

  void _update(AuthUser? user) {
    _user = user;
    _isReady = true;
    notifyListeners();
  }

  /// Re-reads the user, e.g. after verifying an email or linking a provider.
  Future<void> refresh() async {
    final fresh = await service.reloadUser();
    if (fresh != null) _update(fresh);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
