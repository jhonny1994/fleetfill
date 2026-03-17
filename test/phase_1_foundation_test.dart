import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestApp({
  required Widget child,
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: S.delegate.supportedLocales,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(body: child),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 1 localization foundation', () {
    testWidgets('uses generated supported locales', (tester) async {
      expect(
        S.delegate.supportedLocales.map((locale) => locale.languageCode),
        <String>['en', 'ar', 'fr'],
      );
    });

    test('falls back to English when locale is unsupported', () {
      expect(
        AppLocaleResolver.resolve(const Locale('es')),
        const Locale('en'),
      );
    });

    test('wraps operational identifiers in bidi-safe isolates', () {
      final expected =
          '${String.fromCharCode(0x2066)}BK-12345${String.fromCharCode(0x2069)}';

      expect(BidiFormatters.trackingId('BK-12345'), expected);
    });

    test('formats prices with bidi-safe latin output', () {
      final value = BidiFormatters.price(12500, locale: 'ar');

      expect(value.startsWith(String.fromCharCode(0x2066)), isTrue);
      expect(value.endsWith(String.fromCharCode(0x2069)), isTrue);
      expect(value.contains('DZD'), isTrue);
    });
  });

  group('Phase 1 accessibility foundation', () {
    testWidgets('page state widgets expose user-facing localized copy', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(child: const AppVerificationGateState()),
      );

      expect(find.text('Verification required'), findsOneWidget);
      expect(
        find.text('Complete the required verification steps before continuing.'),
        findsOneWidget,
      );
    });

    testWidgets('forbidden state can show admin step-up guidance', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          child: AppForbiddenState(
            message: S.current.forbiddenAdminStepUpMessage,
          ),
        ),
      );

      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      expect(find.text(S.current.forbiddenAdminStepUpMessage), findsOneWidget);
    });

    testWidgets('offline banner remains readable at large text scale', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.8)),
          child: buildTestApp(child: const AppOfflineBanner()),
        ),
      );

      expect(
        find.text('You are offline. Some actions are temporarily unavailable.'),
        findsOneWidget,
      );
    });

    testWidgets('navigation destinations keep accessible nav controls', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          child: AppShellScaffold(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            body: const SizedBox.shrink(),
            destinations: const [
              AppShellDestination(icon: Icons.home_outlined, label: 'Home'),
            ],
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
