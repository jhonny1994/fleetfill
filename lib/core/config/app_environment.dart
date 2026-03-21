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
    @Default(false) bool googleAuthEnabled,
    @Default(false) bool maintenanceMode,
    @Default(false) bool forceUpdateRequired,
    @Default(false) bool crashReportingEnabled,
  }) = _AppEnvironmentConfig;
  const AppEnvironmentConfig._();

  factory AppEnvironmentConfig.fromJson(Map<String, dynamic> json) =>
      _$AppEnvironmentConfigFromJson(json);

  factory AppEnvironmentConfig.fromDefines() {
    return AppEnvironmentConfig(
      environment: _parseEnvironment(const String.fromEnvironment('APP_ENV')),
      supabaseUrl: _firstNonEmpty([
        const String.fromEnvironment('SUPABASE_URL'),
        const String.fromEnvironment('APP_SUPABASE_URL'),
      ]),
      supabaseAnonKey: _firstNonEmpty([
        const String.fromEnvironment('SUPABASE_ANON_KEY'),
        const String.fromEnvironment('APP_SUPABASE_ANON_KEY'),
      ]),
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
      googleAuthEnabled: _parseBool(
        _firstNonEmpty([
          const String.fromEnvironment('GOOGLE_AUTH_ENABLED'),
          const String.fromEnvironment('APP_GOOGLE_AUTH_ENABLED'),
        ]),
      ),
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

  static String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) {
        return trimmed;
      }
    }

    return '';
  }
}
