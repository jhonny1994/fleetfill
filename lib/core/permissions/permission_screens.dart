import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsPermissionHelpScreen extends StatelessWidget {
  const NotificationsPermissionHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return _PermissionHelpScreen(
      icon: Icons.notifications_active_outlined,
      title: s.notificationsPermissionTitle,
      description: s.notificationsPermissionDescription,
      primaryLabel: s.openNotificationsAction,
      onPrimaryPressed: () => context.push(AppRoutePath.sharedNotifications),
    );
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
  });

  final IconData icon;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;

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
