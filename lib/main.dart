import 'package:flutter/material.dart';

import 'app.dart';
import 'features/auth/data/noop_auth_service.dart';

void main() {
  runApp(const App(authService: NoopAuthService()));
}
