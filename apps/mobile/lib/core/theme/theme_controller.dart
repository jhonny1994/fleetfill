import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const themeModeStorageKey = 'fleetfill.theme_mode';

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

enum ThemeModePreference {
  system,
  light,
  dark
  ;

  ThemeMode get themeMode {
    switch (this) {
      case ThemeModePreference.system:
        return ThemeMode.system;
      case ThemeModePreference.light:
        return ThemeMode.light;
      case ThemeModePreference.dark:
        return ThemeMode.dark;
    }
  }

  static ThemeModePreference fromStorage(String? value) {
    return ThemeModePreference.values.firstWhere(
      (candidate) => candidate.name == value,
      orElse: () => ThemeModePreference.system,
    );
  }

  static ThemeModePreference fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return ThemeModePreference.system;
      case ThemeMode.light:
        return ThemeModePreference.light;
      case ThemeMode.dark:
        return ThemeModePreference.dark;
    }
  }
}

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(initialThemeModeProvider);

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.setString(
      themeModeStorageKey,
      ThemeModePreference.fromThemeMode(mode).name,
    );
  }
}
