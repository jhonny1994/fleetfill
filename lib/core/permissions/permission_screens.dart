import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationsPermissionHelpScreen extends StatelessWidget {
  const NotificationsPermissionHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.notificationsPermissionTitle,
      description: s.notificationsPermissionDescription,
      showSummary: false,
    );
  }
}

class MediaUploadPermissionHelpScreen extends StatelessWidget {
  const MediaUploadPermissionHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.mediaUploadPermissionTitle,
      description: s.mediaUploadPermissionDescription,
      showSummary: false,
    );
  }
}
