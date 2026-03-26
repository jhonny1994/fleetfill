import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/routing/routing.dart';
import 'package:fleetfill/features/notifications/application/notification_feed_controller.dart';
import 'package:fleetfill/features/notifications/domain/notification_copy.dart';
import 'package:fleetfill/features/notifications/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PushNotificationCoordinator extends ConsumerStatefulWidget {
  const PushNotificationCoordinator({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<PushNotificationCoordinator> createState() =>
      _PushNotificationCoordinatorState();
}

class _PushNotificationCoordinatorState
    extends ConsumerState<PushNotificationCoordinator> {
  bool _tapHandlingInitialized = false;
  StreamSubscription<RemoteMessage>? _foregroundMessageSubscription;
  late final PushNotificationService _pushService;

  @override
  void initState() {
    super.initState();
    _pushService = ref.read(pushNotificationServiceProvider);
  }

  @override
  void dispose() {
    unawaited(_foregroundMessageSubscription?.cancel());
    unawaited(_pushService.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final environment = ref.watch(appEnvironmentConfigProvider);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final router = ref.watch(appRouterProvider);
    final locale = Localizations.localeOf(context);
    final s = S.of(context);
    final pushService = ref.watch(pushNotificationServiceProvider);
    final messenger = ScaffoldMessenger.maybeOf(context);

    if (pushService.isSupportedOnCurrentPlatform &&
        pushService.isConfiguredForCurrentPlatform) {
      if (!_tapHandlingInitialized) {
        _tapHandlingInitialized = true;
        unawaited(pushService.ensureTapHandling(router));
        _foregroundMessageSubscription ??= FirebaseMessaging.onMessage.listen(
          (message) {
            ref.invalidate(myNotificationsProvider);
            final copy = localizedNotificationCopy(
              s: s,
              type: message.data['type']?.toString(),
              data: message.data,
              fallbackTitle: message.notification?.title,
              fallbackBody: message.notification?.body,
            );
            final title = copy.title.trim();
            final body = copy.body.trim();
            if (!mounted || title.isEmpty) {
              return;
            }
            messenger?.showSnackBar(
              SnackBar(
                content: Text(
                  body.isEmpty ? title : '$title\n$body',
                ),
              ),
            );
          },
        );
      }

      if (environment.hasSupabaseConfig && auth?.profile != null) {
        unawaited(
          pushService.syncAuthenticatedSessionIfAuthorized(
            auth: auth!,
            locale: locale,
          ),
        );
      }
    }

    return widget.child;
  }
}
