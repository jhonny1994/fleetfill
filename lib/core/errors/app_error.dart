import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';
part 'app_error.g.dart';

enum AppErrorSeverity { info, warning, error, fatal }

@freezed
abstract class AppError with _$AppError {
  const factory AppError({
    required String code,
    required String message,
    @Default(AppErrorSeverity.error) AppErrorSeverity severity,
    String? technicalDetails,
    String? actionLabel,
  }) = _AppError;
  const AppError._();

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);

  IconData get icon {
    switch (severity) {
      case AppErrorSeverity.info:
        return Icons.info_outline_rounded;
      case AppErrorSeverity.warning:
        return Icons.warning_amber_rounded;
      case AppErrorSeverity.error:
        return Icons.error_outline_rounded;
      case AppErrorSeverity.fatal:
        return Icons.report_gmailerrorred_rounded;
    }
  }
}
