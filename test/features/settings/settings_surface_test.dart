import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('SettingsScreen keeps language, theme, support, and policy surfaces reachable', (
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
    final listView = find.byType(ListView).first;
    final cardTitles = <String>{};

    for (var i = 0; i < 6; i++) {
      cardTitles.addAll(
        tester
            .widgetList<AppListCard>(find.byType(AppListCard))
            .map((card) => card.title),
      );
      await tester.drag(listView, const Offset(0, -300));
      await tester.pumpAndSettle();
    }

    for (final label in [
      s.languageSelectionTitle,
      s.settingsThemeModeTitle,
      s.notificationsPermissionTitle,
      s.notificationsCenterTitle,
      s.supportTitle,
      s.legalPoliciesTitle,
    ]) {
      expect(cardTitles, contains(label));
    }
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
