// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppEnvironmentConfig _$AppEnvironmentConfigFromJson(
  Map<String, dynamic> json,
) => _AppEnvironmentConfig(
  environment: $enumDecode(_$AppEnvironmentEnumMap, json['environment']),
  supabaseUrl: json['supabaseUrl'] as String? ?? '',
  supabaseAnonKey: json['supabaseAnonKey'] as String? ?? '',
  googleAuthEnabled: json['googleAuthEnabled'] as bool? ?? false,
  maintenanceMode: json['maintenanceMode'] as bool? ?? false,
  forceUpdateRequired: json['forceUpdateRequired'] as bool? ?? false,
  crashReportingEnabled: json['crashReportingEnabled'] as bool? ?? false,
);

Map<String, dynamic> _$AppEnvironmentConfigToJson(
  _AppEnvironmentConfig instance,
) => <String, dynamic>{
  'environment': _$AppEnvironmentEnumMap[instance.environment]!,
  'supabaseUrl': instance.supabaseUrl,
  'supabaseAnonKey': instance.supabaseAnonKey,
  'googleAuthEnabled': instance.googleAuthEnabled,
  'maintenanceMode': instance.maintenanceMode,
  'forceUpdateRequired': instance.forceUpdateRequired,
  'crashReportingEnabled': instance.crashReportingEnabled,
};

const _$AppEnvironmentEnumMap = {
  AppEnvironment.local: 'local',
  AppEnvironment.staging: 'staging',
  AppEnvironment.production: 'production',
};
