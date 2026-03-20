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
    final queueAsync = ref.watch(pendingVerificationPacketsProvider);
    final paymentProofsAsync = ref.watch(pendingPaymentProofsProvider);

    return AppPageScaffold(
      title: s.adminDashboardTitle,
      child: ListView(
        key: const PageStorageKey<String>('admin-dashboard-list'),
        children: [
          AppSectionHeader(
            title: s.adminDashboardTitle,
            subtitle: s.adminDashboardDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          queueAsync.when(
            data: (packets) => ProfileSummaryCard(
              title: s.adminVerificationQueueSummaryTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.adminQueuesNavLabel,
                  value: packets.length.toString(),
                ),
                ProfileSummaryRow(
                  label: s.adminVerificationPendingDocumentsLabel,
                  value: packets
                      .fold<int>(
                        0,
                        (sum, packet) => sum + packet.pendingDocumentCount,
                      )
                      .toString(),
                ),
                ProfileSummaryRow(
                  label: s.adminPaymentProofQueueTitle,
                  value: paymentProofsAsync.asData?.value.length.toString() ?? '-',
                ),
              ],
            ),
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'admin_dashboard_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () => ref.invalidate(pendingVerificationPacketsProvider),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminQueuesScreen extends ConsumerWidget {
  const AdminQueuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final packetsAsync = ref.watch(pendingVerificationPacketsProvider);
    final auditAsync = ref.watch(verificationAuditProvider);
    final paymentProofsAsync = ref.watch(pendingPaymentProofsProvider);
    final disputesAsync = ref.watch(openDisputesProvider);
    final payoutsAsync = ref.watch(payoutsProvider);

    return AppPageScaffold(
      title: s.adminQueuesTitle,
      child: ListView(
        key: const PageStorageKey<String>('admin-audit-log-list'),
        children: [
          AppSectionHeader(
            title: s.adminQueuesTitle,
            subtitle: s.adminQueuesDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            s.adminVerificationQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
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
              onRetry: () => ref.invalidate(pendingVerificationPacketsProvider),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            s.adminPaymentProofQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
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
                          subtitle: '${_formatDate(item.proof.submittedAt)} • ${BidiFormatters.latinIdentifier(item.proof.submittedAmountDzd.toStringAsFixed(0))}',
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => unawaited(
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => _PaymentProofReviewSheet(item: item),
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
              onRetry: () => ref.invalidate(pendingPaymentProofsProvider),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            s.adminDisputesQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
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
                              builder: (context) => _DisputeResolutionSheet(item: item),
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
              onRetry: () => ref.invalidate(openDisputesProvider),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            s.adminPayoutQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          payoutsAsync.when(
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
                          subtitle: '${BidiFormatters.latinIdentifier(item.amountDzd.toStringAsFixed(0))} • ${item.status}',
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'payout_queue_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () => ref.invalidate(payoutsProvider),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            s.adminVerificationAuditTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          auditAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return AppEmptyState(
                  title: s.adminVerificationAuditTitle,
                  message: s.adminVerificationAuditEmptyMessage,
                );
              }

              return Column(
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppListCard(
                          title: item.action,
                          subtitle: item.reason ?? item.outcome,
                          trailing: item.createdAt == null
                              ? null
                              : Text(_formatDate(item.createdAt!)),
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'verification_audit_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () => ref.invalidate(verificationAuditProvider),
            ),
          ),
        ],
      ),
    );
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
                              _documentLabel(s, document.documentType),
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
      reason = await _showReasonDialog(context);
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

  Future<String?> _showReasonDialog(BuildContext context) async {
    final controller = TextEditingController();
    final s = S.of(context);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AppFocusTraversal.dialog(
          child: AlertDialog(
            title: Text(s.adminVerificationRejectReasonTitle),
            content: TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: s.adminVerificationRejectReasonHint,
              ),
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

  String _documentLabel(S s, VerificationDocumentType type) {
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

String _formatDate(DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

class _PaymentProofReviewSheet extends ConsumerStatefulWidget {
  const _PaymentProofReviewSheet({required this.item});

  final AdminPaymentProofQueueItem item;

  @override
  ConsumerState<_PaymentProofReviewSheet> createState() => _PaymentProofReviewSheetState();
}

class _PaymentProofReviewSheetState extends ConsumerState<_PaymentProofReviewSheet> {
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
      text: widget.item.proof.submittedReference ?? widget.item.booking.paymentReference,
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
          Text(s.adminPaymentProofQueueTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ProfileSummaryCard(
            title: item.booking.trackingNumber,
            rows: [
              ProfileSummaryRow(label: s.bookingPaymentReferenceLabel, value: item.booking.paymentReference),
              ProfileSummaryRow(label: s.paymentProofAmountLabel, value: BidiFormatters.latinIdentifier(item.proof.submittedAmountDzd.toStringAsFixed(0))),
              ProfileSummaryRow(label: s.paymentProofReferenceLabel, value: item.proof.submittedReference ?? '-'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push(
                    AppRoutePath.sharedProofViewer.replaceFirst(':id', item.proof.id),
                  ),
                  child: Text(s.documentViewerOpenAction),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _amountController, label: s.paymentProofVerifiedAmountLabel, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _referenceController, label: s.paymentProofVerifiedReferenceLabel),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _noteController, label: s.paymentProofDecisionNoteLabel),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _reasonController, label: s.paymentProofRejectionReasonLabel),
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
      await ref.read(adminPaymentWorkflowControllerProvider).approvePaymentProof(
            proofId: widget.item.proof.id,
            verifiedAmountDzd: double.parse(_amountController.text.trim()),
            verifiedReference: _referenceController.text,
            decisionNote: _noteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.paymentProofApprovedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _reject() async {
    final s = S.of(context);
    if (_reasonController.text.trim().isEmpty) {
      AppFeedback.showSnackBar(context, s.paymentProofRejectionReasonRequiredMessage);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref.read(adminPaymentWorkflowControllerProvider).rejectPaymentProof(
            proofId: widget.item.proof.id,
            rejectionReason: _reasonController.text,
            decisionNote: _noteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.paymentProofRejectedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _DisputeResolutionSheet extends ConsumerStatefulWidget {
  const _DisputeResolutionSheet({required this.item});

  final DisputeRecord item;

  @override
  ConsumerState<_DisputeResolutionSheet> createState() => _DisputeResolutionSheetState();
}

class _DisputeResolutionSheetState extends ConsumerState<_DisputeResolutionSheet> {
  final TextEditingController _refundAmountController = TextEditingController();
  final TextEditingController _refundReasonController = TextEditingController();
  final TextEditingController _externalReferenceController = TextEditingController();
  final TextEditingController _resolutionNoteController = TextEditingController();
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
          Text(s.adminDisputesQueueTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ProfileSummaryCard(
            title: widget.item.reason,
            rows: [
              ProfileSummaryRow(label: s.shipmentDescriptionLabel, value: widget.item.description ?? '-'),
              ProfileSummaryRow(label: s.routeStatusLabel, value: widget.item.status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _resolutionNoteController, label: s.paymentProofDecisionNoteLabel),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _refundAmountController, label: s.paymentProofAmountLabel, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _refundReasonController, label: s.paymentProofRejectionReasonLabel),
          const SizedBox(height: AppSpacing.md),
          AuthTextField(controller: _externalReferenceController, label: s.paymentProofVerifiedReferenceLabel),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting ? null : () => unawaited(_resolveComplete()),
                  child: Text(s.bookingStatusCompletedLabel),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton(
                  onPressed: _isSubmitting ? null : () => unawaited(_resolveRefund()),
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
      await ref.read(adminDisputePayoutWorkflowControllerProvider).resolveDisputeComplete(
            disputeId: widget.item.id,
            resolutionNote: _resolutionNoteController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.bookingStatusCompletedLabel);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _resolveRefund() async {
    final s = S.of(context);
    final amount = double.tryParse(_refundAmountController.text.trim());
    if (amount == null || amount <= 0 || _refundReasonController.text.trim().isEmpty) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref.read(adminDisputePayoutWorkflowControllerProvider).resolveDisputeRefund(
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
      if (mounted) AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
