import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CarrierShellScreen extends ConsumerWidget {
  const CarrierShellScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    return AppShellScaffold(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => _handleDestinationSelected(
        context,
        ref,
        auth,
        index,
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

  void _handleDestinationSelected(
    BuildContext context,
    WidgetRef ref,
    AuthSnapshot? auth,
    int index,
  ) {
    final blocker = _blockerForReason(
      carrierNavigationBlockReasonForIndex(auth, index),
    );
    if (blocker != null) {
      unawaited(_showCarrierGateDialog(context, blocker));
      return;
    }

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  _CarrierNavBlocker? _blockerForReason(CarrierNavigationBlockReason? reason) {
    return switch (reason) {
      CarrierNavigationBlockReason.phone => _CarrierNavBlocker.phone(),
      CarrierNavigationBlockReason.verification =>
        _CarrierNavBlocker.verification(),
      null => null,
    };
  }

  Future<void> _showCarrierGateDialog(
    BuildContext context,
    _CarrierNavBlocker blocker,
  ) async {
    final s = S.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AppFocusTraversal.dialog(
        child: AlertDialog(
          title: Text(blocker.title(s)),
          content: Text(blocker.message(s)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(s.cancelLabel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(blocker.nextRoute);
              },
              child: Text(blocker.actionLabel(s)),
            ),
          ],
        ),
      ),
    );
  }
}

enum CarrierNavigationBlockReason {
  phone,
  verification,
}

CarrierNavigationBlockReason? carrierNavigationBlockReasonForIndex(
  AuthSnapshot? auth,
  int index,
) {
  if (auth == null) {
    return null;
  }
  final needsPhone = !auth.hasPhoneNumber;
  final needsVerification = !auth.isCarrierVerified;

  return switch (index) {
    1 when needsPhone => CarrierNavigationBlockReason.phone,
    1 when needsVerification => CarrierNavigationBlockReason.verification,
    2 when needsPhone => CarrierNavigationBlockReason.phone,
    2 when needsVerification => CarrierNavigationBlockReason.verification,
    _ => null,
  };
}

class _CarrierNavBlocker {
  const _CarrierNavBlocker._({
    required this.nextRoute,
    required this.title,
    required this.message,
    required this.actionLabel,
  });

  _CarrierNavBlocker.phone()
    : this._(
        nextRoute: AppRoutePath.phoneCompletion,
        title: _phoneTitle,
        message: _phoneMessage,
        actionLabel: _phoneAction,
      );

  _CarrierNavBlocker.verification()
    : this._(
        nextRoute: AppRoutePath.carrierVerification,
        title: _verificationTitle,
        message: _verificationMessage,
        actionLabel: _verificationAction,
      );

  final String nextRoute;
  final String Function(S) title;
  final String Function(S) message;
  final String Function(S) actionLabel;

  static String _phoneTitle(S s) => s.carrierGatePhoneTitle;
  static String _phoneMessage(S s) => s.carrierGatePhoneMessage;
  static String _phoneAction(S s) => s.phoneCompletionTitle;
  static String _verificationTitle(S s) => s.carrierGateVerificationTitle;
  static String _verificationMessage(S s) => s.carrierGateVerificationMessage;
  static String _verificationAction(S s) => s.carrierVerificationCenterTitle;
}

class CarrierHomeScreen extends ConsumerWidget {
  const CarrierHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final vehicles = ref.watch(myVehiclesProvider);
    final bookingsAsync = ref.watch(carrierBookingsProvider);
    final bookings = bookingsAsync.asData?.value ?? const <BookingRecord>[];
    final activeBookings = bookings
        .where(
          (booking) =>
              booking.bookingStatus != BookingStatus.completed &&
              booking.bookingStatus != BookingStatus.cancelled,
        )
        .toList(growable: false);
    final payoutReadyCount = bookings
        .where(
          (booking) =>
              booking.bookingStatus == BookingStatus.completed &&
              booking.paymentStatus == PaymentStatus.secured,
        )
        .length;
    final focusBooking = _highestPriorityCarrierBooking(bookings);

    return AppPageScaffold(
      title: s.carrierHomeTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(myVehiclesProvider)
            ..invalidate(carrierBookingsProvider);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AppSectionHeader(
              title: s.carrierHomeTitle,
              subtitle: s.carrierHomeDescription,
              showTitle: false,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileSummaryCard(
              title: s.carrierVerificationSummaryTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.carrierBookingsTitle,
                  value: BidiFormatters.latinIdentifier(
                    activeBookings.length.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.carrierProfileVerificationLabel,
                  value: verificationStatusLabel(
                    s,
                    auth?.carrierVerificationStatus,
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
                      : s.statusSetupRequiredLabel,
                ),
                ProfileSummaryRow(
                  label: s.carrierPayoutEligibleNowLabel,
                  value: BidiFormatters.latinIdentifier(
                    payoutReadyCount.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (auth?.isCarrierVerified != true)
              AuthInfoBanner(
                message:
                    auth?.carrierVerificationRejectionReason?.isNotEmpty == true
                    ? s.carrierVerificationRejectedBanner(
                        auth!.carrierVerificationRejectionReason!,
                      )
                    : s.carrierVerificationPendingBanner,
              ),
            const SizedBox(height: AppSpacing.md),
            Text(
              s.bookingNextActionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (focusBooking != null) ...[
              _CarrierOperationalFocusCard(
                title: focusBooking.trackingNumber,
                stateLabel: _carrierBookingFocusLabel(s, focusBooking),
                message: _carrierBookingFocusMessage(s, focusBooking),
                tone: _carrierBookingFocusTone(focusBooking),
                onPressed: () => context.push(
                  AppRoutePath.sharedTrackingDetail.replaceFirst(
                    ':id',
                    focusBooking.id,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ] else
              AppStateMessage(
                icon: Icons.task_alt_rounded,
                title: s.operationsActiveLabel,
                message: s.carrierActiveBookingsEmptyMessage,
              ),
            const SizedBox(height: AppSpacing.md),
            AppListCard(
              title: s.carrierBookingsTitle,
              subtitle: s.carrierHomeDescription,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go(AppRoutePath.carrierBookings),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListCard(
              title: s.vehiclesTitle,
              subtitle: s.carrierVehiclesShortcutDescription,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go(AppRoutePath.carrierVehicles()),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListCard(
              title: s.payoutAccountsTitle,
              subtitle: s.carrierPayoutHistoryTitle,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go(AppRoutePath.carrierPayoutAccounts()),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListCard(
              title: s.carrierVerificationCenterTitle,
              subtitle: s.carrierVerificationQueueHint,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go(AppRoutePath.carrierVerification),
            ),
          ],
        ),
      ),
    );
  }
}

enum _CarrierBookingsScope { active, history }

class CarrierBookingsScreen extends ConsumerStatefulWidget {
  const CarrierBookingsScreen({super.key});

  @override
  ConsumerState<CarrierBookingsScreen> createState() =>
      _CarrierBookingsScreenState();
}

class _CarrierBookingsScreenState extends ConsumerState<CarrierBookingsScreen> {
  _CarrierBookingsScope _scope = _CarrierBookingsScope.active;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bookingsAsync = ref.watch(carrierBookingsProvider);

    return AppPageScaffold(
      title: s.carrierBookingsTitle,
      child: AppAsyncStateView<List<BookingRecord>>(
        value: bookingsAsync,
        onRetry: () => ref.invalidate(carrierBookingsProvider),
        data: (bookings) {
          final filteredBookings = bookings.where((booking) {
            final isHistory =
                booking.bookingStatus == BookingStatus.completed ||
                booking.bookingStatus == BookingStatus.cancelled;
            return _scope == _CarrierBookingsScope.active ? !isHistory : isHistory;
          }).toList(growable: false);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(carrierBookingsProvider);
            },
            child: ListView(
              key: const PageStorageKey<String>('carrier-bookings-list'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SegmentedButton<_CarrierBookingsScope>(
                  segments: [
                    ButtonSegment<_CarrierBookingsScope>(
                      value: _CarrierBookingsScope.active,
                      label: Text(s.operationsActiveLabel),
                      icon: const Icon(Icons.local_shipping_outlined),
                    ),
                    ButtonSegment<_CarrierBookingsScope>(
                      value: _CarrierBookingsScope.history,
                      label: Text(s.operationsHistoryLabel),
                      icon: const Icon(Icons.history_rounded),
                    ),
                  ],
                  selected: {_scope},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _scope = selection.first;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                if (filteredBookings.isEmpty)
                  AppEmptyState(
                    title: _scope == _CarrierBookingsScope.active
                        ? s.operationsActiveLabel
                        : s.operationsHistoryLabel,
                    message: _scope == _CarrierBookingsScope.active
                        ? s.carrierActiveBookingsEmptyMessage
                        : s.carrierHistoryBookingsEmptyMessage,
                  )
                else
                  ...filteredBookings.indexed.map((entry) {
                    final index = entry.$1;
                    final booking = entry.$2;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == filteredBookings.length - 1
                            ? 0
                            : AppSpacing.sm,
                      ),
                      child: AppListCard(
                        title: booking.trackingNumber,
                        subtitle: _carrierBookingListSubtitle(s, booking),
                        leading: AppStatusChip(
                          label: _carrierBookingFocusLabel(s, booking),
                          tone: _carrierBookingFocusTone(booking),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.push(
                          AppRoutePath.sharedTrackingDetail.replaceFirst(
                            ':id',
                            booking.id,
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            ),
          );
        },
      ),
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

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myVehiclesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FilledButton.icon(
                    onPressed: () =>
                        context.push(AppRoutePath.carrierVehicleCreate()),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(s.vehicleCreateAction),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ...items.indexed.map((entry) {
                  final index = entry.$1;
                  final vehicle = entry.$2;
                  final formattedCapacity = BidiFormatters.latinIdentifier(
                    vehicle.capacityWeightKg.toStringAsFixed(0),
                  );
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == items.length - 1 ? 0 : AppSpacing.sm,
                    ),
                    child: AppListCard(
                      title: BidiFormatters.licensePlate(vehicle.plateNumber),
                      subtitle:
                          '${vehicle.vehicleType} • $formattedCapacity kg',
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
                  );
                }),
              ],
            ),
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

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(vehicleDetailProvider(widget.vehicleId!))
                ..invalidate(
                  verificationDocumentsForEntityProvider(
                    (
                      entityType: VerificationEntityType.vehicle,
                      entityId: widget.vehicleId!,
                    ),
                  ),
                );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
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
            ),
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
          mapAuthExceptionMessage(s, error),
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
    return validateRequiredField(S.of(context), value);
  }

  String? _positiveNumberValidator(String? value) {
    final s = S.of(context);
    if ((value ?? '').trim().isEmpty) {
      return s.authRequiredFieldMessage;
    }
    return validatePositiveNumberField(
      s,
      value,
      invalidMessage: s.vehiclePositiveNumberMessage,
    );
  }

  String? _optionalNumberValidator(String? value) {
    return validateOptionalPositiveNumberField(
      S.of(context),
      value,
      invalidMessage: S.of(context).vehiclePositiveNumberMessage,
    );
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
                ],
              ),
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
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(myVehiclesProvider)
            ..invalidate(
              verificationDocumentsForEntityProvider(
                (
                  entityType: VerificationEntityType.profile,
                  entityId: auth?.userId ?? '',
                ),
              ),
            );
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AppSectionHeader(
              title: s.carrierVerificationCenterTitle,
              subtitle: s.carrierVerificationCenterDescription,
              showTitle: false,
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
          (type) =>
              type.isLiveDocument &&
              (entityType == VerificationEntityType.profile
                  ? type.isProfileDocument
                  : !type.isProfileDocument),
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
  String? _,
) {
  final tone = switch (state) {
    AppVerificationState.verified => AppStatusTone.success,
    AppVerificationState.rejected => AppStatusTone.danger,
    AppVerificationState.pending => AppStatusTone.warning,
  };

  final label = verificationStatusLabel(s, state);

  return AppStatusChip(label: label, tone: tone);
}

String _carrierBookingStatusLabel(S s, BookingStatus status) {
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

String _carrierBookingSecondaryStatusLabel(S s, BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
    return s.paymentStatusReleasedToCarrierLabel;
  }
  if (booking.paymentStatus == PaymentStatus.secured &&
      booking.bookingStatus == BookingStatus.completed) {
    return s.carrierNextActionPayoutRequest;
  }
  return '${_carrierPaymentStatusLabel(s, booking.paymentStatus)} • ${BidiFormatters.latinIdentifier(booking.weightKg.toStringAsFixed(0))} kg';
}

BookingRecord? _highestPriorityCarrierBooking(List<BookingRecord> bookings) {
  if (bookings.isEmpty) {
    return null;
  }
  final ordered = [...bookings]
    ..sort((a, b) => _carrierBookingPriority(a).compareTo(_carrierBookingPriority(b)));
  return ordered.first;
}

int _carrierBookingPriority(BookingRecord booking) {
  if (booking.bookingStatus == BookingStatus.confirmed) {
    return 0;
  }
  if (booking.bookingStatus == BookingStatus.pickedUp) {
    return 1;
  }
  if (booking.bookingStatus == BookingStatus.inTransit) {
    return 2;
  }
  if (booking.bookingStatus == BookingStatus.deliveredPendingReview) {
    return 3;
  }
  if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
    return 5;
  }
  if (booking.bookingStatus == BookingStatus.completed &&
      booking.paymentStatus == PaymentStatus.secured) {
    return 4;
  }
  return 6;
}

String _carrierBookingFocusLabel(S s, BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
    return s.paymentStatusReleasedToCarrierLabel;
  }
  if (booking.bookingStatus == BookingStatus.completed &&
      booking.paymentStatus == PaymentStatus.secured) {
    return s.carrierPayoutEligibleNowLabel;
  }
  return _carrierBookingStatusLabel(s, booking.bookingStatus);
}

String _carrierBookingFocusMessage(S s, BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
    return s.carrierNextActionReleased;
  }
  if (booking.bookingStatus == BookingStatus.completed &&
      booking.paymentStatus == PaymentStatus.secured) {
    return s.carrierNextActionPayoutRequest;
  }
  return switch (booking.bookingStatus) {
    BookingStatus.confirmed => s.carrierNextActionPickup,
    BookingStatus.pickedUp => s.carrierNextActionTransit,
    BookingStatus.inTransit => s.carrierNextActionDelivery,
    BookingStatus.deliveredPendingReview => s.carrierNextActionAwaitingAdminRelease,
    _ => _carrierBookingSecondaryStatusLabel(s, booking),
  };
}

AppStatusTone _carrierBookingFocusTone(BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
    return AppStatusTone.success;
  }
  if (booking.bookingStatus == BookingStatus.completed &&
      booking.paymentStatus == PaymentStatus.secured) {
    return AppStatusTone.warning;
  }
  return switch (booking.bookingStatus) {
    BookingStatus.confirmed => AppStatusTone.warning,
    BookingStatus.pickedUp => AppStatusTone.info,
    BookingStatus.inTransit => AppStatusTone.info,
    BookingStatus.deliveredPendingReview => AppStatusTone.warning,
    BookingStatus.disputed => AppStatusTone.danger,
    BookingStatus.cancelled => AppStatusTone.neutral,
    _ => AppStatusTone.neutral,
  };
}

String _carrierBookingListSubtitle(S s, BookingRecord booking) {
  return '${_carrierBookingFocusMessage(s, booking)}\n${_carrierBookingSecondaryStatusLabel(s, booking)}';
}

class _CarrierOperationalFocusCard extends StatelessWidget {
  const _CarrierOperationalFocusCard({
    required this.title,
    required this.stateLabel,
    required this.message,
    required this.tone,
    required this.onPressed,
  });

  final String title;
  final String stateLabel;
  final String message;
  final AppStatusTone tone;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            AppStatusChip(label: stateLabel, tone: tone),
            const SizedBox(height: AppSpacing.sm),
            Text(message),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: Text(S.of(context).trackingDetailPageTitle),
            ),
          ],
        ),
      ),
    );
  }
}

String _carrierPaymentStatusLabel(S s, PaymentStatus status) {
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
