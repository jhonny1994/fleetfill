import 'dart:developer' as developer;

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
    developer.log(message, name: 'FleetFill.debug', error: context);
  }

  @override
  void info(String message, {Map<String, Object?> context = const {}}) {
    developer.log(message, name: 'FleetFill.info', error: context);
  }

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    developer.log(
      message,
      name: 'FleetFill.warning',
      error: error ?? context,
      stackTrace: stackTrace,
      level: 900,
    );
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    developer.log(
      message,
      name: 'FleetFill.error',
      error: error ?? context,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
