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

    return AppPageScaffold(
      title: s.adminDashboardTitle,
      child: ListView(
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
              ],
            ),
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              error: AppError(
                code: 'admin_dashboard_failed',
                message: error.toString(),
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

    return AppPageScaffold(
      title: s.adminQueuesTitle,
      child: ListView(
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
                message: error.toString(),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () => ref.invalidate(pendingVerificationPacketsProvider),
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
                message: error.toString(),
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
        AppFeedback.showSnackBar(context, error.message);
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
        AppFeedback.showSnackBar(context, error.message);
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
