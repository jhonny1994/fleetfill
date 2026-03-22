import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_environment.freezed.dart';
part 'app_environment.g.dart';

enum AppEnvironment { local, staging, production }

@freezed
abstract class AppEnvironmentConfig with _$AppEnvironmentConfig {
  const factory AppEnvironmentConfig({
    required AppEnvironment environment,
    @Default('') String supabaseUrl,
    @Default('') String supabaseAnonKey,
    @Default('') String firebaseApiKey,
    @Default('') String firebaseMessagingSenderId,
    @Default('') String firebaseProjectId,
    @Default('') String firebaseStorageBucket,
    @Default('') String firebaseAndroidAppId,
    @Default('') String firebaseIosAppId,
    @Default(false) bool maintenanceMode,
    @Default(false) bool forceUpdateRequired,
    @Default(false) bool crashReportingEnabled,
  }) = _AppEnvironmentConfig;
  const AppEnvironmentConfig._();

  factory AppEnvironmentConfig.fromJson(Map<String, dynamic> json) =>
      _$AppEnvironmentConfigFromJson(json);

  factory AppEnvironmentConfig.fromDefines() {
    final environment = _parseEnvironment(
      const String.fromEnvironment('APP_ENV'),
    );
    final publishableKey = _firstNonEmpty([
      const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
      const String.fromEnvironment('APP_SUPABASE_PUBLISHABLE_KEY'),
    ]);
    final anonKey = _firstNonEmpty([
      const String.fromEnvironment('SUPABASE_ANON_KEY'),
      const String.fromEnvironment('APP_SUPABASE_ANON_KEY'),
    ]);

    return AppEnvironmentConfig(
      environment: environment,
      supabaseUrl: _normalizeSupabaseUrl(
        _firstNonEmpty([
          const String.fromEnvironment('SUPABASE_URL'),
          const String.fromEnvironment('APP_SUPABASE_URL'),
        ]),
        environment: environment,
      ),
      supabaseAnonKey: _resolveClientKey(
        environment: environment,
        publishableKey: publishableKey,
        anonKey: anonKey,
      ),
      firebaseApiKey: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_API_KEY'),
        const String.fromEnvironment('APP_FIREBASE_API_KEY'),
      ]),
      firebaseMessagingSenderId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        const String.fromEnvironment('APP_FIREBASE_MESSAGING_SENDER_ID'),
      ]),
      firebaseProjectId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_PROJECT_ID'),
        const String.fromEnvironment('APP_FIREBASE_PROJECT_ID'),
      ]),
      firebaseStorageBucket: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        const String.fromEnvironment('APP_FIREBASE_STORAGE_BUCKET'),
      ]),
      firebaseAndroidAppId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_ANDROID_APP_ID'),
        const String.fromEnvironment('APP_FIREBASE_ANDROID_APP_ID'),
      ]),
      firebaseIosAppId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_IOS_APP_ID'),
        const String.fromEnvironment('APP_FIREBASE_IOS_APP_ID'),
      ]),
      maintenanceMode: _parseBool(
        const String.fromEnvironment('MAINTENANCE_MODE'),
      ),
      forceUpdateRequired: _parseBool(
        const String.fromEnvironment('FORCE_UPDATE_REQUIRED'),
      ),
      crashReportingEnabled: _parseBool(
        const String.fromEnvironment('CRASH_REPORTING_ENABLED'),
      ),
    );
  }

  bool get hasSupabaseConfig =>
      supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;

  static AppEnvironment _parseEnvironment(String value) {
    return AppEnvironment.values.firstWhere(
      (candidate) => candidate.name == value,
      orElse: () => AppEnvironment.local,
    );
  }

  static bool _parseBool(String value) => value.toLowerCase() == 'true';

  static String resolveClientKeyForTesting({
    required AppEnvironment environment,
    String publishableKey = '',
    String anonKey = '',
  }) {
    return _resolveClientKey(
      environment: environment,
      publishableKey: publishableKey,
      anonKey: anonKey,
    );
  }

  static String _resolveClientKey({
    required AppEnvironment environment,
    required String publishableKey,
    required String anonKey,
  }) {
    final normalizedPublishableKey = publishableKey.trim();
    final normalizedAnonKey = anonKey.trim();

    return switch (environment) {
      AppEnvironment.local => _firstNonEmpty([
        normalizedAnonKey,
        normalizedPublishableKey,
      ]),
      AppEnvironment.staging || AppEnvironment.production => _firstNonEmpty([
        normalizedPublishableKey,
        normalizedAnonKey,
      ]),
    };
  }

  static String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) {
        return trimmed;
      }
    }

    return '';
  }

  static String normalizeSupabaseUrlForTesting(
    String url, {
    required AppEnvironment environment,
    required bool isAndroid,
    bool isWeb = false,
  }) {
    return _normalizeSupabaseUrl(
      url,
      environment: environment,
      isAndroidOverride: isAndroid,
      isWebOverride: isWeb,
    );
  }

  static String _normalizeSupabaseUrl(
    String url, {
    required AppEnvironment environment,
    bool? isAndroidOverride,
    bool? isWebOverride,
  }) {
    final trimmed = url.trim();
    if (trimmed.isEmpty || environment != AppEnvironment.local) {
      return trimmed;
    }

    final isWebPlatform = isWebOverride ?? kIsWeb;
    final isAndroidPlatform =
        isAndroidOverride ??
        (!isWebPlatform && defaultTargetPlatform == TargetPlatform.android);
    if (!isAndroidPlatform) {
      return trimmed;
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null) {
      return trimmed;
    }

    final host = uri.host.toLowerCase();
    if (host != '127.0.0.1' && host != 'localhost') {
      return trimmed;
    }

    return uri.replace(host: '10.0.2.2').toString();
  }
}
