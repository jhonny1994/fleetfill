import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/errors/app_error.dart';
import 'package:fleetfill/core/errors/app_error_messages.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:fleetfill/core/theme/design_tokens.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final environment = ref.watch(appEnvironmentConfigProvider);
    final authState = ref.watch(authSessionControllerProvider);

    if (!environment.hasSupabaseConfig) {
      return Scaffold(
        body: SafeArea(
          child: AppStateMessage(
            icon: Icons.settings_rounded,
            title: s.startupConfigurationRequiredTitle,
            message: s.startupConfigurationRequiredMessage,
          ),
        ),
      );
    }

    if (authState.isLoading) {
      return Scaffold(
        body: SafeArea(
          child: AppStateMessage(
            icon: Icons.local_shipping_outlined,
            title: s.loadingTitle,
            message: s.loadingMessage,
            action: const Padding(
              padding: EdgeInsets.only(top: AppSpacing.sm),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: AppStateMessage(
          icon: Icons.local_shipping_outlined,
          title: s.splashTitle,
          message: s.splashDescription,
          action: const Padding(
            padding: EdgeInsets.only(top: AppSpacing.sm),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class MaintenanceModeScreen extends StatelessWidget {
  const MaintenanceModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.maintenanceTitle,
      child: AppStateMessage(
        icon: Icons.build_circle_outlined,
        title: s.maintenanceTitle,
        message: s.maintenanceDescription,
        action: FilledButton.icon(
          onPressed: () => context.go(AppRoutePath.splash),
          icon: const Icon(Icons.refresh_rounded),
          label: Text(s.retryLabel),
        ),
      ),
    );
  }
}

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.updateRequiredTitle,
      child: AppStateMessage(
        icon: Icons.system_update_alt_rounded,
        title: s.updateRequiredTitle,
        message: s.updateRequiredDescription,
        action: FilledButton.icon(
          onPressed: () => context.go(AppRoutePath.splash),
          icon: const Icon(Icons.refresh_rounded),
          label: Text(s.retryLabel),
        ),
      ),
    );
  }
}

class SessionExpiredScreen extends StatelessWidget {
  const SessionExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.authSessionExpiredTitle,
      child: AppStateMessage(
        icon: Icons.lock_clock_outlined,
        title: s.authSessionExpiredTitle,
        message: s.authSessionExpiredMessage,
        action: FilledButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(s.authSessionExpiredAction),
        ),
      ),
    );
  }
}

class ShipmentDetailScreen extends ConsumerWidget {
  const ShipmentDetailScreen({required this.shipmentId, super.key});

  final String shipmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedShipmentId = BidiFormatters.trackingId(shipmentId);
    final shipmentAsync = ref.watch(shipmentDetailProvider(shipmentId));
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.shipmentDetailTitle(formattedShipmentId),
      child: AppAsyncStateView<ShipmentDraftRecord?>(
        value: shipmentAsync,
        onRetry: () => ref.invalidate(shipmentDetailProvider(shipmentId)),
        data: (shipment) {
          if (shipment == null) {
            return const AppNotFoundState();
          }
          if (communesAsync.isLoading) {
            return const AppLoadingState();
          }
          if (communesAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'shipment_detail_communes_failed',
                message: mapAppErrorMessage(
                  s,
                  communesAsync.error ?? Exception('unknown'),
                ),
              ),
              onRetry: () => ref.invalidate(communesProvider),
            );
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue)
              commune.id: commune,
          };
          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedShipmentLaneLabel(context, communeMap, shipment),
                subtitle: s.shipmentDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.searchShipmentSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.shipmentCategoryLabel,
                    value: shipment.category,
                  ),
                  ProfileSummaryRow(
                    label: s.shipmentPickupStartLabel,
                    value: _sharedFormatDate(shipment.pickupWindowStart),
                  ),
                  ProfileSummaryRow(
                    label: s.shipmentPickupEndLabel,
                    value: _sharedFormatDate(shipment.pickupWindowEnd),
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(shipment.totalWeightKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: shipment.totalVolumeM3 == null
                        ? '-'
                        : BidiFormatters.latinIdentifier(
                            shipment.totalVolumeM3!.toStringAsFixed(1),
                          ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: switch (shipment.status) {
                      ShipmentStatus.booked => s.shipmentStatusBookedLabel,
                      ShipmentStatus.cancelled =>
                        s.shipmentStatusCancelledLabel,
                      ShipmentStatus.draft => s.shipmentStatusDraftLabel,
                    },
                  ),
                ],
              ),
              if (shipment.items.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  s.shipmentItemsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                ...shipment.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppListCard(
                      title: item.label,
                      subtitle:
                          '${BidiFormatters.latinIdentifier(item.quantity.toString())} • ${item.notes ?? ''}',
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedBookingId = BidiFormatters.trackingId(bookingId);
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));

    return AppPageScaffold(
      title: s.bookingDetailTitle(formattedBookingId),
      child: AppAsyncStateView<BookingRecord?>(
        value: bookingAsync,
        onRetry: () => ref.invalidate(bookingDetailProvider(bookingId)),
        data: (booking) {
          if (booking == null) {
            return const AppNotFoundState();
          }
          return ListView(
            children: [
              AppSectionHeader(
                title: s.bookingDetailTitle(formattedBookingId),
                subtitle: s.bookingDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.bookingReviewTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.bookingTrackingNumberLabel,
                    value: BidiFormatters.latinIdentifier(
                      booking.trackingNumber,
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.bookingPaymentReferenceLabel,
                    value: BidiFormatters.latinIdentifier(
                      booking.paymentReference,
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: _bookingStatusLabel(s, booking.bookingStatus),
                  ),
                  ProfileSummaryRow(
                    label: s.paymentFlowTitle,
                    value: _paymentStatusLabel(s, booking.paymentStatus),
                  ),
                  ProfileSummaryRow(
                    label: s.bookingTotalLabel,
                    value: _sharedMoney(s, booking.shipperTotalDzd),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              MoneySummaryCard(
                title: s.bookingPricingBreakdownAction,
                lines: [
                  MoneySummaryLine(
                    label: s.bookingBasePriceLabel,
                    amount: _sharedMoney(s, booking.basePriceDzd),
                  ),
                  MoneySummaryLine(
                    label: s.bookingPlatformFeeLabel,
                    amount: _sharedMoney(s, booking.platformFeeDzd),
                  ),
                  MoneySummaryLine(
                    label: s.bookingCarrierFeeLabel,
                    amount: _sharedMoney(s, booking.carrierFeeDzd),
                  ),
                  MoneySummaryLine(
                    label: s.bookingInsuranceFeeLabel,
                    amount: _sharedMoney(s, booking.insuranceFeeDzd),
                  ),
                  MoneySummaryLine(
                    label: s.bookingTaxFeeLabel,
                    amount: _sharedMoney(s, booking.taxFeeDzd),
                  ),
                  MoneySummaryLine(
                    label: s.bookingTotalLabel,
                    amount: _sharedMoney(s, booking.shipperTotalDzd),
                    emphasis: true,
                  ),
                ],
              ),
              if (booking.paymentStatus == PaymentStatus.unpaid) ...[
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () => context.push(
                    AppRoutePath.shipperPaymentFlow,
                    extra: booking.id,
                  ),
                  child: Text(s.paymentFlowTitle),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class BookingTrackingScreen extends ConsumerWidget {
  const BookingTrackingScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedBookingId = BidiFormatters.trackingId(bookingId);
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));
    final eventsAsync = ref.watch(trackingEventsProvider(bookingId));
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    return AppPageScaffold(
      title: s.trackingDetailTitle(formattedBookingId),
      child: AppAsyncStateView<BookingRecord?>(
        value: bookingAsync,
        onRetry: () => ref.invalidate(bookingDetailProvider(bookingId)),
        data: (booking) {
          if (booking == null) {
            return const AppNotFoundState();
          }
          final canCarrierAdvance =
              auth?.role == AppUserRole.carrier &&
              auth?.userId == booking.carrierId;
          final canShipperConfirm =
              auth?.role == AppUserRole.shipper &&
              auth?.userId == booking.shipperId;

          return ListView(
            key: const PageStorageKey<String>('booking-tracking-screen'),
            children: [
              AppSectionHeader(
                title: s.trackingDetailTitle(formattedBookingId),
                subtitle: s.trackingDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.bookingReviewTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.bookingTrackingNumberLabel,
                    value: BidiFormatters.latinIdentifier(
                      booking.trackingNumber,
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: _bookingStatusLabel(s, booking.bookingStatus),
                  ),
                  ProfileSummaryRow(
                    label: s.paymentFlowTitle,
                    value: _paymentStatusLabel(s, booking.paymentStatus),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (canCarrierAdvance &&
                  booking.bookingStatus == BookingStatus.confirmed) ...[
                OutlinedButton(
                  onPressed: () => unawaited(
                    _recordMilestone(context, ref, booking, 'picked_up'),
                  ),
                  child: Text(s.bookingStatusPickedUpLabel),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (canCarrierAdvance &&
                  booking.bookingStatus == BookingStatus.pickedUp) ...[
                OutlinedButton(
                  onPressed: () => unawaited(
                    _recordMilestone(context, ref, booking, 'in_transit'),
                  ),
                  child: Text(s.bookingStatusInTransitLabel),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (canCarrierAdvance &&
                  booking.bookingStatus == BookingStatus.inTransit) ...[
                OutlinedButton(
                  onPressed: () => unawaited(
                    _recordMilestone(
                      context,
                      ref,
                      booking,
                      'delivered_pending_review',
                    ),
                  ),
                  child: Text(s.bookingStatusDeliveredPendingReviewLabel),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (canShipperConfirm &&
                  booking.bookingStatus ==
                      BookingStatus.deliveredPendingReview) ...[
                FilledButton(
                  onPressed: () =>
                      unawaited(_confirmDelivery(context, ref, booking)),
                  child: Text(s.deliveryConfirmAction),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (canShipperConfirm &&
                  booking.bookingStatus ==
                      BookingStatus.deliveredPendingReview) ...[
                OutlinedButton(
                  onPressed: () =>
                      unawaited(_openDispute(context, ref, booking)),
                  child: Text(s.bookingStatusDisputedLabel),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (canShipperConfirm &&
                  booking.bookingStatus == BookingStatus.completed) ...[
                OutlinedButton(
                  onPressed: () =>
                      unawaited(_openReview(context, ref, booking)),
                  child: Text(s.ratingSubmitAction),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              Text(
                s.trackingTimelineTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              eventsAsync.when(
                data: (events) => events.isEmpty
                    ? AppEmptyState(
                        title: s.trackingTimelineTitle,
                        message: s.trackingTimelineEmptyMessage,
                      )
                    : Column(
                        children: events
                            .map(
                              (event) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: AppListCard(
                                  title: _trackingEventLabel(
                                    s,
                                    event.eventType,
                                  ),
                                  subtitle:
                                      event.note == null || event.note!.isEmpty
                                      ? _sharedFormatDate(event.recordedAt)
                                      : '${_sharedFormatDate(event.recordedAt)} • ${event.note}',
                                ),
                              ),
                            )
                            .toList(growable: false),
                      ),
                loading: () => const AppLoadingState(),
                error: (error, stackTrace) => AppErrorState(
                  error: AppError(
                    code: 'tracking_events_failed',
                    message: mapAppErrorMessage(s, error),
                  ),
                  onRetry: () =>
                      ref.invalidate(trackingEventsProvider(bookingId)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _recordMilestone(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
    String milestone,
  ) async {
    final s = S.of(context);
    final noteController = TextEditingController();
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _trackingEventLabel(s, milestone),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: noteController,
              label: s.adminVerificationRejectReasonHint,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(s.confirmLabel),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) {
      noteController.dispose();
      return;
    }

    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .carrierRecordMilestone(
            bookingId: booking.id,
            milestone: milestone,
            note: noteController.text,
          );
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.carrierMilestoneUpdatedMessage);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      noteController.dispose();
    }
  }

  Future<void> _confirmDelivery(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
  ) async {
    final s = S.of(context);
    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .shipperConfirmDelivery(
            bookingId: booking.id,
            shipmentId: booking.shipmentId,
          );
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.deliveryConfirmedMessage);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }

  Future<void> _openDispute(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
  ) async {
    final s = S.of(context);
    final reasonController = TextEditingController();
    final descriptionController = TextEditingController();
    final selectedFiles = <PlatformFile>[];
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.bookingStatusDisputedLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: reasonController,
                label: s.paymentProofRejectionReasonLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: descriptionController,
                label: s.shipmentDescriptionLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    withData: kIsWeb,
                    type: FileType.custom,
                    allowedExtensions: const ['jpg', 'jpeg', 'png', 'pdf'],
                  );
                  if (result == null) {
                    return;
                  }
                  setModalState(() {
                    selectedFiles
                      ..clear()
                      ..addAll(result.files);
                  });
                },
                icon: const Icon(Icons.attach_file_rounded),
                label: Text(s.disputeEvidenceAddAction),
              ),
              if (selectedFiles.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(s.disputeEvidenceSelectedCount(selectedFiles.length)),
                const SizedBox(height: AppSpacing.xs),
                ...selectedFiles.map(
                  (file) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(file.name),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(s.confirmLabel),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true) {
      reasonController.dispose();
      descriptionController.dispose();
      return;
    }
    try {
      final dispute = await ref
          .read(disputeRepositoryProvider)
          .createDispute(
            bookingId: booking.id,
            reason: reasonController.text,
            description: descriptionController.text,
          );

      for (final file in selectedFiles) {
        await ref
            .read(disputeRepositoryProvider)
            .uploadDisputeEvidence(
              disputeId: dispute.id,
              draft: _verificationUploadDraftFromFile(file),
              note: descriptionController.text,
            );
      }

      ref
        ..invalidate(bookingDetailProvider(booking.id))
        ..invalidate(trackingEventsProvider(booking.id))
        ..invalidate(openDisputesProvider);
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.bookingStatusDisputedLabel);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      reasonController.dispose();
      descriptionController.dispose();
    }
  }

  Future<void> _openReview(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
  ) async {
    final s = S.of(context);
    var score = 5;
    final commentController = TextEditingController();
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.ratingSubmitAction,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<int>(
                initialValue: score,
                items: List.generate(5, (index) => index + 1)
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text('$value/5'),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) setModalState(() => score = value);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: commentController,
                label: s.ratingCommentLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(s.confirmLabel),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true) {
      commentController.dispose();
      return;
    }
    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .submitCarrierReview(
            bookingId: booking.id,
            score: score,
            comment: commentController.text,
          );
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.ratingSubmittedMessage);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      commentController.dispose();
    }
  }
}

class CarrierPublicProfileScreen extends ConsumerWidget {
  const CarrierPublicProfileScreen({required this.carrierId, super.key});

  final String carrierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedCarrierId = BidiFormatters.latinIdentifier(carrierId);
    final profile = ref.watch(publicCarrierProfileProvider(carrierId));

    return AppPageScaffold(
      title: s.carrierPublicProfileTitle(formattedCarrierId),
      child: profile.when(
        loading: () => const AppLoadingState(),
        error: (error, stackTrace) {
          final normalizedError = error.toString().toLowerCase();
          if (normalizedError.contains('not found') ||
              normalizedError.contains('carrier_profile_not_found')) {
            return const AppNotFoundState();
          }

          return AppErrorState(
            error: AppError(
              code: 'carrier_public_profile_failed',
              message: s.routeErrorMessage,
              technicalDetails: stackTrace.toString(),
            ),
          );
        },
        data: (carrier) {
          final formattedRating = carrier.ratingAverage == null
              ? '-'
              : BidiFormatters.latinIdentifier(
                  carrier.ratingAverage!.toStringAsFixed(1),
                );
          final formattedReviewCount = BidiFormatters.latinIdentifier(
            carrier.ratingCount.toString(),
          );

          return ListView(
            children: [
              AppSectionHeader(
                title: carrier.displayName,
                subtitle: s.carrierPublicProfileDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.carrierPublicProfileSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.carrierPublicProfileRatingLabel,
                    value: formattedRating,
                  ),
                  ProfileSummaryRow(
                    label: s.carrierPublicProfileReviewCountLabel,
                    value: formattedReviewCount,
                  ),
                  ProfileSummaryRow(
                    label: s.carrierProfileVerificationLabel,
                    value: verificationStatusLabel(
                      s,
                      carrier.verificationStatus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                s.carrierPublicProfileCommentsTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              if (carrier.comments.isEmpty)
                AppEmptyState(
                  title: s.carrierPublicProfileCommentsTitle,
                  message: s.carrierPublicProfileNoCommentsMessage,
                )
              else
                ...carrier.comments.map(
                  (comment) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppListCard(
                      title: BidiFormatters.latinIdentifier(
                        '${comment.score}/5',
                      ),
                      subtitle: comment.comment,
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

class RouteDetailScreen extends ConsumerWidget {
  const RouteDetailScreen({required this.routeId, super.key});

  final String routeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedRouteId = BidiFormatters.latinIdentifier(routeId);
    final routeAsync = ref.watch(carrierRouteDetailProvider(routeId));
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.routeDetailTitle(formattedRouteId),
      child: AppAsyncStateView<CarrierRoute?>(
        value: routeAsync,
        onRetry: () => ref.invalidate(carrierRouteDetailProvider(routeId)),
        data: (route) {
          if (route == null) {
            return const AppNotFoundState();
          }
          if (communesAsync.isLoading) {
            return const AppLoadingState();
          }
          if (communesAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'route_detail_communes_failed',
                message: mapAppErrorMessage(
                  s,
                  communesAsync.error ?? Exception('unknown'),
                ),
              ),
              onRetry: () => ref.invalidate(communesProvider),
            );
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue)
              commune.id: commune,
          };

          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedLaneLabel(
                  context,
                  communeMap,
                  route.originCommuneId,
                  route.destinationCommuneId,
                ),
                subtitle: s.routeDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.myRoutesSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.routeDepartureTimeLabel,
                    value: _sharedFormatSqlTime(
                      context,
                      route.defaultDepartureTime,
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeRecurringDaysLabel,
                    value: _sharedFormatWeekdays(
                      context,
                      route.recurringDaysOfWeek,
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeEffectiveFromLabel,
                    value: _sharedFormatDate(route.effectiveFrom),
                  ),
                  ProfileSummaryRow(
                    label: s.routePricePerKgLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(route.pricePerKgDzd.toStringAsFixed(0))} ${s.pricePerKgUnitLabel}',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(route.totalCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: route.totalCapacityVolumeM3 == null
                        ? '-'
                        : BidiFormatters.latinIdentifier(
                            route.totalCapacityVolumeM3!.toStringAsFixed(1),
                          ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: route.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class OneOffTripDetailScreen extends ConsumerWidget {
  const OneOffTripDetailScreen({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedTripId = BidiFormatters.latinIdentifier(tripId);
    final tripAsync = ref.watch(oneOffTripDetailProvider(tripId));
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.oneOffTripDetailTitle(formattedTripId),
      child: AppAsyncStateView<CarrierOneOffTrip?>(
        value: tripAsync,
        onRetry: () => ref.invalidate(oneOffTripDetailProvider(tripId)),
        data: (trip) {
          if (trip == null) {
            return const AppNotFoundState();
          }
          if (communesAsync.isLoading) {
            return const AppLoadingState();
          }
          if (communesAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'oneoff_trip_detail_communes_failed',
                message: mapAppErrorMessage(
                  s,
                  communesAsync.error ?? Exception('unknown'),
                ),
              ),
              onRetry: () => ref.invalidate(communesProvider),
            );
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue)
              commune.id: commune,
          };

          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedLaneLabel(
                  context,
                  communeMap,
                  trip.originCommuneId,
                  trip.destinationCommuneId,
                ),
                subtitle: s.oneOffTripDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.myRoutesSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.oneOffTripDepartureLabel,
                    value:
                        '${_sharedFormatDate(trip.departureAt)} • ${TimeOfDay.fromDateTime(trip.departureAt).format(context)}',
                  ),
                  ProfileSummaryRow(
                    label: s.routePricePerKgLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(trip.pricePerKgDzd.toStringAsFixed(0))} ${s.pricePerKgUnitLabel}',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(trip.totalCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: trip.totalCapacityVolumeM3 == null
                        ? '-'
                        : BidiFormatters.latinIdentifier(
                            trip.totalCapacityVolumeM3!.toStringAsFixed(1),
                          ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: trip.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProofViewerScreen extends ConsumerWidget {
  const ProofViewerScreen({required this.proofId, super.key});

  final String proofId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedProofId = BidiFormatters.latinIdentifier(proofId);
    final proofAsync = ref.watch(paymentProofDetailProvider(proofId));

    return AppPageScaffold(
      title: s.proofViewerTitle(formattedProofId),
      child: AppAsyncStateView<PaymentProofRecord?>(
        value: proofAsync,
        onRetry: () => ref.invalidate(paymentProofDetailProvider(proofId)),
        data: (proof) {
          if (proof == null) {
            return const AppNotFoundState();
          }
          return FutureBuilder<String>(
            future: ref
                .read(paymentProofRepositoryProvider)
                .createSignedPaymentProofUrl(proof),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return AppErrorState(
                  error: AppError(
                    code: 'payment_proof_signed_url_failed',
                    message: mapAppErrorMessage(
                      s,
                      snapshot.error ?? Exception('unknown'),
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () =>
                      ref.invalidate(paymentProofDetailProvider(proofId)),
                );
              }
              return _SignedFileViewer(
                title: s.proofViewerTitle(formattedProofId),
                message: s.proofViewerDescription,
                signedUrl: snapshot.data!,
                storagePath: proof.storagePath,
              );
            },
          );
        },
      ),
    );
  }
}

VerificationUploadDraft _verificationUploadDraftFromFile(PlatformFile file) {
  final extension = (file.extension ?? '').toLowerCase();
  final contentType = switch (extension) {
    'jpg' || 'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    _ => 'application/pdf',
  };
  return VerificationUploadDraft(
    path: file.path ?? file.name,
    filename: file.name,
    extension: extension,
    contentType: contentType,
    byteSize: file.size,
    bytes: file.bytes,
  );
}

class DisputeEvidenceViewerScreen extends ConsumerWidget {
  const DisputeEvidenceViewerScreen({required this.evidenceId, super.key});

  final String evidenceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedEvidenceId = BidiFormatters.latinIdentifier(evidenceId);
    final evidenceAsync = ref.watch(disputeEvidenceDetailProvider(evidenceId));

    return AppPageScaffold(
      title: s.documentViewerTitle(formattedEvidenceId),
      child: AppAsyncStateView<DisputeEvidenceRecord?>(
        value: evidenceAsync,
        onRetry: () =>
            ref.invalidate(disputeEvidenceDetailProvider(evidenceId)),
        data: (evidence) {
          if (evidence == null) {
            return const AppNotFoundState();
          }

          return FutureBuilder<String>(
            future: ref
                .read(disputeRepositoryProvider)
                .createSignedDisputeEvidenceUrl(evidence),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return AppErrorState(
                  error: AppError(
                    code: 'dispute_evidence_signed_url_failed',
                    message: mapAppErrorMessage(
                      s,
                      snapshot.error ??
                          Exception('document_signed_url_unavailable'),
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () => ref.invalidate(
                    disputeEvidenceDetailProvider(evidenceId),
                  ),
                );
              }

              return _SignedFileViewer(
                title: s.documentViewerTitle(formattedEvidenceId),
                message: evidence.note?.trim().isNotEmpty == true
                    ? evidence.note!
                    : s.documentViewerDescription,
                signedUrl: snapshot.data!,
                storagePath: evidence.storagePath,
                contentType: evidence.contentType,
              );
            },
          );
        },
      ),
    );
  }
}

class DocumentViewerScreen extends ConsumerWidget {
  const DocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedDocumentId = BidiFormatters.latinIdentifier(documentId);
    final documentAsync = ref.watch(
      verificationDocumentDetailProvider(documentId),
    );

    return AppPageScaffold(
      title: s.documentViewerTitle(formattedDocumentId),
      child: AppAsyncStateView<VerificationDocumentRecord?>(
        value: documentAsync,
        onRetry: () =>
            ref.invalidate(verificationDocumentDetailProvider(documentId)),
        data: (document) {
          if (document == null) {
            return const AppNotFoundState();
          }

          return FutureBuilder<String>(
            future: ref
                .read(vehicleRepositoryProvider)
                .createSignedDocumentUrl(document),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState();
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return AppErrorState(
                  error: AppError(
                    code: 'document_signed_url_failed',
                    message: mapAuthErrorMessage(
                      s,
                      snapshot.error?.toString() ??
                          'document_signed_url_unavailable',
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () => ref.invalidate(
                    verificationDocumentDetailProvider(documentId),
                  ),
                );
              }

              return _SignedFileViewer(
                title: s.documentViewerTitle(formattedDocumentId),
                message: s.documentViewerDescription,
                signedUrl: snapshot.data!,
                storagePath: document.storagePath,
                contentType: document.contentType,
              );
            },
          );
        },
      ),
    );
  }
}

class GeneratedDocumentViewerScreen extends ConsumerWidget {
  const GeneratedDocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedDocumentId = BidiFormatters.latinIdentifier(documentId);
    final documentAsync = ref.watch(
      generatedDocumentDetailProvider(documentId),
    );

    return AppPageScaffold(
      title: s.generatedDocumentViewerTitle(formattedDocumentId),
      child: AppAsyncStateView<GeneratedDocumentRecord?>(
        value: documentAsync,
        onRetry: () =>
            ref.invalidate(generatedDocumentDetailProvider(documentId)),
        data: (document) {
          if (document == null) {
            return const AppNotFoundState();
          }

          if (document.isPending) {
            return AppStateMessage(
              icon: Icons.hourglass_top_rounded,
              title: s.generatedDocumentViewerTitle(formattedDocumentId),
              message: s.generatedDocumentPendingMessage,
            );
          }

          if (document.isFailed) {
            final trimmedFailureReason = document.failureReason?.trim();
            return AppStateMessage(
              icon: Icons.error_outline_rounded,
              title: s.generatedDocumentViewerTitle(formattedDocumentId),
              message:
                  trimmedFailureReason != null &&
                      trimmedFailureReason.isNotEmpty
                  ? '${s.generatedDocumentFailedMessage}\n\n${s.generatedDocumentFailureReasonLabel}: $trimmedFailureReason'
                  : s.generatedDocumentFailedMessage,
            );
          }

          return FutureBuilder<String>(
            future: ref
                .read(paymentProofRepositoryProvider)
                .createSignedGeneratedDocumentUrl(document),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState();
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return AppErrorState(
                  error: AppError(
                    code: 'generated_document_signed_url_failed',
                    message: mapAppErrorMessage(
                      s,
                      snapshot.error ??
                          Exception('document_signed_url_unavailable'),
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () => ref.invalidate(
                    generatedDocumentDetailProvider(documentId),
                  ),
                );
              }

              final signedUrl = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Wrap(
                        runSpacing: AppSpacing.sm,
                        spacing: AppSpacing.sm,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SizedBox(
                            width: 280,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _generatedDocumentTypeLabel(
                                    s,
                                    document.documentType,
                                  ),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                if (document.availableAt != null)
                                  Text(
                                    '${s.generatedDocumentAvailableAtLabel}: ${_sharedFormatDate(document.availableAt!)}',
                                  ),
                              ],
                            ),
                          ),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              FilledButton.icon(
                                onPressed: () =>
                                    unawaited(_openExternal(signedUrl)),
                                icon: const Icon(Icons.download_rounded),
                                label: Text(s.generatedDocumentDownloadAction),
                              ),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    unawaited(_openExternal(signedUrl)),
                                icon: const Icon(Icons.open_in_new_rounded),
                                label: Text(
                                  s.generatedDocumentOpenInBrowserAction,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: SfPdfViewer.network(signedUrl),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

String _sharedLaneLabel(
  BuildContext context,
  Map<int, AlgeriaCommune> communeMap,
  int originId,
  int destinationId,
) {
  final locale = Localizations.localeOf(context);
  final origin =
      communeMap[originId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(originId.toString());
  final destination =
      communeMap[destinationId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(destinationId.toString());
  return '$origin -> $destination';
}

Future<void> _openExternal(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class _SignedFileViewer extends StatelessWidget {
  const _SignedFileViewer({
    required this.title,
    required this.message,
    required this.signedUrl,
    required this.storagePath,
    this.contentType,
  });

  final String title;
  final String message;
  final String signedUrl;
  final String storagePath;
  final String? contentType;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: AppSpacing.sm,
              spacing: AppSpacing.sm,
              children: [
                SizedBox(
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(message),
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => unawaited(_openExternal(signedUrl)),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(s.documentViewerOpenAction),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: _SignedFilePreview(
            signedUrl: signedUrl,
            storagePath: storagePath,
            contentType: contentType,
          ),
        ),
      ],
    );
  }
}

class _SignedFilePreview extends StatelessWidget {
  const _SignedFilePreview({
    required this.signedUrl,
    required this.storagePath,
    this.contentType,
  });

  final String signedUrl;
  final String storagePath;
  final String? contentType;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (_looksLikePdf(contentType, storagePath, signedUrl)) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: SfPdfViewer.network(signedUrl),
      );
    }

    if (_looksLikeImage(contentType, storagePath, signedUrl)) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            alignment: Alignment.center,
            child: Image.network(
              signedUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }

                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => _PreviewFallback(
                message: s.documentPreviewUnavailableMessage,
              ),
            ),
          ),
        ),
      );
    }

    return _PreviewFallback(message: s.documentPreviewUnavailableMessage);
  }
}

class _PreviewFallback extends StatelessWidget {
  const _PreviewFallback({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.description_outlined, size: 40),
              const SizedBox(height: AppSpacing.md),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

bool _looksLikePdf(String? contentType, String storagePath, String signedUrl) {
  final normalizedType = (contentType ?? '').toLowerCase();
  if (normalizedType.contains('pdf')) {
    return true;
  }

  return _pathLooksLike(storagePath, signedUrl, const ['.pdf']);
}

bool _looksLikeImage(
  String? contentType,
  String storagePath,
  String signedUrl,
) {
  final normalizedType = (contentType ?? '').toLowerCase();
  if (normalizedType.startsWith('image/')) {
    return true;
  }

  return _pathLooksLike(
    storagePath,
    signedUrl,
    const ['.jpg', '.jpeg', '.png', '.webp', '.gif'],
  );
}

bool _pathLooksLike(
  String storagePath,
  String signedUrl,
  List<String> suffixes,
) {
  final normalizedStoragePath = storagePath.toLowerCase();
  final normalizedSignedUrl =
      Uri.tryParse(signedUrl)?.path.toLowerCase() ?? signedUrl.toLowerCase();

  return suffixes.any(
    (suffix) =>
        normalizedStoragePath.endsWith(suffix) ||
        normalizedSignedUrl.endsWith(suffix),
  );
}

String _sharedShipmentLaneLabel(
  BuildContext context,
  Map<int, AlgeriaCommune> communeMap,
  ShipmentDraftRecord shipment,
) {
  return _sharedLaneLabel(
    context,
    communeMap,
    shipment.originCommuneId,
    shipment.destinationCommuneId,
  );
}

String _sharedFormatDate(DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

String _sharedFormatSqlTime(BuildContext context, String value) {
  final parts = value.split(':');
  final time = TimeOfDay(
    hour: int.tryParse(parts.isEmpty ? '' : parts[0]) ?? 0,
    minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
  );
  return time.format(context);
}

String _sharedFormatWeekdays(BuildContext context, List<int> weekdays) {
  final labels = MaterialLocalizations.of(context).narrowWeekdays;
  return weekdays.map((day) => labels[day]).join(', ');
}

String _sharedMoney(S s, double amount) {
  return '${BidiFormatters.latinIdentifier(amount.toStringAsFixed(0))} ${s.priceCurrencyLabel}';
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

String _generatedDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'booking_invoice' => s.generatedDocumentTypeBookingInvoice,
    'payment_receipt' => s.generatedDocumentTypePaymentReceipt,
    'payout_receipt' => s.generatedDocumentTypePayoutReceipt,
    _ => s.generatedDocumentsTitle,
  };
}

String _trackingEventLabel(S s, String eventType) {
  return switch (eventType) {
    'payment_under_review' => s.trackingEventPaymentUnderReviewLabel,
    'confirmed' => s.trackingEventConfirmedLabel,
    'picked_up' => s.trackingEventPickedUpLabel,
    'in_transit' => s.trackingEventInTransitLabel,
    'delivered_pending_review' => s.trackingEventDeliveredPendingReviewLabel,
    'completed' => s.trackingEventCompletedLabel,
    'cancelled' => s.trackingEventCancelledLabel,
    'disputed' => s.trackingEventDisputedLabel,
    _ => eventType,
  };
}
