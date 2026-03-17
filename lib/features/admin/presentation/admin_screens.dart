import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminShellScreen extends StatelessWidget {
  const AdminShellScreen({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  final Widget child;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppShellScaffold(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        const destinations = [
          '/admin/dashboard',
          '/admin/queues',
          '/admin/users',
          '/admin/settings',
        ];
        context.go(destinations[index]);
      },
      body: child,
      destinations: [
        AppShellDestination(
          icon: Icons.dashboard_outlined,
          label: s.adminDashboardNavLabel,
        ),
        AppShellDestination(
          icon: Icons.inventory_outlined,
          label: s.adminQueuesNavLabel,
        ),
        AppShellDestination(icon: Icons.group_outlined, label: s.adminUsersNavLabel),
        AppShellDestination(
          icon: Icons.settings_outlined,
          label: s.adminSettingsNavLabel,
        ),
      ],
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.adminDashboardTitle,
      description: s.adminDashboardDescription,
    );
  }
}

class AdminQueuesScreen extends StatelessWidget {
  const AdminQueuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.adminQueuesTitle,
      description: s.adminQueuesDescription,
    );
  }
}

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.adminUsersTitle,
      description: s.adminUsersDescription,
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.userDetailTitle,
      description: s.userDetailDescription,
      showSummary: false,
    );
  }
}

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.adminSettingsTitle,
      description: s.adminSettingsDescription,
    );
  }
}

class AdminAuditLogScreen extends StatelessWidget {
  const AdminAuditLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.adminAuditLogTitle,
      description: s.adminAuditLogDescription,
      showSummary: false,
    );
  }
}
