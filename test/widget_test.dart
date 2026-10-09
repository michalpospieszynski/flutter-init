import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_init/app.dart';
import 'package:flutter_init/features/auth/data/noop_auth_service.dart';

Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const App(authService: NoopAuthService()));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Shows localized content and switches language', (tester) async {
    await pumpApp(tester);

    expect(find.text('Build your next idea, faster.'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);

    await tester.tap(find.text('PL'));
    await tester.pumpAndSettle();

    expect(find.text('Zbuduj swój następny pomysł szybciej.'), findsOneWidget);
    expect(find.text('Kontynuuj z Google'), findsOneWidget);
    expect(find.text('Build your next idea, faster.'), findsNothing);
  });

  testWidgets('Footer shows legal links and localized copyright', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
    expect(find.textContaining('All rights reserved.'), findsOneWidget);

    await tester.tap(find.text('PL'));
    await tester.pumpAndSettle();

    expect(find.text('Polityka prywatności'), findsOneWidget);
    expect(find.textContaining('Wszelkie prawa zastrzeżone.'), findsOneWidget);
  });

  testWidgets('Auth buttons tell the user auth is not connected yet', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Continue with Microsoft'));
    await tester.pump();

    expect(
      find.text(
        'Authentication is not connected yet. It will be available soon.',
      ),
      findsOneWidget,
    );
  });
}
