import 'dart:async';
import 'dart:ui';

import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:flutter/widgets.dart';

abstract class CrashReporter {
  Future<void> recordFlutterError(FlutterErrorDetails details);

  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  });
}

class NoopCrashReporter implements CrashReporter {
  const NoopCrashReporter({this.logger});

  final AppLogger? logger;

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    logger?.info(
      'Crash reporting disabled${reason == null ? '' : ' ($reason)'}',
    );
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    logger?.info('Flutter error captured while crash reporting is disabled');
  }
}

class DeferredCrashReporter implements CrashReporter {
  const DeferredCrashReporter({required this.logger});

  final AppLogger logger;

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    logger.error(
      'Crash reporter captured uncaught error${reason == null ? '' : ' ($reason)'}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    logger.error(
      'Crash reporter captured Flutter error',
      error: details.exception,
      stackTrace: details.stack,
    );
  }
}

void installGlobalErrorHandlers({
  required AppLogger logger,
  required CrashReporter crashReporter,
}) {
  FlutterError.onError = (details) {
    logger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    unawaited(crashReporter.recordFlutterError(details));
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error(
      'Uncaught platform error',
      error: error,
      stackTrace: stackTrace,
    );
    unawaited(
      crashReporter.recordError(
        error,
        stackTrace,
        reason: 'PlatformDispatcher.onError',
      ),
    );
    return true;
  };
}
