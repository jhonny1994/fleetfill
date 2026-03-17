import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.notificationsCenterTitle,
      description: s.notificationsCenterDescription,
      showSummary: false,
    );
  }
}

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({required this.notificationId, super.key});

  final String notificationId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.notificationDetailTitle(notificationId),
      description: s.notificationDetailDescription,
      showSummary: false,
    );
  }
}
