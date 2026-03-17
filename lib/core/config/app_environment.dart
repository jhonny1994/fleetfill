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
    @Default(false) bool maintenanceMode,
    @Default(false) bool forceUpdateRequired,
    @Default(false) bool crashReportingEnabled,
  }) = _AppEnvironmentConfig;
  const AppEnvironmentConfig._();

  factory AppEnvironmentConfig.fromJson(Map<String, dynamic> json) =>
      _$AppEnvironmentConfigFromJson(json);

  factory AppEnvironmentConfig.fromDefines() {
    return AppEnvironmentConfig(
      environment: _parseEnvironment(
        const String.fromEnvironment('APP_ENV', defaultValue: 'local'),
      ),
      maintenanceMode: _parseBool(
        const String.fromEnvironment('MAINTENANCE_MODE', defaultValue: 'false'),
      ),
      forceUpdateRequired: _parseBool(
        const String.fromEnvironment(
          'FORCE_UPDATE_REQUIRED',
          defaultValue: 'false',
        ),
      ),
      crashReportingEnabled: _parseBool(
        const String.fromEnvironment(
          'CRASH_REPORTING_ENABLED',
          defaultValue: 'false',
        ),
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
}
