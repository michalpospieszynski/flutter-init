import 'package:flutter/material.dart';
import 'package:flutter_init/app.dart';
import 'package:flutter_init/core/config/app_config.dart';
import 'package:flutter_init/core/theme/theme_controller.dart';
import 'package:flutter_init/features/auth/data/noop_auth_service.dart';
import 'package:flutter_init/features/auth/domain/auth_method.dart';
import 'package:flutter_init/features/auth/domain/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_service.dart';

const _signedInUser = AuthUser(
  uid: 'u1',
  email: 'ada@example.com',
  displayName: 'Ada Lovelace',
  emailVerified: true,
  providerIds: ['google.com'],
);

Future<void> pumpApp(
  WidgetTester tester, {
  AuthService authService = const NoopAuthService(),
  ThemeController? themeController,
  Size size = const Size(1200, 2000),
  AppConfig config = const AppConfig(author: 'Ada Author'),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    App(
      authService: authService,
      themeController: themeController,
      config: config,
    ),
  );
  await tester.pumpAndSettle();
}

Finder inRail(String text) =>
    find.descendant(of: find.byType(NavigationRail), matching: find.text(text));

void main() {
  group('Landing', () {
    testWidgets('shows localized content and switches language', (
      tester,
    ) async {
      await pumpApp(tester);

      expect(find.text('One secure sign-in. Every device.'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);

      await tester.tap(find.text('PL'));
      await tester.pumpAndSettle();

      expect(
        find.text('Jedno bezpieczne logowanie. Każde urządzenie.'),
        findsOneWidget,
      );
      expect(find.text('Kontynuuj z Google'), findsOneWidget);
      expect(find.text('One secure sign-in. Every device.'), findsNothing);
    });

    testWidgets('footer shows localized copyright; legal links are in-app', (
      tester,
    ) async {
      await pumpApp(tester);

      // Legal links live on the sign-in card, not in the footer.
      expect(find.text('Privacy Policy'), findsOneWidget);
      expect(find.text('Terms of Service'), findsOneWidget);
      expect(find.textContaining('Ada Author'), findsOneWidget);
      expect(find.textContaining('All rights reserved.'), findsOneWidget);

      await tester.tap(find.text('PL'));
      await tester.pumpAndSettle();

      expect(find.text('Polityka prywatności'), findsOneWidget);
      expect(
        find.textContaining('Wszelkie prawa zastrzeżone.'),
        findsOneWidget,
      );
    });

    testWidgets('shows only the configured contact details that are set', (
      tester,
    ) async {
      await pumpApp(
        tester,
        config: AppConfig.parse(
          'author: Ada\nemail: ada@example.com\nphone: ""\ngithub: "  "\n',
        ),
      );

      expect(find.text('ada@example.com'), findsOneWidget);
      expect(find.text('GitHub'), findsNothing);
      expect(find.text('LinkedIn'), findsNothing);
    });

    testWidgets('app name in the header comes from the config', (tester) async {
      await pumpApp(tester, config: const AppConfig(appName: 'Keystone'));

      expect(find.text('Keystone'), findsOneWidget);
      expect(find.text('Aurora'), findsNothing);
    });

    testWidgets('lays out on a narrow phone screen without overflow', (
      tester,
    ) async {
      await pumpApp(tester, size: const Size(360, 780));

      expect(find.text('Continue with Google'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('Sign-in card', () {
    testWidgets('tells the user auth is not connected yet', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Continue with Microsoft'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Authentication is not connected yet. It will be available soon.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('validates required fields', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('This field is required.'), findsNWidgets(2));
    });

    testWidgets('rejects malformed email and short new passwords', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.text('No account yet? Create one'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(0), 'not-an-email');
      await tester.enterText(find.byType(TextFormField).at(1), '123');
      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid email address.'), findsOneWidget);
      expect(find.text('Use at least 6 characters.'), findsOneWidget);
    });

    testWidgets('shows an inline message for wrong credentials', (
      tester,
    ) async {
      await pumpApp(tester, authService: FakeAuthService());

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'ada@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'wrong');
      await tester.tap(find.text('Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('Incorrect email or password.'), findsOneWidget);
    });

    testWidgets('password visibility can be toggled', (tester) async {
      await pumpApp(tester);

      EditableText field() =>
          tester.widget<EditableText>(find.byType(EditableText).at(1));
      expect(field().obscureText, isTrue);

      await tester.tap(find.byTooltip('Show password'));
      await tester.pump();

      expect(field().obscureText, isFalse);
    });
  });

  group('Signed in', () {
    testWidgets('shows the dashboard and navigates to profile and settings', (
      tester,
    ) async {
      await pumpApp(tester, authService: FakeAuthService(user: _signedInUser));

      expect(find.text('Welcome back, Ada Lovelace'), findsOneWidget);
      expect(find.byType(NavigationRail), findsOneWidget);

      await tester.tap(inRail('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('ada@example.com'), findsOneWidget);
      expect(find.text('Google'), findsOneWidget);

      await tester.tap(inRail('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Appearance'), findsOneWidget);
    });

    testWidgets('uses bottom navigation on narrow screens', (tester) async {
      await pumpApp(
        tester,
        authService: FakeAuthService(user: _signedInUser),
        size: const Size(390, 844),
      );

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('switches theme from settings', (tester) async {
      final theme = ThemeController();
      await pumpApp(
        tester,
        authService: FakeAuthService(user: _signedInUser),
        themeController: theme,
      );

      await tester.tap(inRail('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();

      expect(theme.mode, ThemeMode.light);
    });

    testWidgets('sign out returns to the landing page', (tester) async {
      await pumpApp(tester, authService: FakeAuthService(user: _signedInUser));

      await tester.tap(inRail('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sign out'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('asks password users to verify their email', (tester) async {
      final auth = FakeAuthService(
        user: const AuthUser(
          uid: 'u2',
          email: 'new@example.com',
          providerIds: ['password'],
        ),
      );
      await pumpApp(tester, authService: auth);

      expect(find.text('Verify your email'), findsOneWidget);

      await tester.tap(find.text('Resend email'));
      await tester.pumpAndSettle();

      expect(auth.verificationEmails, 1);
    });

    testWidgets('offers to link a provider blocked at sign-in', (tester) async {
      final auth = FakeAuthService(
        user: _signedInUser,
        pending: AuthMethod.microsoft,
      );
      await pumpApp(tester, authService: auth);

      expect(find.text('Link your Microsoft account'), findsOneWidget);

      await tester.tap(find.text('Link Microsoft account'));
      await tester.pumpAndSettle();

      expect(auth.linkCalls, 1);
      expect(find.text('Link your Microsoft account'), findsNothing);
    });
  });
}
