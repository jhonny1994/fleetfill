import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/domain/notification_copy.dart';
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
      child: AppAsyncStateView<NotificationFeedState>(
        value: notificationsAsync,
        onRetry: () => ref.read(myNotificationsProvider.notifier).refresh(),
        data: (feed) {
          final items = feed.items;
          if (items.isEmpty) {
            return AppEmptyState(
              title: s.notificationsCenterTitle,
              message: s.notificationsCenterDescription,
            );
          }
          final showFooter = feed.hasMore || feed.isLoadingMore;
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(myNotificationsProvider.notifier).refresh(),
            child: ListView.separated(
              key: const PageStorageKey<String>('notifications-center-list'),
              itemCount: items.length + (showFooter ? 1 : 0),
              separatorBuilder: (_, index) =>
                  index == items.length - 1 && !showFooter
                  ? const SizedBox.shrink()
                  : const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                if (index >= items.length) {
                  return _NotificationsFooter(
                    isLoadingMore: feed.isLoadingMore,
                    onLoadMore: feed.isLoadingMore
                        ? null
                        : () => unawaited(_loadMore(context, ref)),
                  );
                }

                final item = items[index];
                final content = _notificationContent(context, item);
                return AppListCard(
                  title: content.title,
                  subtitle: content.body,
                  leading: AppStatusChip(
                    label: item.isRead
                        ? s.notificationSeenLabel
                        : s.notificationNewLabel,
                    tone: item.isRead
                        ? AppStatusTone.neutral
                        : AppStatusTone.info,
                  ),
                  trailing: Text(
                    _formatNotificationDate(context, item.createdAt),
                  ),
                  onTap: () => context.push(
                    AppRoutePath.sharedNotificationDetail.replaceFirst(
                      ':id',
                      item.id,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadMore(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(myNotificationsProvider.notifier).loadMore();
    } on Exception catch (error) {
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        mapAppErrorMessage(S.of(context), error),
      );
    }
  }
}

class _NotificationsFooter extends StatelessWidget {
  const _NotificationsFooter({
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final bool isLoadingMore;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Center(
      child: OutlinedButton(
        onPressed: onLoadMore,
        child: Text(S.of(context).loadMoreLabel),
      ),
    );
  }
}

class NotificationDetailScreen extends ConsumerStatefulWidget {
  const NotificationDetailScreen({required this.notificationId, super.key});

  final String notificationId;

  @override
  ConsumerState<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState
    extends ConsumerState<NotificationDetailScreen> {
  bool _markRequested = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final detailAsync = ref.watch(
      notificationDetailProvider(widget.notificationId),
    );
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    ref.listen<AsyncValue<AppNotificationRecord?>>(
      notificationDetailProvider(widget.notificationId),
      (_, next) {
        final notification = next.asData?.value;
        if (notification == null || notification.isRead || _markRequested) {
          return;
        }
        _markRequested = true;
        unawaited(_markRead(notification.id));
      },
    );

    return AppPageScaffold(
      title: s.notificationDetailPageTitle,
      child: AppAsyncStateView<AppNotificationRecord?>(
        value: detailAsync,
        onRetry: () =>
            ref.invalidate(notificationDetailProvider(widget.notificationId)),
        data: (notification) {
          if (notification == null) {
            return const AppNotFoundState();
          }
          final content = _notificationContent(context, notification);
          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(myNotificationsProvider)
                ..invalidate(notificationDetailProvider(widget.notificationId));
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: content.title,
                  subtitle: s.notificationDetailDescription,
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(content.body),
                  ),
                ),
                if (notification.type == 'generated_document_ready' &&
                    notification.data['document_id'] is String) ...[
                  const SizedBox(height: AppSpacing.md),
                  FilledButton.icon(
                    onPressed: () => context.push(
                      AppRoutePath.sharedGeneratedDocumentViewer.replaceFirst(
                        ':id',
                        notification.data['document_id'] as String,
                      ),
                    ),
                    icon: const Icon(Icons.description_outlined),
                    label: Text(s.documentViewerOpenAction),
                  ),
                ],
                if (notification.type == 'verification_document_rejected' &&
                    notification.data['document_id'] is String) ...[
                  const SizedBox(height: AppSpacing.md),
                  FilledButton.icon(
                    onPressed: () => context.push(
                      AppRoutePath.sharedDocumentViewer.replaceFirst(
                        ':id',
                        notification.data['document_id'] as String,
                      ),
                    ),
                    icon: const Icon(Icons.badge_outlined),
                    label: Text(s.verificationDocumentViewerTitle),
                  ),
                ],
                if (notification.data['support_request_id'] is String) ...[
                  const SizedBox(height: AppSpacing.md),
                  FilledButton.icon(
                    onPressed: () => context.push(
                      auth?.role == AppUserRole.admin
                          ? AppRoutePath.adminQueuesSupport(
                              notification.data['support_request_id'] as String,
                            )
                          : AppRoutePath.sharedSupportThread.replaceFirst(
                              ':id',
                              notification.data['support_request_id'] as String,
                            ),
                    ),
                    icon: const Icon(Icons.support_agent_outlined),
                    label: Text(s.supportThreadOpenAction),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _markRead(String notificationId) async {
    try {
      await ref
          .read(notificationRepositoryProvider)
          .markNotificationRead(notificationId);
      ref
        ..invalidate(myNotificationsProvider)
        ..invalidate(notificationDetailProvider(widget.notificationId));
    } on Exception {
      _markRequested = false;
    }
  }
}

class _NotificationContent {
  const _NotificationContent({required this.title, required this.body});

  final String title;
  final String body;
}

_NotificationContent _notificationContent(
  BuildContext context,
  AppNotificationRecord notification,
) {
  final s = S.of(context);
  final content = localizedNotificationCopy(
    s: s,
    type: notification.type,
    data: notification.data,
    fallbackTitle: notification.title,
    fallbackBody: notification.body,
  );
  return _NotificationContent(
    title: content.title,
    body: content.body,
  );
}

String _formatNotificationDate(BuildContext context, DateTime value) {
  final localizations = MaterialLocalizations.of(context);
  return localizations.formatMediumDate(value);
}
