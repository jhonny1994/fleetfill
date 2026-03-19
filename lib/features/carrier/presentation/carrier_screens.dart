import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CarrierShellScreen extends StatelessWidget {
  const CarrierShellScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppShellScaffold(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      body: navigationShell,
      destinations: [
        AppShellDestination(
          icon: Icons.home_outlined,
          label: s.carrierHomeNavLabel,
        ),
        AppShellDestination(
          icon: Icons.alt_route_rounded,
          label: s.myRoutesNavLabel,
        ),
        AppShellDestination(
          icon: Icons.local_shipping_outlined,
          label: s.carrierBookingsNavLabel,
        ),
        AppShellDestination(
          icon: Icons.person_outline_rounded,
          label: s.carrierProfileNavLabel,
        ),
      ],
    );
  }
}

class CarrierHomeScreen extends ConsumerWidget {
  const CarrierHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final vehicles = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.carrierHomeTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.carrierHomeTitle,
            subtitle: s.carrierHomeDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSummaryCard(
            title: s.carrierVerificationSummaryTitle,
            rows: [
              ProfileSummaryRow(
                label: s.carrierProfileVerificationLabel,
                value: verificationStatusLabel(
                  s,
                  auth?.profile?.verificationStatus,
                ),
              ),
              ProfileSummaryRow(
                label: s.vehiclesTitle,
                value: vehicles.asData?.value.length.toString() ?? '-',
              ),
              ProfileSummaryRow(
                label: s.payoutAccountsTitle,
                value: auth?.hasPayoutAccount == true
                    ? s.statusReadyLabel
                    : s.statusNeedsReviewLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (auth?.isCarrierVerified != true)
            AuthInfoBanner(
              message:
                  auth?.profile?.verificationRejectionReason?.isNotEmpty == true
                  ? s.carrierVerificationRejectedBanner(
                      auth!.profile!.verificationRejectionReason!,
                    )
                  : s.carrierVerificationPendingBanner,
            ),
          const SizedBox(height: AppSpacing.md),
          AppListCard(
            title: s.vehiclesTitle,
            subtitle: s.carrierVehiclesShortcutDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.go(AppRoutePath.carrierVehicles()),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.adminQueuesTitle,
            subtitle: s.carrierVerificationQueueHint,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.go(AppRoutePath.carrierProfile),
          ),
        ],
      ),
    );
  }
}

class CarrierBookingsScreen extends StatelessWidget {
  const CarrierBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.carrierBookingsTitle,
      description: s.carrierBookingsDescription,
    );
  }
}

class MyVehiclesScreen extends ConsumerWidget {
  const MyVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final vehicles = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.vehiclesTitle,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutePath.carrierVehicleCreate()),
        icon: const Icon(Icons.add_rounded),
        label: Text(s.vehicleCreateAction),
      ),
      child: AppAsyncStateView<List<CarrierVehicle>>(
        value: vehicles,
        onRetry: () => ref.invalidate(myVehiclesProvider),
        data: (items) {
          if (items.isEmpty) {
            return AppEmptyState(
              title: s.vehiclesTitle,
              message: s.vehiclesEmptyMessage,
              action: FilledButton(
                onPressed: () =>
                    context.push(AppRoutePath.carrierVehicleCreate()),
                child: Text(s.vehicleCreateAction),
              ),
            );
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final vehicle = items[index];
              final formattedCapacity = BidiFormatters.latinIdentifier(
                vehicle.capacityWeightKg.toStringAsFixed(0),
              );
              return AppListCard(
                title: BidiFormatters.licensePlate(vehicle.plateNumber),
                subtitle: '${vehicle.vehicleType} • $formattedCapacity kg',
                leading: _verificationChip(
                  s,
                  vehicle.verificationStatus,
                  vehicle.verificationRejectionReason,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () =>
                    context.push(AppRoutePath.carrierVehicleDetail(vehicle.id)),
              );
            },
          );
        },
      ),
    );
  }
}

class VehicleEditorScreen extends ConsumerStatefulWidget {
  const VehicleEditorScreen({super.key, this.vehicleId});

  final String? vehicleId;

  @override
  ConsumerState<VehicleEditorScreen> createState() =>
      _VehicleEditorScreenState();
}

class _VehicleEditorScreenState extends ConsumerState<VehicleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _typeController = TextEditingController();
  final _weightController = TextEditingController();
  final _volumeController = TextEditingController();
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _plateController.dispose();
    _typeController.dispose();
    _weightController.dispose();
    _volumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final vehicleAsync = widget.vehicleId == null
        ? const AsyncData<CarrierVehicle?>(null)
        : ref.watch(vehicleDetailProvider(widget.vehicleId!));

    return AppPageScaffold(
      title: widget.vehicleId == null
          ? s.vehicleCreateTitle
          : s.vehicleEditTitle,
      child: AppAsyncStateView<CarrierVehicle?>(
        value: vehicleAsync,
        onRetry: widget.vehicleId == null
            ? null
            : () => ref.invalidate(vehicleDetailProvider(widget.vehicleId!)),
        data: (vehicle) {
          if (!_initialized) {
            _plateController.text = vehicle?.plateNumber ?? '';
            _typeController.text = vehicle?.vehicleType ?? '';
            _weightController.text =
                vehicle?.capacityWeightKg.toStringAsFixed(0) ?? '';
            _volumeController.text =
                vehicle?.capacityVolumeM3?.toString() ?? '';
            _initialized = true;
          }

          return ListView(
            children: [
              AppSectionHeader(
                title: widget.vehicleId == null
                    ? s.vehicleCreateTitle
                    : s.vehicleEditTitle,
                subtitle: s.vehicleEditorDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthCard(
                child: AppFocusTraversal.form(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthTextField(
                          controller: _plateController,
                          label: s.vehiclePlateLabel,
                          textInputAction: TextInputAction.next,
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AuthTextField(
                          controller: _typeController,
                          label: s.vehicleTypeLabel,
                          textInputAction: TextInputAction.next,
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AuthTextField(
                          controller: _weightController,
                          label: s.vehicleCapacityWeightLabel,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: _positiveNumberValidator,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AuthTextField(
                          controller: _volumeController,
                          label: s.vehicleCapacityVolumeLabel,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textInputAction: TextInputAction.done,
                          validator: _optionalNumberValidator,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AuthSubmitButton(
                          label: widget.vehicleId == null
                              ? s.vehicleCreateAction
                              : s.vehicleSaveAction,
                          isLoading: _isSaving,
                          onPressed: () => unawaited(_save(vehicle)),
                        ),
                        if (vehicle != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          OutlinedButton.icon(
                            onPressed: _isSaving
                                ? null
                                : () => unawaited(_deleteVehicle(vehicle.id)),
                            icon: const Icon(Icons.delete_outline_rounded),
                            label: Text(s.vehicleDeleteAction),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _save(CarrierVehicle? vehicle) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final s = S.of(context);
    final repository = ref.read(vehicleRepositoryProvider);

    try {
      if (vehicle == null) {
        await repository.createVehicle(
          plateNumber: _plateController.text,
          vehicleType: _typeController.text,
          capacityWeightKg: double.parse(_weightController.text.trim()),
          capacityVolumeM3: _parseOptionalDouble(_volumeController.text),
        );
      } else {
        await repository.updateVehicle(
          vehicleId: vehicle.id,
          plateNumber: _plateController.text,
          vehicleType: _typeController.text,
          capacityWeightKg: double.parse(_weightController.text.trim()),
          capacityVolumeM3: _parseOptionalDouble(_volumeController.text),
        );
      }

      ref.invalidate(myVehiclesProvider);
      if (vehicle != null) {
        ref.invalidate(vehicleDetailProvider(vehicle.id));
      }
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        vehicle == null ? s.vehicleCreatedMessage : s.vehicleSavedMessage,
      );
      context.pop();
    } on AuthException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(
          context,
          mapAuthErrorMessage(s, error.message),
        );
      }
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _deleteVehicle(String vehicleId) async {
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppFocusTraversal.dialog(
        child: AlertDialog(
          title: Text(s.vehicleDeleteAction),
          content: Text(s.vehicleDeleteConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(s.cancelLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(s.confirmLabel),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref.read(vehicleRepositoryProvider).deleteVehicle(vehicleId);
      ref.invalidate(myVehiclesProvider);
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.vehicleDeletedMessage);
      context.pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  String? _requiredValidator(String? value) {
    return (value ?? '').trim().isEmpty
        ? S.of(context).authRequiredFieldMessage
        : null;
  }

  String? _positiveNumberValidator(String? value) {
    final normalized = double.tryParse((value ?? '').trim());
    if (normalized == null || normalized <= 0) {
      return S.of(context).vehiclePositiveNumberMessage;
    }
    return null;
  }

  String? _optionalNumberValidator(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return null;
    }
    final normalized = double.tryParse(trimmed);
    if (normalized == null || normalized <= 0) {
      return S.of(context).vehiclePositiveNumberMessage;
    }
    return null;
  }

  double? _parseOptionalDouble(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return double.tryParse(trimmed);
  }
}

class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));
    final documentsAsync = ref.watch(
      verificationDocumentsForEntityProvider(
        (entityType: VerificationEntityType.vehicle, entityId: vehicleId),
      ),
    );

    return AppPageScaffold(
      title: s.vehicleDetailTitle,
      actions: [
        IconButton(
          onPressed: () =>
              context.push(AppRoutePath.carrierVehicleEdit(vehicleId)),
          icon: const Icon(Icons.edit_outlined),
          tooltip: s.vehicleEditTitle,
        ),
      ],
      child: AppAsyncStateView<CarrierVehicle?>(
        value: vehicleAsync,
        onRetry: () => ref.invalidate(vehicleDetailProvider(vehicleId)),
        data: (vehicle) {
          if (vehicle == null) {
            return const AppNotFoundState();
          }

          final formattedPlateNumber = BidiFormatters.licensePlate(
            vehicle.plateNumber,
          );
          final formattedWeight = BidiFormatters.latinIdentifier(
            vehicle.capacityWeightKg.toStringAsFixed(0),
          );
          final formattedVolume = vehicle.capacityVolumeM3 == null
              ? '-'
              : BidiFormatters.latinIdentifier(
                  vehicle.capacityVolumeM3!.toStringAsFixed(1),
                );

          return ListView(
            children: [
              AppSectionHeader(
                title: formattedPlateNumber,
                subtitle: s.vehicleDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.vehicleSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.vehicleTypeLabel,
                    value: vehicle.vehicleType,
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value: '$formattedWeight kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: formattedVolume,
                  ),
                  ProfileSummaryRow(
                    label: s.carrierProfileVerificationLabel,
                    value: verificationStatusLabel(
                      s,
                      vehicle.verificationStatus,
                    ),
                  ),
                ],
              ),
              if ((vehicle.verificationRejectionReason ?? '').isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                AuthInfoBanner(
                  message: s.vehicleVerificationRejectedBanner(
                    vehicle.verificationRejectionReason!,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              _VerificationDocumentsSection(
                entityType: VerificationEntityType.vehicle,
                entityId: vehicle.id,
                documentsAsync: documentsAsync,
              ),
            ],
          );
        },
      ),
    );
  }
}

class CarrierVerificationCenterScreen extends ConsumerWidget {
  const CarrierVerificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final profileDocuments = ref.watch(
      verificationDocumentsForEntityProvider(
        (
          entityType: VerificationEntityType.profile,
          entityId: auth?.userId ?? '',
        ),
      ),
    );
    final vehicles = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.carrierVerificationCenterTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.carrierVerificationCenterTitle,
            subtitle: s.carrierVerificationCenterDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          _VerificationDocumentsSection(
            entityType: VerificationEntityType.profile,
            entityId: auth?.userId ?? '',
            documentsAsync: profileDocuments,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            s.vehiclesTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          vehicles.when(
            data: (items) {
              if (items.isEmpty) {
                return AppEmptyState(
                  title: s.vehiclesTitle,
                  message: s.vehiclesEmptyMessage,
                );
              }

              return Column(
                children: items
                    .map(
                      (vehicle) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppListCard(
                          title: vehicle.plateNumber,
                          subtitle: vehicle.vehicleType,
                          leading: _verificationChip(
                            s,
                            vehicle.verificationStatus,
                            vehicle.verificationRejectionReason,
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.push(
                            AppRoutePath.carrierVehicleDetail(vehicle.id),
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
                code: 'vehicles_load_failed',
                message: mapAppErrorMessage(s, error),
                technicalDetails: stackTrace.toString(),
              ),
              onRetry: () => ref.invalidate(myVehiclesProvider),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationDocumentsSection extends ConsumerWidget {
  const _VerificationDocumentsSection({
    required this.entityType,
    required this.entityId,
    required this.documentsAsync,
  });

  final VerificationEntityType entityType;
  final String entityId;
  final AsyncValue<List<VerificationDocumentRecord>> documentsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final supportedDocumentTypes = VerificationDocumentType.values
        .where(
          (type) => entityType == VerificationEntityType.profile
              ? type.isProfileDocument
              : !type.isProfileDocument,
        )
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entityType == VerificationEntityType.profile
              ? s.profileVerificationDocumentsTitle
              : s.vehicleVerificationDocumentsTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        documentsAsync.when(
          data: (documents) {
            final latestByType = {
              for (final document in latestVerificationDocumentsByType(
                documents,
              ))
                document.documentType: document,
            };

            return Column(
              children: supportedDocumentTypes
                  .map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppListCard(
                        title: _documentTypeLabel(s, type),
                        subtitle: _documentSubtitle(s, latestByType[type]),
                        leading: _verificationChip(
                          s,
                          latestByType[type]?.status ??
                              AppVerificationState.pending,
                          latestByType[type]?.rejectionReason,
                        ),
                        trailing: IconButton(
                          onPressed: () => unawaited(
                            _pickAndUploadDocument(
                              context,
                              ref,
                              type,
                              latestByType[type],
                            ),
                          ),
                          icon: const Icon(Icons.upload_file_outlined),
                          tooltip: latestByType[type] == null
                              ? s.verificationUploadAction
                              : s.verificationReplaceAction,
                        ),
                        onTap: latestByType[type] == null
                            ? null
                            : () => unawaited(
                                _openDocument(
                                  context,
                                  ref,
                                  latestByType[type]!,
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
              code: 'verification_documents_failed',
              message: mapAppErrorMessage(s, error),
              technicalDetails: stackTrace.toString(),
            ),
            onRetry: () => ref.invalidate(
              verificationDocumentsForEntityProvider(
                (entityType: entityType, entityId: entityId),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _documentTypeLabel(S s, VerificationDocumentType type) {
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

  String _documentSubtitle(S s, VerificationDocumentRecord? document) {
    if (document == null) {
      return s.verificationDocumentMissingMessage;
    }

    if ((document.rejectionReason ?? '').isNotEmpty) {
      return s.verificationDocumentRejectedMessage(document.rejectionReason!);
    }

    return switch (document.status) {
      AppVerificationState.verified => s.verificationDocumentVerifiedMessage,
      AppVerificationState.rejected =>
        s.verificationDocumentNeedsAttentionMessage,
      AppVerificationState.pending => s.verificationDocumentPendingMessage,
    };
  }

  Future<void> _pickAndUploadDocument(
    BuildContext context,
    WidgetRef ref,
    VerificationDocumentType type,
    VerificationDocumentRecord? currentDocument,
  ) async {
    final s = S.of(context);

    try {
      final uploadResult = await ref
          .read(verificationDocumentWorkflowControllerProvider)
          .pickAndUploadDocument(
            entityType: entityType,
            entityId: entityId,
            documentType: type,
            currentDocument: currentDocument,
          );
      if (uploadResult == null || !context.mounted) {
        return;
      }

      AppFeedback.showSnackBar(
        context,
        uploadResult.replacedExistingDocument
            ? s.verificationDocumentReplacedMessage
            : s.verificationDocumentUploadedMessage,
      );
      unawaited(
        context.push(
          AppRoutePath.sharedDocumentViewer.replaceFirst(
            ':id',
            uploadResult.document.id,
          ),
        ),
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }

  Future<void> _openDocument(
    BuildContext context,
    WidgetRef ref,
    VerificationDocumentRecord document,
  ) async {
    final s = S.of(context);

    try {
      unawaited(
        context.push(
          AppRoutePath.sharedDocumentViewer.replaceFirst(':id', document.id),
        ),
      );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        s.verificationDocumentOpenPreparedMessage,
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

Widget _verificationChip(
  S s,
  AppVerificationState state,
  String? rejectionReason,
) {
  final tone = switch (state) {
    AppVerificationState.verified => AppStatusTone.success,
    AppVerificationState.rejected => AppStatusTone.danger,
    AppVerificationState.pending => AppStatusTone.warning,
  };

  final label =
      state == AppVerificationState.rejected &&
          (rejectionReason ?? '').trim().isNotEmpty
      ? s.statusNeedsReviewLabel
      : verificationStatusLabel(s, state);

  return AppStatusChip(label: label, tone: tone);
}
