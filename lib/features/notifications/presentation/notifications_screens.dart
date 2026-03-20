import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsCenterScreen extends ConsumerWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final notificationsAsync = ref.watch(myNotificationsProvider);

    return AppPageScaffold(
      title: s.notificationsCenterTitle,
      child: AppAsyncStateView<List<AppNotificationRecord>>(
        value: notificationsAsync,
        onRetry: () => ref.invalidate(myNotificationsProvider),
        data: (items) {
          if (items.isEmpty) {
            return AppEmptyState(
              title: s.notificationsCenterTitle,
              message: s.notificationsCenterDescription,
            );
          }
          return ListView.separated(
            key: const PageStorageKey<String>('notifications-center-list'),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final item = items[index];
              return AppListCard(
                title: item.title,
                subtitle: item.body,
                leading: AppStatusChip(
                  label: item.isRead ? s.statusReadyLabel : s.statusNeedsReviewLabel,
                  tone: item.isRead ? AppStatusTone.success : AppStatusTone.warning,
                ),
                trailing: Text(BidiFormatters.latinIdentifier('${item.createdAt.year}-${item.createdAt.month.toString().padLeft(2, '0')}-${item.createdAt.day.toString().padLeft(2, '0')}')),
                onTap: () => context.push(
                  AppRoutePath.sharedNotificationDetail.replaceFirst(':id', item.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationDetailScreen extends ConsumerWidget {
  const NotificationDetailScreen({required this.notificationId, super.key});

  final String notificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final detailAsync = ref.watch(notificationDetailProvider(notificationId));

    return AppPageScaffold(
      title: s.notificationDetailTitle(notificationId),
      child: AppAsyncStateView<AppNotificationRecord?>(
        value: detailAsync,
        onRetry: () => ref.invalidate(notificationDetailProvider(notificationId)),
        data: (notification) {
          if (notification == null) {
            return const AppNotFoundState();
          }
          unawaited(ref.read(notificationRepositoryProvider).markNotificationRead(notification.id));
          ref.invalidate(myNotificationsProvider);
          return ListView(
            children: [
              AppSectionHeader(
                title: notification.title,
                subtitle: s.notificationDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(notification.body),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
