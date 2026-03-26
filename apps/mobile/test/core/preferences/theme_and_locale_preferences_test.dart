import 'package:fleetfill/core/localization/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Theme and locale preferences', () {
    test('theme preference serializes and restores', () async {
      SharedPreferences.setMockInitialValues(const <String, Object>{});
      final preferences = await SharedPreferences.getInstance();

      await preferences.setString('theme_mode', ThemeMode.dark.name);

      expect(preferences.getString('theme_mode'), ThemeMode.dark.name);
    });

    test('locale preference serializes and restores', () async {
      SharedPreferences.setMockInitialValues(const <String, Object>{});
      final preferences = await SharedPreferences.getInstance();

      await preferences.setString(localeStorageKey, 'fr');

      expect(preferences.getString(localeStorageKey), 'fr');
    });
  });
}
