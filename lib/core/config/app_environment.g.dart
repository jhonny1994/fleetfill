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
  firebaseApiKey: json['firebaseApiKey'] as String? ?? '',
  firebaseMessagingSenderId: json['firebaseMessagingSenderId'] as String? ?? '',
  firebaseProjectId: json['firebaseProjectId'] as String? ?? '',
  firebaseStorageBucket: json['firebaseStorageBucket'] as String? ?? '',
  firebaseAndroidAppId: json['firebaseAndroidAppId'] as String? ?? '',
  firebaseIosAppId: json['firebaseIosAppId'] as String? ?? '',
  googleWebClientId: json['googleWebClientId'] as String? ?? '',
  googleIosClientId: json['googleIosClientId'] as String? ?? '',
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
  'firebaseApiKey': instance.firebaseApiKey,
  'firebaseMessagingSenderId': instance.firebaseMessagingSenderId,
  'firebaseProjectId': instance.firebaseProjectId,
  'firebaseStorageBucket': instance.firebaseStorageBucket,
  'firebaseAndroidAppId': instance.firebaseAndroidAppId,
  'firebaseIosAppId': instance.firebaseIosAppId,
  'googleWebClientId': instance.googleWebClientId,
  'googleIosClientId': instance.googleIosClientId,
  'maintenanceMode': instance.maintenanceMode,
  'forceUpdateRequired': instance.forceUpdateRequired,
  'crashReportingEnabled': instance.crashReportingEnabled,
};

const _$AppEnvironmentEnumMap = {
  AppEnvironment.local: 'local',
  AppEnvironment.staging: 'staging',
  AppEnvironment.production: 'production',
};
