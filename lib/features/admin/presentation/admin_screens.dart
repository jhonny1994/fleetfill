import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          AppRoutePath.adminDashboard,
          AppRoutePath.adminQueues,
          AppRoutePath.adminUsers,
          AppRoutePath.adminSettings,
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
        AppShellDestination(
          icon: Icons.group_outlined,
          label: s.adminUsersNavLabel,
        ),
        AppShellDestination(
          icon: Icons.settings_outlined,
          label: s.adminSettingsNavLabel,
        ),
      ],
    );
  }
}

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final summaryAsync = ref.watch(adminOperationalSummaryProvider);
    final automationAlertsAsync = ref.watch(adminAutomationAlertsProvider);

    return AppPageScaffold(
      title: s.adminDashboardTitle,
      child: AppAsyncStateView<AdminOperationalSummary>(
        value: summaryAsync,
        onRetry: () => ref.invalidate(adminOperationalSummaryProvider),
        data: (summary) => ListView(
          key: const PageStorageKey<String>('admin-dashboard-list'),
          children: [
            AppSectionHeader(
              title: s.adminDashboardTitle,
              subtitle: s.adminDashboardDescription,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileSummaryCard(
              title: s.adminDashboardBacklogHealthTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.adminPaymentProofQueueTitle,
                  value: BidiFormatters.latinIdentifier(
                    summary.paymentProofs.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminVerificationQueueTitle,
                  value: BidiFormatters.latinIdentifier(
                    summary.verificationPackets.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminDisputesQueueTitle,
                  value: BidiFormatters.latinIdentifier(
                    summary.disputes.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminPayoutEligibleTitle,
                  value: BidiFormatters.latinIdentifier(
                    summary.eligiblePayouts.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ProfileSummaryCard(
              title: s.adminDashboardAutomationTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.adminDashboardOverdueDeliveryReviewsLabel,
                  value: BidiFormatters.latinIdentifier(
                    summary.overdueDeliveryReviews.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminDashboardOverduePaymentResubmissionsLabel,
                  value: BidiFormatters.latinIdentifier(
                    summary.overduePaymentResubmissions.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminAuditLogTitle,
                  value: BidiFormatters.latinIdentifier(
                    summary.auditEventsLast24h.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ProfileSummaryCard(
              title: s.adminDashboardEmailHealthTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.adminDashboardEmailBacklogLabel,
                  value: BidiFormatters.latinIdentifier(
                    summary.emailBacklog.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.adminDashboardDeadLetterLabel,
                  value: BidiFormatters.latinIdentifier(
                    summary.emailDeadLetter.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            automationAlertsAsync.when(
              data: (alerts) => alerts.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.adminDashboardAutomationTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ...alerts
                            .take(6)
                            .map(
                              (alert) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: AppListCard(
                                  title: alert.booking.trackingNumber,
                                  subtitle:
                                      alert.kind == 'delivery_review_overdue'
                                      ? s.adminDashboardOverdueDeliveryReviewsLabel
                                      : s.adminDashboardOverduePaymentResubmissionsLabel,
                                  trailing: const Icon(
                                    Icons.chevron_right_rounded,
                                  ),
                                  onTap: () => context.push(
                                    AppRoutePath.sharedBookingDetail
                                        .replaceFirst(
                                          ':id',
                                          alert.booking.id,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _AdminBookingSearchSection(),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutePath.adminQueues),
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: Text(s.adminQueuesNavLabel),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutePath.adminUsers),
                  icon: const Icon(Icons.group_outlined),
                  label: Text(s.adminUsersNavLabel),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutePath.adminSettings),
                  icon: const Icon(Icons.settings_outlined),
                  label: Text(s.adminSettingsNavLabel),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutePath.adminAuditLog),
                  icon: const Icon(Icons.history_rounded),
                  label: Text(s.adminAuditLogTitle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminBookingSearchSection extends ConsumerStatefulWidget {
  const _AdminBookingSearchSection();

  @override
  ConsumerState<_AdminBookingSearchSection> createState() =>
      _AdminBookingSearchSectionState();
}

class _AdminBookingSearchSectionState
    extends ConsumerState<_AdminBookingSearchSection> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _queryController.text.trim();
    final bookingsAsync = query.isEmpty
        ? const AsyncValue<List<BookingRecord>>.data(<BookingRecord>[])
        : ref.watch(adminBookingSearchResultsProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.bookingReviewTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: s.adminUsersSearchLabel,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        bookingsAsync.when(
          data: (bookings) {
            if (query.isEmpty) {
              return const SizedBox.shrink();
            }
            if (bookings.isEmpty) {
              return AppEmptyState(
                title: s.bookingReviewTitle,
                message: s.adminUsersEmptyMessage,
              );
            }
            return Column(
              children: bookings
                  .map(
                    (booking) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: booking.trackingNumber,
                        subtitle:
                            '${_bookingStatusLabel(s, booking.bookingStatus)} • ${_paymentStatusLabel(s, booking.paymentStatus)}',
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.push(
                          AppRoutePath.sharedBookingDetail.replaceFirst(
                            ':id',
                            booking.id,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'admin_bookings_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () =>
                ref.invalidate(adminBookingSearchResultsProvider(query)),
          ),
        ),
      ],
    );
  }
}

class AdminQueuesScreen extends ConsumerStatefulWidget {
  const AdminQueuesScreen({super.key});

  @override
  ConsumerState<AdminQueuesScreen> createState() => _AdminQueuesScreenState();
}

class _AdminQueuesScreenState extends ConsumerState<AdminQueuesScreen> {
  AdminQueueSegment _selectedSegment = AdminQueueSegment.payments;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.adminQueuesTitle,
      child: ListView(
        key: const PageStorageKey<String>('admin-queues-list'),
        children: [
          AppSectionHeader(
            title: s.adminQueuesTitle,
            subtitle: s.adminQueuesDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          SegmentedButton<AdminQueueSegment>(
            segments: [
              ButtonSegment(
                value: AdminQueueSegment.payments,
                label: Text(s.adminQueuePaymentsTabLabel),
                icon: const Icon(Icons.receipt_long_outlined),
              ),
              ButtonSegment(
                value: AdminQueueSegment.verification,
                label: Text(s.adminQueueVerificationTabLabel),
                icon: const Icon(Icons.verified_user_outlined),
              ),
              ButtonSegment(
                value: AdminQueueSegment.disputes,
                label: Text(s.adminQueueDisputesTabLabel),
                icon: const Icon(Icons.report_problem_outlined),
              ),
              ButtonSegment(
                value: AdminQueueSegment.payouts,
                label: Text(s.adminQueuePayoutsTabLabel),
                icon: const Icon(Icons.account_balance_wallet_outlined),
              ),
              ButtonSegment(
                value: AdminQueueSegment.email,
                label: Text(s.adminQueueEmailTabLabel),
                icon: const Icon(Icons.mail_outline_rounded),
              ),
            ],
            selected: {_selectedSegment},
            onSelectionChanged: (selection) {
              setState(() => _selectedSegment = selection.first);
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          switch (_selectedSegment) {
            AdminQueueSegment.payments => _AdminPaymentsQueueSection(),
            AdminQueueSegment.verification => _AdminVerificationQueueSection(),
            AdminQueueSegment.disputes => _AdminDisputesQueueSection(),
            AdminQueueSegment.payouts => _AdminPayoutsQueueSection(),
            AdminQueueSegment.email => _AdminEmailQueueSection(),
          },
        ],
      ),
    );
  }
}

class _AdminPaymentsQueueSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AdminPaymentsQueueSection> createState() =>
      _AdminPaymentsQueueSectionState();
}

class _AdminPaymentsQueueSectionState
    extends ConsumerState<_AdminPaymentsQueueSection> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _queryController.text.trim();
    final paymentProofsAsync = query.isEmpty
        ? ref.watch(pendingPaymentProofsProvider)
        : ref.watch(adminPaymentProofSearchResultsProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.adminPaymentProofQueueTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: s.adminEmailSearchLabel,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        paymentProofsAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return AppEmptyState(
                title: s.adminPaymentProofQueueTitle,
                message: s.adminPaymentProofQueueEmptyMessage,
              );
            }

            return Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: item.booking.trackingNumber,
                        subtitle:
                            '${_formatDate(item.proof.submittedAt)} • ${BidiFormatters.latinIdentifier(item.proof.submittedAmountDzd.toStringAsFixed(0))}',
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => unawaited(
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => _PaymentProofReviewSheet(
                              item: item,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'payment_proof_queue_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => query.isEmpty
                ? ref.invalidate(pendingPaymentProofsProvider)
                : ref.invalidate(adminPaymentProofSearchResultsProvider(query)),
          ),
        ),
      ],
    );
  }
}

class _AdminVerificationQueueSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AdminVerificationQueueSection> createState() =>
      _AdminVerificationQueueSectionState();
}

class _AdminVerificationQueueSectionState
    extends ConsumerState<_AdminVerificationQueueSection> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _queryController.text.trim();
    final packetsAsync = query.isEmpty
        ? ref.watch(pendingVerificationPacketsProvider)
        : ref.watch(adminVerificationQueueSearchResultsProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.adminVerificationQueueTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: s.adminUsersSearchLabel,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        packetsAsync.when(
          data: (packets) {
            if (packets.isEmpty) {
              return AppEmptyState(
                title: s.adminVerificationQueueTitle,
                message: s.adminVerificationQueueEmptyMessage,
              );
            }

            return Column(
              children: packets
                  .map(
                    (packet) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: packet.displayName,
                        subtitle: s.adminVerificationQueueItemSubtitle(
                          packet.pendingDocumentCount,
                          packet.vehicles.length,
                        ),
                        leading: AppStatusChip(
                          label: verificationStatusLabel(
                            s,
                            packet.profileStatus,
                          ),
                          tone:
                              packet.profileStatus ==
                                  AppVerificationState.rejected
                              ? AppStatusTone.danger
                              : packet.profileStatus ==
                                    AppVerificationState.verified
                              ? AppStatusTone.success
                              : AppStatusTone.warning,
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.push(
                          AppRoutePath.adminQueuesVerification(
                            packet.carrierId,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'verification_queue_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => query.isEmpty
                ? ref.invalidate(pendingVerificationPacketsProvider)
                : ref.invalidate(
                    adminVerificationQueueSearchResultsProvider(query),
                  ),
          ),
        ),
      ],
    );
  }
}

class _AdminDisputesQueueSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AdminDisputesQueueSection> createState() =>
      _AdminDisputesQueueSectionState();
}

class _AdminDisputesQueueSectionState
    extends ConsumerState<_AdminDisputesQueueSection> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _queryController.text.trim();
    final disputesAsync = query.isEmpty
        ? ref.watch(openDisputesProvider)
        : ref.watch(adminDisputeQueueSearchResultsProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.adminDisputesQueueTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: s.adminUsersSearchLabel,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        disputesAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return AppEmptyState(
                title: s.adminDisputesQueueTitle,
                message: s.adminDisputesQueueEmptyMessage,
              );
            }

            return Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: item.reason,
                        subtitle: item.description ?? item.bookingId,
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => unawaited(
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) =>
                                _DisputeResolutionSheet(item: item),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'dispute_queue_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => query.isEmpty
                ? ref.invalidate(openDisputesProvider)
                : ref.invalidate(adminDisputeQueueSearchResultsProvider(query)),
          ),
        ),
      ],
    );
  }
}

class _AdminPayoutsQueueSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AdminPayoutsQueueSection> createState() =>
      _AdminPayoutsQueueSectionState();
}

class _AdminPayoutsQueueSectionState
    extends ConsumerState<_AdminPayoutsQueueSection> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final releasedAsync = ref.watch(payoutsProvider);
    final query = _queryController.text.trim();
    final eligibleAsync = query.isEmpty
        ? ref.watch(adminEligiblePayoutsProvider)
        : ref.watch(adminEligiblePayoutSearchResultsProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.adminPayoutEligibleTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: s.adminUsersSearchLabel,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        eligibleAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return AppEmptyState(
                title: s.adminPayoutEligibleTitle,
                message: s.adminEligiblePayoutsEmptyMessage,
              );
            }

            return Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: item.booking.trackingNumber,
                        subtitle:
                            '${item.carrier?.companyName ?? item.carrier?.fullName ?? item.booking.carrierId} • ${BidiFormatters.latinIdentifier(item.booking.carrierPayoutDzd.toStringAsFixed(0))}',
                        trailing: FilledButton(
                          onPressed: () => unawaited(
                            ref
                                .read(
                                  adminDisputePayoutWorkflowControllerProvider,
                                )
                                .releasePayout(bookingId: item.booking.id),
                          ),
                          child: Text(s.adminPayoutReleaseAction),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'eligible_payout_queue_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => query.isEmpty
                ? ref.invalidate(adminEligiblePayoutsProvider)
                : ref.invalidate(
                    adminEligiblePayoutSearchResultsProvider(query),
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          s.adminPayoutQueueTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        releasedAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return AppEmptyState(
                title: s.adminPayoutQueueTitle,
                message: s.adminPayoutQueueEmptyMessage,
              );
            }

            return Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: item.bookingId,
                        subtitle:
                            '${BidiFormatters.latinIdentifier(item.amountDzd.toStringAsFixed(0))} • ${item.status}',
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'released_payout_queue_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => ref.invalidate(payoutsProvider),
          ),
        ),
      ],
    );
  }
}

class _AdminEmailQueueSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AdminEmailQueueSection> createState() =>
      _AdminEmailQueueSectionState();
}

class _AdminEmailQueueSectionState
    extends ConsumerState<_AdminEmailQueueSection> {
  final TextEditingController _queryController = TextEditingController();
  String? _selectedStatus;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final settingsAsync = ref.watch(adminPlatformSettingsProvider);
    final logsAsync = ref.watch(
      adminFilteredEmailLogsProvider(
        (status: _selectedStatus, query: _queryController.text.trim()),
      ),
    );
    final deadLettersAsync = ref.watch(adminDeadLetterEmailJobsProvider);
    final resendEnabled =
        settingsAsync.asData?.value
                .firstWhere(
                  (item) => item.key == 'feature_flags',
                  orElse: () => const PlatformSettingRecord(
                    key: 'feature_flags',
                    value: <String, dynamic>{
                      'admin_email_resend_enabled': true,
                    },
                    isPublic: false,
                    description: null,
                    updatedBy: null,
                    updatedAt: null,
                  ),
                )
                .value['admin_email_resend_enabled']
            as bool? ??
        true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.adminEmailQueueTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _queryController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(labelText: s.adminEmailSearchLabel),
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<String?>(
          initialValue: _selectedStatus,
          decoration: InputDecoration(labelText: s.adminEmailStatusFilterLabel),
          items: [
            DropdownMenuItem<String?>(child: Text(s.adminEmailStatusAllLabel)),
            ...[
              'queued',
              'sent',
              'delivered',
              'soft_failed',
              'hard_failed',
              'bounced',
              'suppressed',
            ].map(
              (status) => DropdownMenuItem<String?>(
                value: status,
                child: Text(_emailStatusLabel(s, status)),
              ),
            ),
          ],
          onChanged: (value) => setState(() => _selectedStatus = value),
        ),
        const SizedBox(height: AppSpacing.md),
        logsAsync.when(
          data: (logs) {
            if (logs.isEmpty) {
              return AppEmptyState(
                title: s.adminEmailQueueTitle,
                message: s.adminEmailQueueEmptyMessage,
              );
            }

            return Column(
              children: logs
                  .map(
                    (log) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: log.recipientEmail,
                        subtitle:
                            '${log.templateKey} • ${_emailStatusLabel(s, log.status)}',
                        trailing: resendEnabled && _canResendEmail(log.status)
                            ? TextButton(
                                onPressed: () => unawaited(_resend(log.id)),
                                child: Text(s.adminEmailResendAction),
                              )
                            : AppStatusChip(
                                label: _emailStatusLabel(s, log.status),
                                tone: _emailStatusTone(log.status),
                              ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'admin_email_logs_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => ref.invalidate(
              adminFilteredEmailLogsProvider(
                (status: _selectedStatus, query: _queryController.text.trim()),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          s.adminEmailDeadLetterTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        deadLettersAsync.when(
          data: (jobs) {
            if (jobs.isEmpty) {
              return AppEmptyState(
                title: s.adminEmailDeadLetterTitle,
                message: s.adminEmailDeadLetterEmptyMessage,
              );
            }

            return Column(
              children: jobs
                  .map(
                    (job) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: job.recipientEmail,
                        subtitle:
                            '${job.templateKey} • ${job.lastErrorMessage ?? job.status}',
                        leading: AppStatusChip(
                          label: s.adminEmailStatusDeadLetterLabel,
                          tone: AppStatusTone.danger,
                        ),
                        trailing: resendEnabled && _canResendDeadLetter(job)
                            ? TextButton(
                                onPressed: () =>
                                    unawaited(_resendDeadLetter(job.id)),
                                child: Text(s.adminEmailResendAction),
                              )
                            : null,
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'admin_dead_letter_email_jobs_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => ref.invalidate(adminDeadLetterEmailJobsProvider),
          ),
        ),
      ],
    );
  }

  Future<void> _resend(String deliveryLogId) async {
    final s = S.of(context);
    try {
      await ref
          .read(adminOperationsWorkflowControllerProvider)
          .resendEmail(deliveryLogId);
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.adminEmailResendSuccess);
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }

  Future<void> _resendDeadLetter(String jobId) async {
    final s = S.of(context);
    try {
      await ref
          .read(adminOperationsWorkflowControllerProvider)
          .resendDeadLetterEmail(jobId);
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.adminEmailResendSuccess);
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class AdminVerificationPacketScreen extends ConsumerWidget {
  const AdminVerificationPacketScreen({required this.carrierId, super.key});

  final String carrierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final packetAsync = ref.watch(pendingVerificationPacketProvider(carrierId));

    return AppPageScaffold(
      title: s.adminVerificationPacketTitle,
      child: AppAsyncStateView<VerificationReviewPacket?>(
        value: packetAsync,
        onRetry: () =>
            ref.invalidate(pendingVerificationPacketProvider(carrierId)),
        data: (packet) {
          if (packet == null) {
            return const AppNotFoundState();
          }

          return ListView(
            children: [
              AppSectionHeader(
                title: packet.displayName,
                subtitle: s.adminVerificationPacketDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: () => unawaited(_approveAll(context, ref, packet)),
                icon: const Icon(Icons.verified_rounded),
                label: Text(s.adminVerificationApproveAllAction),
              ),
              const SizedBox(height: AppSpacing.lg),
              _AdminDocumentGroup(
                title: s.profileVerificationDocumentsTitle,
                documents: packet.profileDocuments,
              ),
              const SizedBox(height: AppSpacing.lg),
              ...packet.vehicles.map(
                (vehicle) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _AdminVehicleGroup(vehicle: vehicle),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _approveAll(
    BuildContext context,
    WidgetRef ref,
    VerificationReviewPacket packet,
  ) async {
    final s = S.of(context);
    try {
      await ref
          .read(adminVerificationWorkflowControllerProvider)
          .approveAll(
            packet,
          );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.adminVerificationApproveAllSuccess);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class _AdminVehicleGroup extends StatelessWidget {
  const _AdminVehicleGroup({required this.vehicle});

  final VehicleVerificationOverview vehicle;

  @override
  Widget build(BuildContext context) {
    final formattedPlateNumber = BidiFormatters.licensePlate(
      vehicle.vehicle.plateNumber,
    );
    final formattedCapacityWeight = BidiFormatters.latinIdentifier(
      vehicle.vehicle.capacityWeightKg.toStringAsFixed(0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedPlateNumber,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        _AdminDocumentGroup(
          title: '${vehicle.vehicle.vehicleType} • $formattedCapacityWeight kg',
          documents: vehicle.documents,
        ),
      ],
    );
  }
}

class _AdminDocumentGroup extends ConsumerWidget {
  const _AdminDocumentGroup({required this.title, required this.documents});

  final String title;
  final List<VerificationDocumentRecord> documents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.md),
        if (documents.isEmpty)
          AppEmptyState(
            title: title,
            message: s.adminVerificationMissingDocumentsMessage,
          )
        else
          ...documents.map(
            (document) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _verificationDocumentLabel(
                                s,
                                document.documentType,
                              ),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          AppStatusChip(
                            label: verificationStatusLabel(s, document.status),
                            tone:
                                document.status == AppVerificationState.verified
                                ? AppStatusTone.success
                                : document.status ==
                                      AppVerificationState.rejected
                                ? AppStatusTone.danger
                                : AppStatusTone.warning,
                          ),
                        ],
                      ),
                      if ((document.rejectionReason ?? '').isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(document.rejectionReason!),
                      ],
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => context.push(
                                AppRoutePath.sharedDocumentViewer.replaceFirst(
                                  ':id',
                                  document.id,
                                ),
                              ),
                              child: Text(s.documentViewerOpenAction),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => unawaited(
                                _review(
                                  context,
                                  ref,
                                  document,
                                  AppVerificationState.rejected,
                                ),
                              ),
                              child: Text(s.adminVerificationRejectAction),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => unawaited(
                                _review(
                                  context,
                                  ref,
                                  document,
                                  AppVerificationState.verified,
                                ),
                              ),
                              child: Text(s.adminVerificationApproveAction),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _review(
    BuildContext context,
    WidgetRef ref,
    VerificationDocumentRecord document,
    AppVerificationState nextStatus,
  ) async {
    final s = S.of(context);
    String? reason;
    if (nextStatus == AppVerificationState.rejected) {
      reason = await _showReasonDialog(
        context,
        title: s.adminVerificationRejectReasonTitle,
        hintText: s.adminVerificationRejectReasonHint,
      );
      if (!context.mounted || reason == null || reason.trim().isEmpty) {
        return;
      }
    }

    try {
      await ref
          .read(adminVerificationWorkflowControllerProvider)
          .reviewDocument(
            document: document,
            nextStatus: nextStatus,
            reason: reason,
          );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        nextStatus == AppVerificationState.verified
            ? s.adminVerificationApprovedMessage
            : s.adminVerificationRejectedMessage,
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _queryController.text.trim();
    final usersAsync = query.isEmpty
        ? ref.watch(adminUsersProvider)
        : ref.watch(adminUserSearchResultsProvider(query));

    return AppPageScaffold(
      title: s.adminUsersTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.adminUsersTitle,
            subtitle: s.adminUsersDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _queryController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: s.adminUsersSearchLabel,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          usersAsync.when(
            data: (users) {
              if (users.isEmpty) {
                return AppEmptyState(
                  title: s.adminUsersTitle,
                  message: s.adminUsersEmptyMessage,
                );
              }

              return Column(
                children: users
                    .map(
                      (user) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppListCard(
                          title: user.displayName,
                          subtitle: user.profile.email,
                          leading: AppStatusChip(
                            label: _roleLabel(s, user.profile.role),
                            tone: user.profile.isActive
                                ? AppStatusTone.info
                                : AppStatusTone.danger,
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.push(
                            AppRoutePath.adminUserDetail(user.profile.id),
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'admin_users_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () {
                if (query.isEmpty) {
                  ref.invalidate(adminUsersProvider);
                } else {
                  ref.invalidate(adminUserSearchResultsProvider(query));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final detailAsync = ref.watch(adminUserDetailProvider(userId));

    return AppPageScaffold(
      title: s.userDetailTitle,
      child: AppAsyncStateView<AdminUserDetail?>(
        value: detailAsync,
        onRetry: () => ref.invalidate(adminUserDetailProvider(userId)),
        data: (detail) {
          if (detail == null) {
            return const AppNotFoundState();
          }

          final profile = detail.profile;
          final displayName = profile.companyName?.trim().isNotEmpty == true
              ? profile.companyName!
              : profile.fullName?.trim().isNotEmpty == true
              ? profile.fullName!
              : profile.email;

          return ListView(
            children: [
              AppSectionHeader(
                title: displayName,
                subtitle: s.userDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.adminUserAccountSectionTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.authEmailLabel,
                    value: profile.email,
                  ),
                  ProfileSummaryRow(
                    label: s.adminUserRoleLabel,
                    value: _roleLabel(s, profile.role),
                  ),
                  ProfileSummaryRow(
                    label: s.adminUserStatusLabel,
                    value: profile.isActive
                        ? s.adminUserStatusActiveLabel
                        : s.adminUserStatusSuspendedLabel,
                  ),
                  ProfileSummaryRow(
                    label: s.profilePhoneLabel,
                    value: profile.phoneNumber ?? '-',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: profile.isActive
                    ? OutlinedButton.icon(
                        onPressed: () => unawaited(
                          _toggleUserStatus(
                            context,
                            ref,
                            profile.id,
                            false,
                          ),
                        ),
                        icon: const Icon(Icons.block_outlined),
                        label: Text(s.adminUserSuspendAction),
                      )
                    : FilledButton.icon(
                        onPressed: () => unawaited(
                          _toggleUserStatus(
                            context,
                            ref,
                            profile.id,
                            true,
                          ),
                        ),
                        icon: const Icon(Icons.check_circle_outline),
                        label: Text(s.adminUserReactivateAction),
                      ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _AdminUserDetailListSection(
                title: s.adminUserBookingsSectionTitle,
                emptyMessage: s.adminUserBookingsEmptyMessage,
                children: detail.bookings
                    .map(
                      (booking) => AppListCard(
                        title: booking.trackingNumber,
                        subtitle:
                            '${_bookingStatusLabel(s, booking.bookingStatus)} • ${_paymentStatusLabel(s, booking.paymentStatus)}',
                        onTap: () => context.push(
                          AppRoutePath.sharedBookingDetail.replaceFirst(
                            ':id',
                            booking.id,
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: AppSpacing.xl),
              _AdminUserDetailListSection(
                title: s.adminUserVehiclesSectionTitle,
                emptyMessage: s.adminUserVehiclesEmptyMessage,
                children: detail.vehicles
                    .map(
                      (vehicle) => AppListCard(
                        title: BidiFormatters.licensePlate(vehicle.plateNumber),
                        subtitle:
                            '${vehicle.vehicleType} • ${verificationStatusLabel(s, vehicle.verificationStatus)}',
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: AppSpacing.xl),
              _AdminUserDetailListSection(
                title: s.adminUserDocumentsSectionTitle,
                emptyMessage: s.adminUserDocumentsEmptyMessage,
                children: detail.verificationDocuments
                    .map(
                      (document) => AppListCard(
                        title: _verificationDocumentLabel(
                          s,
                          document.documentType,
                        ),
                        subtitle: verificationStatusLabel(s, document.status),
                        onTap: () => context.push(
                          AppRoutePath.sharedDocumentViewer.replaceFirst(
                            ':id',
                            document.id,
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: AppSpacing.xl),
              _AdminUserDetailListSection(
                title: s.adminUserEmailSectionTitle,
                emptyMessage: s.adminUserEmailEmptyMessage,
                children: detail.emailLogs
                    .map(
                      (log) => AppListCard(
                        title: log.templateKey,
                        subtitle:
                            '${_emailStatusLabel(s, log.status)} • ${log.recipientEmail}',
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _toggleUserStatus(
    BuildContext context,
    WidgetRef ref,
    String profileId,
    bool isActive,
  ) async {
    final s = S.of(context);
    final reason = await _showReasonDialog(
      context,
      title: isActive ? s.adminUserReactivateAction : s.adminUserSuspendAction,
      hintText: s.adminUserReasonHint,
    );
    if (!context.mounted) {
      return;
    }

    try {
      await ref
          .read(adminOperationsWorkflowControllerProvider)
          .setUserActive(
            profileId: profileId,
            isActive: isActive,
            reason: reason,
          );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        isActive ? s.adminUserReactivateSuccess : s.adminUserSuspendSuccess,
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class _AdminUserDetailListSection extends StatelessWidget {
  const _AdminUserDetailListSection({
    required this.title,
    required this.emptyMessage,
    required this.children,
  });

  final String title;
  final String emptyMessage;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.md),
        if (children.isEmpty)
          AppEmptyState(title: title, message: emptyMessage)
        else
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: child,
            ),
          ),
      ],
    );
  }
}

class AdminSettingsScreen extends ConsumerStatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  ConsumerState<AdminSettingsScreen> createState() =>
      _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends ConsumerState<AdminSettingsScreen> {
  bool _initialized = false;
  bool _maintenanceMode = false;
  bool _forceUpdateRequired = false;
  final TextEditingController _androidVersionController =
      TextEditingController();
  final TextEditingController _iosVersionController = TextEditingController();
  final TextEditingController _platformFeeController = TextEditingController();
  final TextEditingController _insuranceRateController =
      TextEditingController();
  final TextEditingController _insuranceMinController = TextEditingController();
  final TextEditingController _paymentDeadlineController =
      TextEditingController();
  final TextEditingController _deliveryGraceController =
      TextEditingController();
  bool _adminEmailResendEnabled = true;

  @override
  void dispose() {
    _androidVersionController.dispose();
    _iosVersionController.dispose();
    _platformFeeController.dispose();
    _insuranceRateController.dispose();
    _insuranceMinController.dispose();
    _paymentDeadlineController.dispose();
    _deliveryGraceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final settingsAsync = ref.watch(adminPlatformSettingsProvider);
    final summaryAsync = ref.watch(adminOperationalSummaryProvider);

    return AppPageScaffold(
      title: s.adminSettingsTitle,
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutePath.adminAuditLog),
          icon: const Icon(Icons.history_rounded),
          tooltip: s.adminAuditLogTitle,
        ),
      ],
      child: AppAsyncStateView<List<PlatformSettingRecord>>(
        value: settingsAsync,
        onRetry: () => ref.invalidate(adminPlatformSettingsProvider),
        data: (settings) {
          _seedControllers(settings);
          return ListView(
            children: [
              AppSectionHeader(
                title: s.adminSettingsTitle,
                subtitle: s.adminSettingsDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              summaryAsync.when(
                data: (summary) => ProfileSummaryCard(
                  title: s.adminSettingsMonitoringSummaryTitle,
                  rows: [
                    ProfileSummaryRow(
                      label: s.adminDashboardEmailBacklogLabel,
                      value: BidiFormatters.latinIdentifier(
                        summary.emailBacklog.toString(),
                      ),
                    ),
                    ProfileSummaryRow(
                      label: s.adminDashboardDeadLetterLabel,
                      value: BidiFormatters.latinIdentifier(
                        summary.emailDeadLetter.toString(),
                      ),
                    ),
                    ProfileSummaryRow(
                      label: s.adminDashboardOverdueDeliveryReviewsLabel,
                      value: BidiFormatters.latinIdentifier(
                        summary.overdueDeliveryReviews.toString(),
                      ),
                    ),
                  ],
                ),
                loading: () => const AppLoadingState(),
                error: (error, stackTrace) => AppErrorState(
                  error: AppError(
                    code: 'admin_settings_summary_failed',
                    message: mapAppErrorMessage(s, error),
                    technicalDetails: stackTrace.toString(),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SettingsSection(
                title: s.adminSettingsRuntimeSectionTitle,
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: Text(s.adminSettingsMaintenanceModeLabel),
                      value: _maintenanceMode,
                      onChanged: (value) =>
                          setState(() => _maintenanceMode = value),
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: Text(s.adminSettingsForceUpdateLabel),
                      value: _forceUpdateRequired,
                      onChanged: (value) =>
                          setState(() => _forceUpdateRequired = value),
                    ),
                    AuthTextField(
                      controller: _androidVersionController,
                      label: s.adminSettingsMinimumAndroidVersionLabel,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _iosVersionController,
                      label: s.adminSettingsMinimumIosVersionLabel,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FilledButton(
                        onPressed: () =>
                            unawaited(_saveRuntimeSettings(context)),
                        child: Text(s.adminSettingsSaveAction),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SettingsSection(
                title: s.adminSettingsPricingSectionTitle,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _platformFeeController,
                      label: s.adminSettingsPlatformFeeRateLabel,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _insuranceRateController,
                      label: s.adminSettingsInsuranceRateLabel,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _insuranceMinController,
                      label: s.adminSettingsInsuranceMinimumLabel,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _paymentDeadlineController,
                      label: s.adminSettingsPaymentDeadlineLabel,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FilledButton(
                        onPressed: () =>
                            unawaited(_savePricingSettings(context)),
                        child: Text(s.adminSettingsSaveAction),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SettingsSection(
                title: s.adminSettingsDeliverySectionTitle,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _deliveryGraceController,
                      label: s.adminSettingsDeliveryGraceLabel,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FilledButton(
                        onPressed: () =>
                            unawaited(_saveDeliverySettings(context)),
                        child: Text(s.adminSettingsSaveAction),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SettingsSection(
                title: s.adminSettingsFeatureFlagsSectionTitle,
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: Text(s.adminSettingsEmailResendEnabledLabel),
                      value: _adminEmailResendEnabled,
                      onChanged: (value) =>
                          setState(() => _adminEmailResendEnabled = value),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FilledButton(
                        onPressed: () => unawaited(_saveFeatureFlags(context)),
                        child: Text(s.adminSettingsSaveAction),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _seedControllers(List<PlatformSettingRecord> settings) {
    if (_initialized) {
      return;
    }

    final byKey = {for (final setting in settings) setting.key: setting};
    final appRuntime = byKey['app_runtime']?.value ?? const <String, dynamic>{};
    final bookingPricing =
        byKey['booking_pricing']?.value ?? const <String, dynamic>{};
    final deliveryReview =
        byKey['delivery_review']?.value ?? const <String, dynamic>{};
    final featureFlags =
        byKey['feature_flags']?.value ?? const <String, dynamic>{};

    _maintenanceMode = appRuntime['maintenance_mode'] as bool? ?? false;
    _forceUpdateRequired =
        appRuntime['force_update_required'] as bool? ?? false;
    _androidVersionController.text =
        '${(appRuntime['minimum_supported_android_version'] as num?)?.toInt() ?? 1}';
    _iosVersionController.text =
        '${(appRuntime['minimum_supported_ios_version'] as num?)?.toInt() ?? 1}';
    _platformFeeController.text =
        '${(bookingPricing['platform_fee_rate'] as num?)?.toDouble() ?? 0.05}';
    _insuranceRateController.text =
        '${(bookingPricing['insurance_rate'] as num?)?.toDouble() ?? 0.01}';
    _insuranceMinController.text =
        '${(bookingPricing['insurance_min_fee_dzd'] as num?)?.toDouble() ?? 100}';
    _paymentDeadlineController.text =
        '${(bookingPricing['payment_resubmission_deadline_hours'] as num?)?.toInt() ?? 24}';
    _deliveryGraceController.text =
        '${(deliveryReview['grace_window_hours'] as num?)?.toInt() ?? 24}';
    _adminEmailResendEnabled =
        featureFlags['admin_email_resend_enabled'] as bool? ?? true;
    _initialized = true;
  }

  Future<void> _saveRuntimeSettings(BuildContext context) async {
    final s = S.of(context);
    final androidVersion = int.tryParse(_androidVersionController.text.trim());
    final iosVersion = int.tryParse(_iosVersionController.text.trim());
    if (androidVersion == null || iosVersion == null) {
      AppFeedback.showSnackBar(context, s.vehiclePositiveNumberMessage);
      return;
    }

    await _saveSetting(
      context,
      key: 'app_runtime',
      isPublic: true,
      description: s.adminSettingsRuntimeSectionTitle,
      value: {
        'maintenance_mode': _maintenanceMode,
        'force_update_required': _forceUpdateRequired,
        'minimum_supported_android_version': androidVersion,
        'minimum_supported_ios_version': iosVersion,
      },
    );
  }

  Future<void> _savePricingSettings(BuildContext context) async {
    final s = S.of(context);
    final platformFee = double.tryParse(_platformFeeController.text.trim());
    final insuranceRate = double.tryParse(_insuranceRateController.text.trim());
    final insuranceMin = double.tryParse(_insuranceMinController.text.trim());
    final deadline = int.tryParse(_paymentDeadlineController.text.trim());
    if (platformFee == null ||
        insuranceRate == null ||
        insuranceMin == null ||
        deadline == null) {
      AppFeedback.showSnackBar(context, s.vehiclePositiveNumberMessage);
      return;
    }

    await _saveSetting(
      context,
      key: 'booking_pricing',
      isPublic: true,
      description: s.adminSettingsPricingSectionTitle,
      value: {
        'platform_fee_rate': platformFee,
        'carrier_fee_rate': 0,
        'insurance_rate': insuranceRate,
        'insurance_min_fee_dzd': insuranceMin,
        'tax_rate': 0,
        'payment_resubmission_deadline_hours': deadline,
      },
    );
  }

  Future<void> _saveDeliverySettings(BuildContext context) async {
    final s = S.of(context);
    final grace = int.tryParse(_deliveryGraceController.text.trim());
    if (grace == null) {
      AppFeedback.showSnackBar(context, s.vehiclePositiveNumberMessage);
      return;
    }

    await _saveSetting(
      context,
      key: 'delivery_review',
      isPublic: true,
      description: s.adminSettingsDeliverySectionTitle,
      value: {'grace_window_hours': grace},
    );
  }

  Future<void> _saveFeatureFlags(BuildContext context) async {
    final s = S.of(context);
    await _saveSetting(
      context,
      key: 'feature_flags',
      isPublic: false,
      description: s.adminSettingsFeatureFlagsSectionTitle,
      value: {'admin_email_resend_enabled': _adminEmailResendEnabled},
    );
  }

  Future<void> _saveSetting(
    BuildContext context, {
    required String key,
    required bool isPublic,
    required String description,
    required Map<String, dynamic> value,
  }) async {
    final s = S.of(context);
    try {
      await ref
          .read(adminOperationsWorkflowControllerProvider)
          .updatePlatformSetting(
            key: key,
            value: value,
            isPublic: isPublic,
            description: description,
          );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.adminSettingsSavedMessage);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class AdminAuditLogScreen extends ConsumerWidget {
  const AdminAuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final logsAsync = ref.watch(adminAuditLogsProvider);

    return AppPageScaffold(
      title: s.adminAuditLogTitle,
      child: AppAsyncStateView<List<AdminAuditLogRecord>>(
        value: logsAsync,
        onRetry: () => ref.invalidate(adminAuditLogsProvider),
        data: (logs) {
          if (logs.isEmpty) {
            return AppEmptyState(
              title: s.adminAuditLogTitle,
              message: s.adminAuditLogEmptyMessage,
            );
          }

          return ListView(
            children: [
              AppSectionHeader(
                title: s.adminAuditLogTitle,
                subtitle: s.adminAuditLogDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ...logs.map(
                (log) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppListCard(
                    title: log.action,
                    subtitle:
                        '${log.targetType} • ${log.reason ?? log.outcome}',
                    trailing: log.createdAt == null
                        ? null
                        : Text(_formatDate(log.createdAt!)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _formatDate(DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

String _verificationDocumentLabel(S s, VerificationDocumentType type) {
  return switch (type) {
    VerificationDocumentType.driverIdentityOrLicense =>
      s.verificationDocumentDriverIdentityLabel,
    VerificationDocumentType.truckRegistration =>
      s.verificationDocumentTruckRegistrationLabel,
    VerificationDocumentType.truckInsurance =>
      s.verificationDocumentTruckInsuranceLabel,
    VerificationDocumentType.truckTechnicalInspection =>
      s.verificationDocumentTruckInspectionLabel,
    VerificationDocumentType.transportLicense =>
      s.verificationDocumentTransportLicenseLabel,
  };
}

Future<String?> _showReasonDialog(
  BuildContext context, {
  required String title,
  required String hintText,
}) async {
  final controller = TextEditingController();
  final s = S.of(context);

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AppFocusTraversal.dialog(
        child: AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(s.cancelLabel),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: Text(s.confirmLabel),
            ),
          ],
        ),
      );
    },
  );
}

String _roleLabel(S s, AppUserRole? role) {
  return switch (role) {
    AppUserRole.shipper => s.adminUserRoleShipperLabel,
    AppUserRole.carrier => s.adminUserRoleCarrierLabel,
    AppUserRole.admin => s.adminUserRoleAdminLabel,
    null => '-',
  };
}

String _bookingStatusLabel(S s, BookingStatus status) {
  return switch (status) {
    BookingStatus.pendingPayment => s.bookingStatusPendingPaymentLabel,
    BookingStatus.paymentUnderReview => s.bookingStatusPaymentUnderReviewLabel,
    BookingStatus.confirmed => s.bookingStatusConfirmedLabel,
    BookingStatus.pickedUp => s.bookingStatusPickedUpLabel,
    BookingStatus.inTransit => s.bookingStatusInTransitLabel,
    BookingStatus.deliveredPendingReview =>
      s.bookingStatusDeliveredPendingReviewLabel,
    BookingStatus.completed => s.bookingStatusCompletedLabel,
    BookingStatus.cancelled => s.bookingStatusCancelledLabel,
    BookingStatus.disputed => s.bookingStatusDisputedLabel,
  };
}

String _paymentStatusLabel(S s, PaymentStatus status) {
  return switch (status) {
    PaymentStatus.unpaid => s.paymentStatusUnpaidLabel,
    PaymentStatus.proofSubmitted => s.paymentStatusProofSubmittedLabel,
    PaymentStatus.underVerification => s.paymentStatusUnderVerificationLabel,
    PaymentStatus.secured => s.paymentStatusSecuredLabel,
    PaymentStatus.rejected => s.paymentStatusRejectedLabel,
    PaymentStatus.refunded => s.paymentStatusRefundedLabel,
    PaymentStatus.releasedToCarrier => s.paymentStatusReleasedToCarrierLabel,
  };
}

String _emailStatusLabel(S s, String status) {
  return switch (status) {
    'queued' => s.adminEmailStatusQueuedLabel,
    'sent' => s.adminEmailStatusSentLabel,
    'delivered' => s.adminEmailStatusDeliveredLabel,
    'soft_failed' => s.adminEmailStatusSoftFailedLabel,
    'hard_failed' => s.adminEmailStatusHardFailedLabel,
    'bounced' => s.adminEmailStatusBouncedLabel,
    'suppressed' => s.adminEmailStatusSuppressedLabel,
    'dead_letter' => s.adminEmailStatusDeadLetterLabel,
    _ => status,
  };
}

bool _canResendEmail(String status) {
  return status == 'soft_failed';
}

bool _canResendDeadLetter(EmailOutboxJobRecord job) {
  final errorCode = (job.lastErrorCode ?? '').toLowerCase();
  return !errorCode.contains('bounce') &&
      !errorCode.contains('invalid') &&
      !errorCode.contains('suppress') &&
      !errorCode.contains('hard');
}

AppStatusTone _emailStatusTone(String status) {
  return switch (status) {
    'delivered' => AppStatusTone.success,
    'queued' || 'sent' => AppStatusTone.info,
    'soft_failed' => AppStatusTone.warning,
    'hard_failed' ||
    'bounced' ||
    'suppressed' ||
    'dead_letter' => AppStatusTone.danger,
    _ => AppStatusTone.neutral,
  };
}

class _PaymentProofReviewSheet extends ConsumerStatefulWidget {
  const _PaymentProofReviewSheet({required this.item});

  final AdminPaymentProofQueueItem item;

  @override
  ConsumerState<_PaymentProofReviewSheet> createState() =>
      _PaymentProofReviewSheetState();
}

class _PaymentProofReviewSheetState
    extends ConsumerState<_PaymentProofReviewSheet> {
  late final TextEditingController _amountController;
  late final TextEditingController _referenceController;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.item.booking.shipperTotalDzd.toStringAsFixed(0),
    );
    _referenceController = TextEditingController(
      text:
          widget.item.proof.submittedReference ??
          widget.item.booking.paymentReference,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _reasonController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final item = widget.item;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            s.adminPaymentProofQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileSummaryCard(
            title: item.booking.trackingNumber,
            rows: [
              ProfileSummaryRow(
                label: s.bookingPaymentReferenceLabel,
                value: item.booking.paymentReference,
              ),
              ProfileSummaryRow(
                label: s.paymentProofAmountLabel,
                value: BidiFormatters.latinIdentifier(
                  item.proof.submittedAmountDzd.toStringAsFixed(0),
                ),
              ),
              ProfileSummaryRow(
                label: s.paymentProofReferenceLabel,
                value: item.proof.submittedReference ?? '-',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push(
                    AppRoutePath.sharedProofViewer.replaceFirst(
                      ':id',
                      item.proof.id,
                    ),
                  ),
                  child: Text(s.documentViewerOpenAction),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _amountController,
            label: s.paymentProofVerifiedAmountLabel,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _referenceController,
            label: s.paymentProofVerifiedReferenceLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _noteController,
            label: s.paymentProofDecisionNoteLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _reasonController,
            label: s.paymentProofRejectionReasonLabel,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting ? null : () => unawaited(_reject()),
                  child: Text(s.adminVerificationRejectAction),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton(
                  onPressed: _isSubmitting ? null : () => unawaited(_approve()),
                  child: Text(s.adminVerificationApproveAction),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _approve() async {
    final s = S.of(context);
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(adminPaymentWorkflowControllerProvider)
          .approvePaymentProof(
            proofId: widget.item.proof.id,
            verifiedAmountDzd: double.parse(_amountController.text.trim()),
            verifiedReference: _referenceController.text,
            decisionNote: _noteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.paymentProofApprovedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _reject() async {
    final s = S.of(context);
    if (_reasonController.text.trim().isEmpty) {
      AppFeedback.showSnackBar(
        context,
        s.paymentProofRejectionReasonRequiredMessage,
      );
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(adminPaymentWorkflowControllerProvider)
          .rejectPaymentProof(
            proofId: widget.item.proof.id,
            rejectionReason: _reasonController.text,
            decisionNote: _noteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.paymentProofRejectedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _DisputeResolutionSheet extends ConsumerStatefulWidget {
  const _DisputeResolutionSheet({required this.item});

  final DisputeRecord item;

  @override
  ConsumerState<_DisputeResolutionSheet> createState() =>
      _DisputeResolutionSheetState();
}

class _DisputeResolutionSheetState
    extends ConsumerState<_DisputeResolutionSheet> {
  final TextEditingController _refundAmountController = TextEditingController();
  final TextEditingController _refundReasonController = TextEditingController();
  final TextEditingController _externalReferenceController =
      TextEditingController();
  final TextEditingController _resolutionNoteController =
      TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _refundAmountController.dispose();
    _refundReasonController.dispose();
    _externalReferenceController.dispose();
    _resolutionNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final evidenceAsync = ref.watch(disputeEvidenceProvider(widget.item.id));
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            s.adminDisputesQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileSummaryCard(
            title: widget.item.reason,
            rows: [
              ProfileSummaryRow(
                label: s.shipmentDescriptionLabel,
                value: widget.item.description ?? '-',
              ),
              ProfileSummaryRow(
                label: s.routeStatusLabel,
                value: widget.item.status,
              ),
              ProfileSummaryRow(
                label: s.disputeEvidenceTitle,
                value: widget.item.evidenceCount.toString(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            s.disputeEvidenceTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          evidenceAsync.when(
            data: (items) => items.isEmpty
                ? Text(s.disputeEvidenceEmptyMessage)
                : Column(
                    children: items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: AppListCard(
                              title: item.note?.trim().isNotEmpty == true
                                  ? item.note!
                                  : item.storagePath.split('/').last,
                              subtitle: item.contentType ?? '-',
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () => context.push(
                                AppRoutePath.sharedDisputeEvidenceViewer
                                    .replaceFirst(':id', item.id),
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'dispute_evidence_load_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () =>
                  ref.invalidate(disputeEvidenceProvider(widget.item.id)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _resolutionNoteController,
            label: s.paymentProofDecisionNoteLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _refundAmountController,
            label: s.paymentProofAmountLabel,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _refundReasonController,
            label: s.paymentProofRejectionReasonLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: _externalReferenceController,
            label: s.paymentProofVerifiedReferenceLabel,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => unawaited(_resolveComplete()),
                  child: Text(s.bookingStatusCompletedLabel),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => unawaited(_resolveRefund()),
                  child: Text(s.paymentStatusRefundedLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _resolveComplete() async {
    final s = S.of(context);
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(adminDisputePayoutWorkflowControllerProvider)
          .resolveDisputeComplete(
            disputeId: widget.item.id,
            resolutionNote: _resolutionNoteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.bookingStatusCompletedLabel);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _resolveRefund() async {
    final s = S.of(context);
    final amount = double.tryParse(_refundAmountController.text.trim());
    if (amount == null ||
        amount <= 0 ||
        _refundReasonController.text.trim().isEmpty) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(adminDisputePayoutWorkflowControllerProvider)
          .resolveDisputeRefund(
            disputeId: widget.item.id,
            refundAmountDzd: amount,
            refundReason: _refundReasonController.text,
            externalReference: _externalReferenceController.text,
            resolutionNote: _resolutionNoteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.paymentStatusRefundedLabel);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
