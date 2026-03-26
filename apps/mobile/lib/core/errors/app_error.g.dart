// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppError _$AppErrorFromJson(Map<String, dynamic> json) => _AppError(
  code: json['code'] as String,
  message: json['message'] as String,
  severity:
      $enumDecodeNullable(_$AppErrorSeverityEnumMap, json['severity']) ??
      AppErrorSeverity.error,
  technicalDetails: json['technicalDetails'] as String?,
  actionLabel: json['actionLabel'] as String?,
);

Map<String, dynamic> _$AppErrorToJson(_AppError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'severity': _$AppErrorSeverityEnumMap[instance.severity]!,
  'technicalDetails': instance.technicalDetails,
  'actionLabel': instance.actionLabel,
};

const _$AppErrorSeverityEnumMap = {
  AppErrorSeverity.info: 'info',
  AppErrorSeverity.warning: 'warning',
  AppErrorSeverity.error: 'error',
  AppErrorSeverity.fatal: 'fatal',
};
