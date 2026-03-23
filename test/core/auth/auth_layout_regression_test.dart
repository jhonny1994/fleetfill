import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SignUpScreen stays scroll-safe on compact devices', (
    tester,
  ) async {
    await _setCompactViewport(tester);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutePath.signIn,
          builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appEnvironmentConfigProvider.overrideWithValue(
            const AppEnvironmentConfig(environment: AppEnvironment.local),
          ),
        ],
        child: _LocalizedRouterApp(router: router),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('WelcomeScreen stays scroll-safe on compact devices', (
    tester,
  ) async {
    await _setCompactViewport(tester);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const WelcomeScreen(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          effectiveLocaleProvider.overrideWithValue(const Locale('ar')),
          availableLocalesProvider.overrideWithValue(const <Locale>[
            Locale('ar'),
            Locale('fr'),
            Locale('en'),
          ]),
        ],
        child: _LocalizedRouterApp(router: router),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<void> _setCompactViewport(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(393, 852);
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

class _LocalizedRouterApp extends StatelessWidget {
  const _LocalizedRouterApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      locale: const Locale('ar'),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
