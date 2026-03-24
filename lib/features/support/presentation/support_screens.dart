import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:fleetfill/features/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupportHomeScreen extends ConsumerStatefulWidget {
  const SupportHomeScreen({super.key});

  @override
  ConsumerState<SupportHomeScreen> createState() => _SupportHomeScreenState();
}

class _SupportHomeScreenState extends ConsumerState<SupportHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final requestsAsync = ref.watch(mySupportRequestsProvider);

    return AppPageScaffold(
      title: s.supportTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(mySupportRequestsProvider);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AppSectionHeader(
              title: s.supportTitle,
              subtitle: s.supportDescription,
              showTitle: false,
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthInfoBanner(message: s.supportReferenceHintMessage),
            const SizedBox(height: AppSpacing.md),
            AuthCard(
              child: Form(
                key: _formKey,
                child: AppFocusTraversal.form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        controller: _subjectController,
                        label: s.supportSubjectLabel,
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AuthTextField(
                        controller: _messageController,
                        label: s.supportMessageLabel,
                        maxLines: 6,
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthSubmitButton(
                        label: s.supportSendAction,
                        isLoading: _isSubmitting,
                        onPressed: () => unawaited(_send(context)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.supportInboxTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            AppAsyncStateView<List<SupportRequestRecord>>(
              value: requestsAsync,
              onRetry: () => ref.invalidate(mySupportRequestsProvider),
              data: (requests) {
                if (requests.isEmpty) {
                  return AppEmptyState(
                    title: s.supportInboxTitle,
                    message: s.supportInboxEmptyMessage,
                  );
                }

                return Column(
                  children: requests
                      .map(
                        (request) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: AppListCard(
                            title: request.subject,
                            subtitle:
                                '${_supportStatusLabel(s, request.status)} • ${request.lastMessagePreview ?? s.supportThreadNoMessagesMessage}',
                            leading: AppStatusChip(
                              label: request.hasUnreadForUser
                                  ? s.statusNeedsReviewLabel
                                  : s.statusReadyLabel,
                              tone: request.hasUnreadForUser
                                  ? AppStatusTone.warning
                                  : AppStatusTone.success,
                            ),
                            trailing: Text(
                              BidiFormatters.latinIdentifier(
                                MaterialLocalizations.of(
                                  context,
                                ).formatShortDate(request.lastMessageAt),
                              ),
                            ),
                            onTap: () => context.push(
                              AppRoutePath.sharedSupportThread.replaceFirst(
                                ':id',
                                request.id,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _send(BuildContext context) async {
    final s = S.of(context);
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(supportWorkflowControllerProvider)
          .createSupportRequest(
            locale: Localizations.localeOf(context).languageCode,
            subject: _subjectController.text,
            message: _messageController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(this.context, s.supportRequestCreatedMessage);
      _subjectController.clear();
      _messageController.clear();
    } on Exception catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(this.context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String? _requiredValidator(String? value) {
    return validateRequiredField(S.of(context), value);
  }
}

class SupportThreadScreen extends ConsumerStatefulWidget {
  const SupportThreadScreen({
    required this.requestId,
    this.isAdmin = false,
    super.key,
  });

  final String requestId;
  final bool isAdmin;

  @override
  ConsumerState<SupportThreadScreen> createState() =>
      _SupportThreadScreenState();
}

class _SupportThreadScreenState extends ConsumerState<SupportThreadScreen> {
  final _replyController = TextEditingController();
  bool _isSubmitting = false;
  bool _markRequested = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final threadAsync = ref.watch(supportThreadProvider(widget.requestId));
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    ref.listen<AsyncValue<SupportThreadRecord?>>(
      supportThreadProvider(widget.requestId),
      (_, next) {
        final thread = next.asData?.value;
        if (thread == null || _markRequested) {
          return;
        }
        final shouldMarkRead = widget.isAdmin
            ? thread.request.hasUnreadForAdmin
            : thread.request.hasUnreadForUser;
        if (!shouldMarkRead) {
          return;
        }
        _markRequested = true;
        unawaited(_markRead());
      },
    );

    return AppPageScaffold(
      title: s.supportThreadTitle,
      child: AppAsyncStateView<SupportThreadRecord?>(
        value: threadAsync,
        onRetry: () => ref.invalidate(supportThreadProvider(widget.requestId)),
        data: (thread) {
          if (thread == null) {
            return const AppNotFoundState();
          }

          final request = thread.request;
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(supportThreadProvider(widget.requestId));
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: request.subject,
                  subtitle: _supportStatusLabel(s, request.status),
                ),
                const SizedBox(height: AppSpacing.md),
                ProfileSummaryCard(
                  title: s.supportThreadDetailsTitle,
                  rows: [
                    ProfileSummaryRow(
                      label: s.supportStatusLabel,
                      value: _supportStatusLabel(s, request.status),
                    ),
                    ProfileSummaryRow(
                      label: s.supportPriorityLabel,
                      value: _supportPriorityLabel(s, request.priority),
                    ),
                    ProfileSummaryRow(
                      label: s.supportLastUpdatedLabel,
                      value: _formatSupportDate(context, request.lastMessageAt),
                    ),
                  ],
                ),
                if (request.bookingId != null ||
                    request.paymentProofId != null ||
                    request.disputeId != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      if (request.bookingId != null)
                        OutlinedButton(
                          onPressed: () => context.push(
                            AppRoutePath.sharedBookingDetail.replaceFirst(
                              ':id',
                              request.bookingId!,
                            ),
                          ),
                          child: Text(s.supportLinkedBookingAction),
                        ),
                      if (request.paymentProofId != null)
                        OutlinedButton(
                          onPressed: () => context.push(
                            AppRoutePath.sharedProofViewer.replaceFirst(
                              ':id',
                              request.paymentProofId!,
                            ),
                          ),
                          child: Text(s.supportLinkedPaymentProofAction),
                        ),
                      if (request.disputeId != null)
                        OutlinedButton(
                          onPressed: () => context.push(
                            AppRoutePath.adminQueuesDispute(request.disputeId!),
                          ),
                          child: Text(s.supportLinkedDisputeAction),
                        ),
                    ],
                  ),
                ],
                if (widget.isAdmin) ...[
                  const SizedBox(height: AppSpacing.md),
                  _AdminSupportControls(
                    request: request,
                    currentAdminId: auth?.userId,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                if (thread.messages.isEmpty)
                  AppEmptyState(
                    title: s.supportThreadTitle,
                    message: s.supportThreadNoMessagesMessage,
                  )
                else
                  Column(
                    children: thread.messages
                        .map(
                          (message) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: _SupportMessageBubble(
                              message: message,
                              isMine:
                                  auth?.userId != null &&
                                  message.senderProfileId == auth!.userId,
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                const SizedBox(height: AppSpacing.md),
                AuthCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        controller: _replyController,
                        label: s.supportReplyLabel,
                        maxLines: 4,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AuthSubmitButton(
                        label: s.supportReplyAction,
                        isLoading: _isSubmitting,
                        onPressed: () => unawaited(_reply(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _markRead() async {
    try {
      await ref
          .read(supportWorkflowControllerProvider)
          .markSupportRequestRead(widget.requestId);
    } on Exception {
      _markRequested = false;
    }
  }

  Future<void> _reply(BuildContext context) async {
    final s = S.of(context);
    final message = _replyController.text.trim();
    if (message.isEmpty) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      if (widget.isAdmin) {
        await ref
            .read(adminOperationsWorkflowControllerProvider)
            .replyToSupportRequest(
              requestId: widget.requestId,
              message: message,
            );
      } else {
        await ref
            .read(supportWorkflowControllerProvider)
            .replyToSupportRequest(
              requestId: widget.requestId,
              message: message,
            );
      }
      if (!mounted) return;
      _replyController.clear();
      AppFeedback.showSnackBar(this.context, s.supportReplySentMessage);
    } on Exception catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(this.context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _AdminSupportControls extends ConsumerWidget {
  const _AdminSupportControls({
    required this.request,
    required this.currentAdminId,
  });

  final SupportRequestRecord request;
  final String? currentAdminId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);

    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            s.adminSupportControlsTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<SupportRequestStatus>(
            initialValue: request.status,
            items: SupportRequestStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(_supportStatusLabel(s, status)),
                  ),
                )
                .toList(growable: false),
            decoration: InputDecoration(labelText: s.supportStatusLabel),
            onChanged: (status) {
              if (status == null || status == request.status) {
                return;
              }
              unawaited(
                ref
                    .read(adminOperationsWorkflowControllerProvider)
                    .setSupportRequestStatus(
                      requestId: request.id,
                      status: status,
                    ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: currentAdminId == null
                ? null
                : () => unawaited(
                    ref
                        .read(adminOperationsWorkflowControllerProvider)
                        .assignSupportRequest(
                          requestId: request.id,
                          assignedAdminId:
                              request.assignedAdminId == currentAdminId
                              ? null
                              : currentAdminId,
                        ),
                  ),
            icon: const Icon(Icons.assignment_ind_outlined),
            label: Text(
              request.assignedAdminId == currentAdminId
                  ? s.adminSupportUnassignAction
                  : s.adminSupportAssignToMeAction,
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportMessageBubble extends StatelessWidget {
  const _SupportMessageBubble({
    required this.message,
    required this.isMine,
  });

  final SupportMessageRecord message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final background = isMine
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _supportSenderLabel(s, message.senderType),
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(message.body),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formatSupportDate(context, message.createdAt),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LegalPoliciesScreen extends StatelessWidget {
  const LegalPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final supportEmail = configuredSupportEmailFromEnvironment();

    return AppPageScaffold(
      title: s.legalPoliciesTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.legalPoliciesTitle,
            subtitle: s.legalPoliciesDescription,
            showTitle: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (supportEmail != null) ...[
            AuthInfoBanner(
              message: s.supportConfiguredEmailMessage(supportEmail),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          AuthInfoBanner(message: s.legalPoliciesSupportHint),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalTermsTitle,
            body: s.legalTermsBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalPrivacyTitle,
            body: s.legalPrivacyBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalPaymentDisclosureTitle,
            body: s.legalPaymentDisclosureBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalDisputePolicyTitle,
            body: s.legalDisputePolicyBody,
          ),
        ],
      ),
    );
  }
}

class _PolicySectionCard extends StatelessWidget {
  const _PolicySectionCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

String? configuredSupportEmailFromEnvironment() {
  const direct = String.fromEnvironment('SUPPORT_EMAIL');
  final value = direct.trim();
  return value.isEmpty ? null : value;
}

String _supportStatusLabel(S s, SupportRequestStatus status) {
  return switch (status) {
    SupportRequestStatus.open => s.supportStatusOpenLabel,
    SupportRequestStatus.inProgress => s.supportStatusInProgressLabel,
    SupportRequestStatus.waitingForUser => s.supportStatusWaitingForUserLabel,
    SupportRequestStatus.resolved => s.supportStatusResolvedLabel,
    SupportRequestStatus.closed => s.supportStatusClosedLabel,
  };
}

String _supportPriorityLabel(S s, SupportRequestPriority priority) {
  return switch (priority) {
    SupportRequestPriority.normal => s.supportPriorityNormalLabel,
    SupportRequestPriority.high => s.supportPriorityHighLabel,
    SupportRequestPriority.urgent => s.supportPriorityUrgentLabel,
  };
}

String _supportSenderLabel(S s, SupportMessageSenderType senderType) {
  return switch (senderType) {
    SupportMessageSenderType.user => s.supportMessageSenderUserLabel,
    SupportMessageSenderType.admin => s.supportMessageSenderAdminLabel,
    SupportMessageSenderType.system => s.supportMessageSenderSystemLabel,
  };
}

String _formatSupportDate(BuildContext context, DateTime value) {
  final localizations = MaterialLocalizations.of(context);
  return BidiFormatters.latinIdentifier(
    '${localizations.formatShortDate(value)} ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(value))}',
  );
}
