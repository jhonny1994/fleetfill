import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:fleetfill/features/notifications/infrastructure/infrastructure.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

class NotificationsPermissionHelpScreen extends ConsumerWidget {
  const NotificationsPermissionHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    return _PermissionHelpScreen(
      icon: Icons.notifications_active_outlined,
      title: s.notificationsCenterTitle,
      description: s.notificationsPermissionDescription,
      primaryLabel: s.notificationsOnboardingEnableAction,
      secondaryLabel: s.openNotificationsAction,
      onPrimaryPressed: auth == null
          ? null
          : () => _enableNotifications(context, ref, auth),
      onSecondaryPressed: () => context.push(AppRoutePath.sharedNotifications),
    );
  }

  Future<void> _enableNotifications(
    BuildContext context,
    WidgetRef ref,
    AuthSnapshot auth,
  ) async {
    final status = await ref
        .read(pushNotificationServiceProvider)
        .requestPermissionAndSync(
          auth: auth,
          locale: Localizations.localeOf(context),
        );
    if (!context.mounted) {
      return;
    }

    final s = S.of(context);
    final message =
        status == AuthorizationStatus.authorized ||
            status == AuthorizationStatus.provisional
        ? s.notificationsSettingsEnabledMessage
        : s.notificationsSettingsDisabledMessage;
    AppFeedback.showSnackBar(context, message);
  }
}

class MediaUploadPermissionHelpScreen extends ConsumerWidget {
  const MediaUploadPermissionHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    final primaryLabel = switch (auth?.role) {
      AppUserRole.carrier => s.carrierVerificationCenterTitle,
      AppUserRole.shipper => s.myShipmentsTitle,
      _ => s.contactSupportAction,
    };

    final onPrimaryPressed = switch (auth?.role) {
      AppUserRole.carrier => () => context.push(
        AppRoutePath.carrierVerification,
      ),
      AppUserRole.shipper => () => context.go(AppRoutePath.shipperShipments),
      _ => () => context.push(AppRoutePath.sharedSupport),
    };

    return _PermissionHelpScreen(
      icon: Icons.perm_media_outlined,
      title: s.mediaUploadPermissionTitle,
      description: s.mediaUploadPermissionDescription,
      primaryLabel: primaryLabel,
      onPrimaryPressed: onPrimaryPressed,
    );
  }
}

class _PermissionHelpScreen extends StatelessWidget {
  const _PermissionHelpScreen({
    required this.icon,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: title,
      child: AppStateMessage(
        icon: icon,
        title: title,
        message: description,
        action: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: onPrimaryPressed,
              child: Text(primaryLabel),
            ),
            if (secondaryLabel != null && onSecondaryPressed != null) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onSecondaryPressed,
                child: Text(secondaryLabel!),
              ),
            ],
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push(AppRoutePath.sharedSupport),
              child: Text(s.contactSupportAction),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(s.goBackAction),
            ),
          ],
        ),
      ),
    );
  }
}
