import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/features/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LegalPoliciesScreen renders key production disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('en'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const LegalPoliciesScreen(),
        ),
      ),
    );

    final context = tester.element(find.byType(LegalPoliciesScreen));
    final s = S.of(context);

    expect(find.text(s.legalPoliciesTitle), findsAtLeastNWidgets(1));
    expect(find.text(s.legalTermsTitle), findsAtLeastNWidgets(1));
    expect(find.text(s.legalPrivacyTitle), findsAtLeastNWidgets(1));
  });
}
