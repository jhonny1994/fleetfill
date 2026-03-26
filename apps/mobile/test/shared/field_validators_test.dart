import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/validation/field_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shared field validators enforce required and numeric rules', (
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

    expect(validateRequiredField(s, '   '), s.authRequiredFieldMessage);
    expect(
      validatePositiveNumberField(
        s,
        '-1',
        invalidMessage: s.vehiclePositiveNumberMessage,
      ),
      s.vehiclePositiveNumberMessage,
    );
    expect(
      validateOptionalPositiveNumberField(
        s,
        '',
        invalidMessage: s.vehiclePositiveNumberMessage,
      ),
      isNull,
    );
    expect(
      validatePositiveNumberField(
        s,
        '14',
        invalidMessage: s.vehiclePositiveNumberMessage,
      ),
      isNull,
    );
  });
}
