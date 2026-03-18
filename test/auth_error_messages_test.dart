import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('maps known auth backend errors to localized messages', (
    tester,
  ) async {
    late S s;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Builder(
          builder: (context) {
            s = S.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(
      mapAuthErrorMessage(s, 'authentication_required'),
      s.authAuthenticationRequiredMessage,
    );
    expect(
      mapAuthErrorMessage(s, 'Invalid login credentials'),
      s.authInvalidCredentialsMessage,
    );
    expect(
      mapAuthErrorMessage(s, 'Email not confirmed'),
      s.authEmailNotConfirmedMessage,
    );
    expect(
      mapAuthErrorMessage(s, 'User already registered'),
      s.authUserAlreadyRegisteredMessage,
    );
    expect(mapAuthErrorMessage(s, 'network timeout'), s.authNetworkErrorMessage);
    expect(
      mapAuthErrorMessage(s, 'unknown failure code'),
      s.authGenericErrorMessage,
    );
  });
}
