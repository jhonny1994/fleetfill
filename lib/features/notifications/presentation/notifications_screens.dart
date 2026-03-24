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
  return switch (notification.type) {
    'booking_confirmed' => _NotificationContent(
      title: s.notificationBookingConfirmedTitle,
      body: s.notificationBookingConfirmedBody,
    ),
    'payment_proof_submitted' => _NotificationContent(
      title: s.notificationPaymentProofSubmittedTitle,
      body: s.notificationPaymentProofSubmittedBody,
    ),
    'payment_secured' => _NotificationContent(
      title: s.notificationPaymentSecuredTitle,
      body: s.notificationPaymentSecuredBody,
    ),
    'payment_rejected' => _NotificationContent(
      title: s.notificationPaymentRejectedTitle,
      body: s.notificationPaymentRejectedBody,
    ),
    'booking_milestone_updated' => _NotificationContent(
      title: s.notificationBookingMilestoneUpdatedTitle,
      body: s.notificationBookingMilestoneUpdatedBody(
        _milestoneLabel(s, notification.data['milestone'] as String?),
      ),
    ),
    'carrier_review_submitted' => _NotificationContent(
      title: s.notificationCarrierReviewSubmittedTitle,
      body: s.notificationCarrierReviewSubmittedBody,
    ),
    'dispute_opened' => _NotificationContent(
      title: s.notificationDisputeOpenedTitle,
      body: s.notificationDisputeOpenedBody,
    ),
    'dispute_resolved' => _NotificationContent(
      title: s.notificationDisputeResolvedTitle,
      body: s.notificationDisputeResolvedBody,
    ),
    'payout_released' => _NotificationContent(
      title: s.notificationPayoutReleasedTitle,
      body: s.notificationPayoutReleasedBody,
    ),
    'generated_document_ready' => _NotificationContent(
      title: s.notificationGeneratedDocumentReadyTitle,
      body: s.notificationGeneratedDocumentReadyBody(
        _generatedDocumentTypeLabel(
          s,
          notification.data['document_type'] as String?,
        ),
      ),
    ),
    'verification_packet_approved' => _NotificationContent(
      title: s.notificationVerificationPacketApprovedTitle,
      body: s.notificationVerificationPacketApprovedBody,
    ),
    'verification_document_rejected' => _NotificationContent(
      title: s.notificationVerificationDocumentRejectedTitle,
      body: s.notificationVerificationDocumentRejectedBody(
        _verificationDocumentTypeLabel(
          s,
          notification.data['document_type'] as String?,
        ),
        (notification.data['reason'] as String?)?.trim().isNotEmpty == true
            ? (notification.data['reason'] as String).trim()
            : s.verificationDocumentRejectedFallbackReason,
      ),
    ),
    'support_request_created' => _NotificationContent(
      title: s.notificationSupportRequestCreatedTitle,
      body: s.notificationSupportRequestCreatedBody,
    ),
    'support_reply_received' => _NotificationContent(
      title: s.notificationSupportReplyReceivedTitle,
      body: s.notificationSupportReplyReceivedBody,
    ),
    'support_user_replied' => _NotificationContent(
      title: s.notificationSupportUserRepliedTitle,
      body: s.notificationSupportUserRepliedBody,
    ),
    'support_status_changed' => _NotificationContent(
      title: s.notificationSupportStatusChangedTitle,
      body: s.notificationSupportStatusChangedBody(
        _supportStatusLabel(
          s,
          notification.data['status'] as String?,
        ),
      ),
    ),
    _ => _NotificationContent(
      title: notification.title,
      body: notification.body,
    ),
  };
}

String _generatedDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'payment_receipt' => s.generatedDocumentTypePaymentReceipt,
    'payout_receipt' => s.generatedDocumentTypePayoutReceipt,
    _ => s.generatedDocumentsTitle,
  };
}

String _verificationDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'driver_identity_or_license' => s.verificationDocumentDriverIdentityLabel,
    'truck_registration' => s.verificationDocumentTruckRegistrationLabel,
    'truck_insurance' => s.verificationDocumentTruckInsuranceLabel,
    'truck_technical_inspection' => s.verificationDocumentTruckInspectionLabel,
    'transport_license' => s.verificationDocumentTransportLicenseLabel,
    _ => s.verificationDocumentViewerTitle,
  };
}

String _milestoneLabel(S s, String? milestone) {
  return switch (milestone) {
    'payment_under_review' => s.trackingEventPaymentUnderReviewLabel,
    'confirmed' => s.trackingEventConfirmedLabel,
    'picked_up' => s.trackingEventPickedUpLabel,
    'in_transit' => s.trackingEventInTransitLabel,
    'delivered_pending_review' => s.trackingEventDeliveredPendingReviewLabel,
    'completed' => s.trackingEventCompletedLabel,
    'cancelled' => s.trackingEventCancelledLabel,
    'disputed' => s.trackingEventDisputedLabel,
    _ => milestone ?? '',
  };
}

String _supportStatusLabel(S s, String? status) {
  return switch (status) {
    'open' => s.supportStatusOpenLabel,
    'in_progress' => s.supportStatusInProgressLabel,
    'waiting_for_user' => s.supportStatusWaitingForUserLabel,
    'resolved' => s.supportStatusResolvedLabel,
    'closed' => s.supportStatusClosedLabel,
    _ => s.supportStatusOpenLabel,
  };
}

String _formatNotificationDate(BuildContext context, DateTime value) {
  final localizations = MaterialLocalizations.of(context);
  return localizations.formatMediumDate(value);
}
