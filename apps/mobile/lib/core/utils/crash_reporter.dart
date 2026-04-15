import 'dart:async';
import 'dart:ui';

import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class CrashReporter {
  bool get reliesOnGlobalErrorHooks => false;

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
  bool get reliesOnGlobalErrorHooks => false;

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
  bool get reliesOnGlobalErrorHooks => false;

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

class SentryCrashReporter implements CrashReporter {
  const SentryCrashReporter({required this.logger});

  final AppLogger logger;

  @override
  bool get reliesOnGlobalErrorHooks => true;

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    final hintItems = <String, Object?>{};
    if (reason != null) {
      hintItems['reason'] = reason;
    }

    logger.error(
      'Sending captured error to Sentry${reason == null ? '' : ' ($reason)'}',
      error: error,
      stackTrace: stackTrace,
    );

    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
      hint: Hint.withMap(hintItems),
    );
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    logger.error(
      'Sending Flutter error to Sentry',
      error: details.exception,
      stackTrace: details.stack,
    );

    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
      hint: Hint.withMap(<String, Object?>{
        'context': details.context?.toDescription(),
        'library': details.library,
      }),
    );
  }
}

void installGlobalErrorHandlers({
  required AppLogger logger,
  required CrashReporter crashReporter,
}) {
  final previousFlutterErrorHandler = FlutterError.onError;
  final previousPlatformErrorHandler = PlatformDispatcher.instance.onError;

  FlutterError.onError = (details) {
    logger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (!crashReporter.reliesOnGlobalErrorHooks) {
      unawaited(crashReporter.recordFlutterError(details));
    }
    previousFlutterErrorHandler?.call(details);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error(
      'Uncaught platform error',
      error: error,
      stackTrace: stackTrace,
    );
    if (!crashReporter.reliesOnGlobalErrorHooks) {
      unawaited(
        crashReporter.recordError(
          error,
          stackTrace,
          reason: 'PlatformDispatcher.onError',
        ),
      );
    }
    previousPlatformErrorHandler?.call(error, stackTrace);
    return true;
  };
}
