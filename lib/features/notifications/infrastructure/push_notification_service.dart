import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/routing/routing.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/notifications/infrastructure/notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final pushNotificationServiceProvider = Provider<PushNotificationService>((
  ref,
) {
  return PushNotificationService(
    environment: ref.watch(appEnvironmentConfigProvider),
    logger: ref.watch(appLoggerProvider),
    repository: ref.watch(notificationRepositoryProvider),
  );
});

class PushNotificationService {
  PushNotificationService({
    required this.environment,
    required this.logger,
    required this.repository,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;
  final NotificationRepository repository;

  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;
  bool _foregroundPresentationConfigured = false;
  bool _initialMessageHandled = false;
  String? _lastRegisteredToken;
  String? _lastRegisteredUserId;
  String? _lastRegisteredLocale;

  bool get isSupportedOnCurrentPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  bool get isConfiguredForCurrentPlatform => isSupportedOnCurrentPlatform;

  FirebaseOptions? firebaseOptionsForCurrentPlatform(
    AppEnvironmentConfig config,
  ) {
    final apiKey = config.firebaseApiKey.trim();
    final projectId = config.firebaseProjectId.trim();
    final senderId = config.firebaseMessagingSenderId.trim();
    if (apiKey.isEmpty || projectId.isEmpty || senderId.isEmpty) {
      return null;
    }

    final storageBucket = config.firebaseStorageBucket.trim();
    final androidAppId = config.firebaseAndroidAppId.trim();
    final iosAppId = config.firebaseIosAppId.trim();

    return switch (defaultTargetPlatform) {
      TargetPlatform.android when androidAppId.isNotEmpty => FirebaseOptions(
        apiKey: apiKey,
        appId: androidAppId,
        messagingSenderId: senderId,
        projectId: projectId,
        storageBucket: storageBucket.isEmpty ? null : storageBucket,
      ),
      TargetPlatform.iOS when iosAppId.isNotEmpty => FirebaseOptions(
        apiKey: apiKey,
        appId: iosAppId,
        messagingSenderId: senderId,
        projectId: projectId,
        storageBucket: storageBucket.isEmpty ? null : storageBucket,
      ),
      _ => null,
    };
  }

  Future<void> syncAuthenticatedSession({
    required AuthSnapshot auth,
    required Locale locale,
  }) async {
    if (!auth.isAuthenticated || auth.userId == null) {
      _lastRegisteredToken = null;
      _lastRegisteredUserId = null;
      _lastRegisteredLocale = null;
      return;
    }

    if (!isSupportedOnCurrentPlatform || !isConfiguredForCurrentPlatform) {
      return;
    }

    final firebaseReady = await _ensureFirebaseInitialized();
    if (!firebaseReady) {
      return;
    }
    await _ensureForegroundPresentation();
    await _ensureTokenRefreshRegistration(auth.userId!, locale.languageCode);

    final permissionSettings = await FirebaseMessaging.instance
        .requestPermission();

    if (permissionSettings.authorizationStatus == AuthorizationStatus.denied ||
        permissionSettings.authorizationStatus ==
            AuthorizationStatus.notDetermined) {
      return;
    }

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.trim().isEmpty) {
      return;
    }

    if (_lastRegisteredUserId == auth.userId &&
        _lastRegisteredToken == token &&
        _lastRegisteredLocale == locale.languageCode) {
      return;
    }

    await repository.registerDeviceToken(
      pushToken: token,
      platform: _platformName,
      locale: locale.languageCode,
    );
    _lastRegisteredUserId = auth.userId;
    _lastRegisteredToken = token;
    _lastRegisteredLocale = locale.languageCode;
  }

  Future<void> ensureTapHandling(GoRouter router) async {
    if (!isSupportedOnCurrentPlatform || !isConfiguredForCurrentPlatform) {
      return;
    }

    final firebaseReady = await _ensureFirebaseInitialized();
    if (!firebaseReady) {
      return;
    }
    if (!_initialMessageHandled) {
      _initialMessageHandled = true;
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        _openRouteForMessage(router, initialMessage);
      }
    }

    _messageOpenedSubscription ??= FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _openRouteForMessage(router, message),
    );
  }

  Future<bool> _ensureFirebaseInitialized() async {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }

    try {
      final options = firebaseOptionsForCurrentPlatform(environment);
      if (options != null) {
        await Firebase.initializeApp(options: options);
      } else {
        await Firebase.initializeApp();
      }
      return true;
    } on Exception catch (error, stackTrace) {
      logger.error(
        'Firebase initialization failed for push notifications',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> _ensureForegroundPresentation() async {
    if (_foregroundPresentationConfigured) {
      return;
    }
    _foregroundPresentationConfigured = true;
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _ensureTokenRefreshRegistration(
    String userId,
    String localeCode,
  ) async {
    _tokenRefreshSubscription ??= FirebaseMessaging.instance.onTokenRefresh
        .listen(
          (token) async {
            if (token.trim().isEmpty) {
              return;
            }
            await repository.registerDeviceToken(
              pushToken: token,
              platform: _platformName,
              locale: localeCode,
            );
            _lastRegisteredUserId = userId;
            _lastRegisteredToken = token;
            _lastRegisteredLocale = localeCode;
          },
          onError: (Object error, StackTrace stackTrace) {
            logger.error(
              'Push token refresh registration failed',
              error: error,
              stackTrace: stackTrace,
            );
          },
        );
  }

  void _openRouteForMessage(GoRouter router, RemoteMessage message) {
    final route = routeForPushMessageData(message.data);
    if (route == null || route.isEmpty) {
      return;
    }
    router.go(route);
  }

  String get _platformName => switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    _ => 'unsupported',
  };

  Future<void> dispose() async {
    await _tokenRefreshSubscription?.cancel();
    await _messageOpenedSubscription?.cancel();
  }
}

String? routeForPushMessageData(Map<String, dynamic> data) {
  final explicitRoute = data['route']?.toString().trim();
  if (explicitRoute != null && explicitRoute.isNotEmpty) {
    return explicitRoute;
  }

  final notificationId = data['notification_id']?.toString().trim();
  if (notificationId != null && notificationId.isNotEmpty) {
    return AppRoutePath.sharedNotificationDetail.replaceFirst(
      ':id',
      notificationId,
    );
  }

  final encodedData = data['payload_json']?.toString().trim();
  if (encodedData != null && encodedData.isNotEmpty) {
    try {
      final payload = jsonDecode(encodedData);
      if (payload is Map<String, dynamic>) {
        return routeForPushMessageData(payload);
      }
    } on FormatException {
      return null;
    }
  }

  return AppRoutePath.sharedNotifications;
}
