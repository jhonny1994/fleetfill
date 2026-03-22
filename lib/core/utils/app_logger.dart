import 'package:flutter/foundation.dart';

abstract class AppLogger {
  void debug(String message, {Map<String, Object?> context = const {}});

  void info(String message, {Map<String, Object?> context = const {}});

  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context,
  });

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context,
  });
}

class DebugAppLogger implements AppLogger {
  const DebugAppLogger();

  @override
  void debug(String message, {Map<String, Object?> context = const {}}) {
    _write('DEBUG', message, context: context);
  }

  @override
  void info(String message, {Map<String, Object?> context = const {}}) {
    _write('INFO', message, context: context);
  }

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    _write(
      'WARN',
      message,
      context: context,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    _write(
      'ERROR',
      message,
      context: context,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _write(
    String level,
    String message, {
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint('[FleetFill][$level] $message');

    if (context.isNotEmpty) {
      debugPrint('[FleetFill][$level][context] ${_formatContext(context)}');
    }

    if (error != null) {
      debugPrint('[FleetFill][$level][error] $error');
    }

    if (stackTrace != null) {
      debugPrint('[FleetFill][$level][stack] $stackTrace');
    }
  }

  String _formatContext(Map<String, Object?> context) {
    return context.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join(', ');
  }
}
