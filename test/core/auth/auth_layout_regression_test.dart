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
            const AppEnvironmentConfig(
              supabaseUrl: 'http://127.0.0.1:54321',
            ),
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

  testWidgets('SignUpScreen routes to confirm-email flow after signup', (
    tester,
  ) async {
    await _setCompactViewport(tester);
    final repository = _FakeAuthRepository(needsConfirmation: true);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutePath.confirmEmail,
          builder: (context, state) => ConfirmEmailScreen(
            email: state.uri.queryParameters['email'],
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          appEnvironmentConfigProvider.overrideWithValue(
            const AppEnvironmentConfig(
              supabaseUrl: 'http://127.0.0.1:54321',
            ),
          ),
        ],
        child: _LocalizedRouterApp(router: router),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'Password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'Password123');
    await tester.tap(find.widgetWithText(FilledButton, 'إنشاء حساب'));
    await tester.pumpAndSettle();

    expect(find.text('فعّل بريدك الإلكتروني'), findsOneWidget);
    expect(find.text('user@example.com'), findsOneWidget);
    expect(repository.lastSignUpEmail, 'user@example.com');
  });

  testWidgets('ForgotPasswordScreen routes to reset-email-sent flow', (
    tester,
  ) async {
    await _setCompactViewport(tester);
    final repository = _FakeAuthRepository();

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: AppRoutePath.resetPasswordSent,
          builder: (context, state) => PasswordResetEmailSentScreen(
            email: state.uri.queryParameters['email'],
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          appEnvironmentConfigProvider.overrideWithValue(
            const AppEnvironmentConfig(
              supabaseUrl: 'http://127.0.0.1:54321',
            ),
          ),
        ],
        child: _LocalizedRouterApp(router: router),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'user@example.com');
    await tester.tap(
      find.widgetWithText(FilledButton, 'إرسال رابط إعادة التعيين'),
    );
    await tester.pumpAndSettle();

    expect(find.text('افتح بريدك الإلكتروني'), findsOneWidget);
    expect(find.text('user@example.com'), findsOneWidget);
    expect(repository.lastResetEmail, 'user@example.com');
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

class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.needsConfirmation = false})
    : super(
        environment: const AppEnvironmentConfig(),
        googleAuthClient: const NativeGoogleAuthClient(),
      );

  final bool needsConfirmation;
  String? lastSignUpEmail;
  String? lastResetEmail;

  @override
  Future<bool> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    lastSignUpEmail = email;
    return needsConfirmation;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    lastResetEmail = email;
  }
}
