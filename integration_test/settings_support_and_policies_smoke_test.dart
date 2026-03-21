import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/theme/theme_controller.dart';
import 'package:fleetfill/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('settings keeps support and policy surfaces reachable', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(const <String, Object>{});
    final sharedPreferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          secureStorageProvider.overrideWithValue(const FlutterSecureStorage()),
          appEnvironmentConfigProvider.overrideWithValue(
            const AppEnvironmentConfig(environment: AppEnvironment.local),
          ),
          initialThemeModeProvider.overrideWithValue(ThemeMode.light),
          initialLocaleProvider.overrideWithValue(const Locale('en')),
          authSessionControllerProvider.overrideWith(
            _FakeAuthSessionController.new,
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final context = tester.element(find.byType(SettingsScreen));
    final s = S.of(context);

    expect(find.text(s.supportTitle), findsOneWidget);
    expect(find.text(s.legalPoliciesTitle), findsOneWidget);
  });
}

class _FakeAuthSessionController extends AuthSessionController {
  @override
  Future<AuthSnapshot> build() async {
    return const AuthSnapshot(
      status: AuthStatus.authenticated,
      userId: 'user-1',
      email: 'shipper@example.com',
      role: AppUserRole.shipper,
      hasCompletedOnboarding: true,
      hasPhoneNumber: true,
    );
  }
}
