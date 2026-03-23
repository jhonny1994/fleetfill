import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfileDetailsFormFields validates required inputs', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    var submitted = false;

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
        home: Scaffold(
          body: Form(
            key: formKey,
            child: ProfileDetailsFormFields(
              role: AppUserRole.shipper,
              nameController: TextEditingController(),
              companyController: TextEditingController(),
              phoneController: TextEditingController(),
              isSubmitting: false,
              onSubmit: () {
                if (formKey.currentState!.validate()) {
                  submitted = true;
                }
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();

    expect(formKey.currentState!.validate(), isFalse);
    expect(find.byType(AuthTextField), findsNWidgets(2));
    expect(submitted, isFalse);
  });

  testWidgets('ProfileDetailsFormFields validates Algerian phone numbers', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: 'Med Abderraouf');
    final phoneController = TextEditingController(text: '123');

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
        home: Scaffold(
          body: Form(
            key: formKey,
            child: ProfileDetailsFormFields(
              role: AppUserRole.shipper,
              nameController: nameController,
              companyController: TextEditingController(),
              phoneController: phoneController,
              isSubmitting: false,
              onSubmit: () {},
            ),
          ),
        ),
      ),
    );

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Enter a valid Algerian phone number.'), findsOneWidget);
  });
}
