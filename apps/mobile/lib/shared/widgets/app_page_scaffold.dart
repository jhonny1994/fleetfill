import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppPageScaffold extends ConsumerWidget {
  const AppPageScaffold({
    required this.title,
    required this.child,
    super.key,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = AppBreakpoints.resolve(context);
    final horizontalPadding = switch (layout) {
      AppLayoutSize.compact => AppSpacing.md,
      AppLayoutSize.medium => AppSpacing.lg,
      AppLayoutSize.expanded => AppSpacing.xl,
    };
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final notificationsAsync = ref.watch(myNotificationsProvider);
    final unreadCount = auth?.isAuthenticated == true
        ? (notificationsAsync.asData?.value.items
                  .where((notification) => !notification.isRead)
                  .length ??
              0)
        : 0;
    final resolvedActions = <Widget>[
      if (auth?.isAuthenticated == true)
        IconButton(
          onPressed: () => context.push(AppRoutePath.sharedNotifications),
          tooltip: S.of(context).openNotificationsAction,
          icon: Badge.count(
            isLabelVisible: unreadCount > 0,
            count: unreadCount,
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ),
      ...?actions,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: resolvedActions,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
