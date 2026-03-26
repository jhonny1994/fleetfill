import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/errors/app_error.dart';
import 'package:fleetfill/core/errors/app_error_messages.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/routing/app_route_guards.dart';
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

class AuthenticatedEntryScreen extends ConsumerStatefulWidget {
  const AuthenticatedEntryScreen({super.key});

  @override
  ConsumerState<AuthenticatedEntryScreen> createState() =>
      _AuthenticatedEntryScreenState();
}

class _AuthenticatedEntryScreenState
    extends ConsumerState<AuthenticatedEntryScreen> {
  bool _scheduled = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    if (!_scheduled && auth != null && auth.isAuthenticated) {
      _scheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        context.go(AppRouteGuards.homeLocation(auth));
      });
    }

    return const SplashScreen();
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
    final shipmentAsync = ref.watch(shipmentDetailProvider(shipmentId));
    final communesAsync = ref.watch(communesProvider);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final shipperBookingsAsync = ref.watch(myShipperBookingsProvider);

    return AppPageScaffold(
      title: s.shipmentDetailPageTitle,
      child: AppAsyncStateView<ShipmentDraftRecord?>(
        value: shipmentAsync,
        onRetry: () => ref.invalidate(shipmentDetailProvider(shipmentId)),
        data: (shipment) {
          if (shipment == null) {
            return const AppNotFoundState();
          }
          final originCommuneAsync = ref.watch(
            communeByIdProvider(shipment.originCommuneId),
          );
          final destinationCommuneAsync = ref.watch(
            communeByIdProvider(shipment.destinationCommuneId),
          );
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
          final originCommune =
              communeMap[shipment.originCommuneId] ??
              originCommuneAsync.asData?.value;
          final destinationCommune =
              communeMap[shipment.destinationCommuneId] ??
              destinationCommuneAsync.asData?.value;
          final relatedBookings =
              shipperBookingsAsync.asData?.value
                  .where((booking) => booking.shipmentId == shipment.id)
                  .toList(growable: false) ??
              const <BookingRecord>[];
          final relatedBooking = relatedBookings.isEmpty
              ? null
              : relatedBookings.first;
          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedShipmentLaneTitle(
                  context,
                  originCommune: originCommune,
                  destinationCommune: destinationCommune,
                ),
                subtitle: s.shipmentDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.searchShipmentSummaryTitle,
                rows: [
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
                  if ((shipment.details ?? '').trim().isNotEmpty)
                    ProfileSummaryRow(
                      label: s.shipmentDescriptionLabel,
                      value: shipment.details!,
                    ),
                ],
              ),
              if (auth?.role == AppUserRole.shipper &&
                  auth?.userId == shipment.shipperId &&
                  relatedBooking != null &&
                  _canOpenShipperBookingWorkspace(relatedBooking)) ...[
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => context.push(
                            AppRoutePath.shipperPaymentFlow,
                            extra: relatedBooking.id,
                          ),
                          child: Text(
                            _shipperPaymentActionLabel(s, relatedBooking),
                          ),
                        ),
                      ),
                    if (_canShipperCancelPendingBooking(relatedBooking)) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => unawaited(
                            _cancelPendingBookingFromShipmentDetail(
                              context,
                              ref,
                              relatedBooking,
                            ),
                          ),
                          child: Text(s.cancelLabel),
                        ),
                      ),
                    ],
                  ],
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
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    if (auth?.role == AppUserRole.shipper) {
      return PaymentFlowScreen(bookingId: bookingId);
    }
    return BookingTrackingScreen(bookingId: bookingId);
  }
}

class BookingTrackingScreen extends ConsumerWidget {
  const BookingTrackingScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));
    final eventsAsync = ref.watch(trackingEventsProvider(bookingId));
    final documentsAsync = ref.watch(generatedDocumentsForBookingProvider(bookingId));
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final payoutContextAsync =
        auth?.role == AppUserRole.carrier
            ? ref.watch(bookingPayoutRequestContextProvider(bookingId))
            : null;
    final bookingPayoutsAsync =
        auth?.role == AppUserRole.carrier
            ? ref.watch(payoutsForBookingProvider(bookingId))
            : null;

    return AppPageScaffold(
      title: s.trackingDetailPageTitle,
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
          final canOpenShipperWorkspace =
              auth?.role == AppUserRole.shipper &&
              auth?.userId == booking.shipperId &&
              _canOpenShipperBookingWorkspace(booking);
          final payoutContext = payoutContextAsync?.asData?.value;

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(bookingDetailProvider(bookingId))
                ..invalidate(trackingEventsProvider(bookingId))
                ..invalidate(generatedDocumentsForBookingProvider(bookingId));
              if (auth?.role == AppUserRole.carrier) {
                ref
                  ..invalidate(bookingPayoutRequestContextProvider(bookingId))
                  ..invalidate(payoutsForBookingProvider(bookingId));
              }
            },
            child: ListView(
              key: const PageStorageKey<String>('booking-tracking-screen'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: s.trackingDetailTitle(
                    BidiFormatters.trackingId(bookingId),
                  ),
                  subtitle: s.trackingDetailDescription,
                  showTitle: false,
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
                    ProfileSummaryRow(
                      label: s.bookingCarrierPayoutLabel,
                      value: _sharedMoney(s, booking.carrierPayoutDzd),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _LifecycleStatusBanner(
                  title: s.bookingNextActionTitle,
                  message: _bookingNextActionMessage(
                    s,
                    booking,
                    auth,
                    payoutContext,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (canOpenShipperWorkspace) ...[
                  FilledButton.icon(
                    onPressed: () => context.push(
                      AppRoutePath.shipperPaymentFlow,
                      extra: booking.id,
                    ),
                    icon: const Icon(Icons.payments_outlined),
                    label: Text(_shipperPaymentActionLabel(s, booking)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
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
                if (canCarrierAdvance) ...[
                  _CarrierPayoutSection(
                    booking: booking,
                    payoutContextAsync: payoutContextAsync!,
                    bookingPayoutsAsync: bookingPayoutsAsync!,
                    onRequestPayout: () =>
                        _requestPayout(context, ref, booking),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.push(AppRoutePath.sharedSupport),
                        icon: const Icon(Icons.support_agent_rounded),
                        label: Text(s.supportTitle),
                      ),
                    ),
                    if (canShipperConfirm &&
                        booking.bookingStatus ==
                            BookingStatus.deliveredPendingReview) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              unawaited(_openDispute(context, ref, booking)),
                          icon: const Icon(Icons.report_gmailerrorred_rounded),
                          label: Text(s.bookingStatusDisputedLabel),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  s.generatedDocumentsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                documentsAsync.when(
                  data: (documents) => documents.isEmpty
                      ? AppStateMessage(
                          icon: Icons.description_outlined,
                          title: s.generatedDocumentsTitle,
                          message: s.generatedDocumentsEmptyMessage,
                        )
                      : Column(
                          children: documents
                              .map(
                                (document) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.sm,
                                  ),
                                  child: AppListCard(
                                    title: _generatedDocumentTypeLabel(
                                      s,
                                      document.documentType,
                                    ),
                                    subtitle: _generatedDocumentSubtitle(
                                      context,
                                      s,
                                      document,
                                    ),
                                    leading: AppStatusChip(
                                      label: _generatedDocumentStatusLabel(
                                        s,
                                        document,
                                      ),
                                      tone: _generatedDocumentStatusTone(
                                        document,
                                      ),
                                    ),
                                    trailing: document.isReady
                                        ? const Icon(Icons.chevron_right_rounded)
                                        : null,
                                    onTap: document.isReady
                                        ? () => context.push(
                                            AppRoutePath
                                                .sharedGeneratedDocumentViewer
                                                .replaceFirst(
                                                  ':id',
                                                  document.id,
                                                ),
                                          )
                                        : null,
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        ),
                  loading: () => const AppLoadingState(),
                  error: (error, stackTrace) => AppErrorState(
                    error: AppError(
                      code: 'booking_documents_failed',
                      message: mapAppErrorMessage(s, error),
                    ),
                    onRetry: () => ref.invalidate(
                      generatedDocumentsForBookingProvider(bookingId),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
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
                      : _BookingLifecycleTimeline(events: events, s: s),
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
            ),
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
              label: s.carrierMilestoneNoteLabel,
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

  Future<void> _requestPayout(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
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
              s.carrierPayoutRequestAction,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: noteController,
              label: s.carrierPayoutRequestNoteLabel,
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
          .carrierRequestPayout(
            bookingId: booking.id,
            shipmentId: booking.shipmentId,
            note: noteController.text,
          );
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.carrierPayoutRequestSuccessMessage);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      noteController.dispose();
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
                label: s.disputeReasonLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: descriptionController,
                label: s.disputeDescriptionLabel,
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

Future<void> _cancelPendingBookingFromShipmentDetail(
  BuildContext context,
  WidgetRef ref,
  BookingRecord booking,
) async {
  final confirmed = await _confirmBookingCancel(context);
  if (confirmed != true || !context.mounted) {
    return;
  }

  final s = S.of(context);
  try {
    await ref
        .read(bookingWorkflowControllerProvider)
        .shipperCancelPendingBooking(
          bookingId: booking.id,
          shipmentId: booking.shipmentId,
        );
    ref
      ..invalidate(myShipperBookingsProvider)
      ..invalidate(myShipperShipmentsProvider)
      ..invalidate(bookingDetailProvider(booking.id))
      ..invalidate(shipmentDetailProvider(booking.shipmentId));
    if (!context.mounted) return;
    AppFeedback.showSnackBar(context, s.bookingStatusCancelledLabel);
    context.go(AppRoutePath.shipperSearch);
  } on PostgrestException catch (error) {
    if (context.mounted) {
      AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    }
  }
}

Future<bool?> _confirmBookingCancel(BuildContext context) {
  final s = S.of(context);
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(s.bookingStatusCancelledLabel),
      content: Text(s.paymentFlowDescription),
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
  );
}

class CarrierPublicProfileScreen extends ConsumerWidget {
  const CarrierPublicProfileScreen({required this.carrierId, super.key});

  final String carrierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final profile = ref.watch(publicCarrierProfileProvider(carrierId));

    return AppPageScaffold(
      title: s.carrierPublicProfilePageTitle,
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
    final routeAsync = ref.watch(carrierRouteDetailProvider(routeId));
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.routeDetailPageTitle,
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

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(carrierRouteDetailProvider(routeId))
                ..invalidate(communesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
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
            ),
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
    final tripAsync = ref.watch(oneOffTripDetailProvider(tripId));
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.oneOffTripDetailPageTitle,
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

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(oneOffTripDetailProvider(tripId))
                ..invalidate(communesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
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
            ),
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
    final proofAsync = ref.watch(paymentProofDetailProvider(proofId));

    return AppPageScaffold(
      title: s.proofViewerPageTitle,
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
                title: s.proofViewerPageTitle,
                message: s.proofViewerDescription,
                signedUrl: snapshot.data!,
                storagePath: proof.storagePath,
                contentType: proof.contentType,
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
    final evidenceAsync = ref.watch(disputeEvidenceDetailProvider(evidenceId));

    return AppPageScaffold(
      title: s.documentViewerPageTitle,
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
                title: s.documentViewerPageTitle,
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
    final documentAsync = ref.watch(
      verificationDocumentDetailProvider(documentId),
    );

    return AppPageScaffold(
      title: s.verificationDocumentViewerTitle,
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
                    message: mapAppErrorMessage(
                      s,
                      snapshot.error ??
                          Exception('document_signed_url_unavailable'),
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () => ref.invalidate(
                    verificationDocumentDetailProvider(documentId),
                  ),
                );
              }

              return _SignedFileViewer(
                title: _verificationDocumentTypeLabel(
                  s,
                  document.documentType,
                ),
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

String _verificationDocumentTypeLabel(
  S s,
  VerificationDocumentType type,
) {
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

class GeneratedDocumentViewerScreen extends ConsumerWidget {
  const GeneratedDocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final documentAsync = ref.watch(
      generatedDocumentDetailProvider(documentId),
    );

    return AppPageScaffold(
      title: s.generatedDocumentViewerPageTitle,
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
              title: s.generatedDocumentViewerPageTitle,
              message: s.generatedDocumentPendingMessage,
            );
          }

          if (document.isFailed) {
            final trimmedFailureReason = document.failureReason?.trim();
            return AppStateMessage(
              icon: Icons.error_outline_rounded,
              title: s.generatedDocumentViewerPageTitle,
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
      S.of(context).locationUnavailableLabel;
  final destination =
      communeMap[destinationId]?.displayName(locale) ??
      S.of(context).locationUnavailableLabel;
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
        child: LayoutBuilder(
          builder: (context, constraints) => InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                    Theme.of(context).colorScheme.surfaceContainerLow,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Image.network(
                signedUrl,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                fit: BoxFit.cover,
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

String _sharedShipmentLaneTitle(
  BuildContext context, {
  AlgeriaCommune? originCommune,
  AlgeriaCommune? destinationCommune,
}) {
  final locale = Localizations.localeOf(context);
  final s = S.of(context);
  final origin =
      originCommune?.displayName(locale) ?? s.locationUnavailableLabel;
  final destination =
      destinationCommune?.displayName(locale) ?? s.locationUnavailableLabel;
  return '$origin -> $destination';
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

String _generatedDocumentSubtitle(
  BuildContext context,
  S s,
  GeneratedDocumentRecord document,
) {
  final detail = switch (document.status) {
    GeneratedDocumentStatus.pending => s.generatedDocumentPendingMessage,
    GeneratedDocumentStatus.failed => s.generatedDocumentFailedMessage,
    GeneratedDocumentStatus.ready =>
      document.availableAt == null
          ? s.verificationDocumentOpenPreparedMessage
          : '${s.generatedDocumentAvailableAtLabel}: ${_sharedFormatDate(document.availableAt!)}',
  };

  return '${_generatedDocumentStatusLabel(s, document)} • $detail';
}

String _generatedDocumentStatusLabel(S s, GeneratedDocumentRecord document) {
  return switch (document.status) {
    GeneratedDocumentStatus.ready => s.statusReadyLabel,
    GeneratedDocumentStatus.failed => s.generatedDocumentStatusFailedLabel,
    GeneratedDocumentStatus.pending => s.generatedDocumentStatusPendingLabel,
  };
}

AppStatusTone _generatedDocumentStatusTone(GeneratedDocumentRecord document) {
  return switch (document.status) {
    GeneratedDocumentStatus.ready => AppStatusTone.success,
    GeneratedDocumentStatus.failed => AppStatusTone.danger,
    GeneratedDocumentStatus.pending => AppStatusTone.warning,
  };
}

class _LifecycleStatusBanner extends StatelessWidget {
  const _LifecycleStatusBanner({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _CarrierPayoutSection extends StatelessWidget {
  const _CarrierPayoutSection({
    required this.booking,
    required this.payoutContextAsync,
    required this.bookingPayoutsAsync,
    required this.onRequestPayout,
  });

  final BookingRecord booking;
  final AsyncValue<BookingPayoutRequestContext> payoutContextAsync;
  final AsyncValue<List<PayoutRecord>> bookingPayoutsAsync;
  final VoidCallback onRequestPayout;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.carrierPayoutSectionTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
          payoutContextAsync.when(
            data: (contextValue) => ProfileSummaryCard(
              title: s.carrierPayoutSectionTitle,
            rows: [
              ProfileSummaryRow(
                label: s.bookingCarrierPayoutLabel,
                value: _sharedMoney(s, booking.carrierPayoutDzd),
              ),
                ProfileSummaryRow(
                  label: s.routeStatusLabel,
                  value: _carrierPayoutRequestStateLabel(s, contextValue),
                ),
                ProfileSummaryRow(
                  label: s.carrierPayoutGraceWindowLabel,
                  value: s.carrierPayoutGraceWindowValue(
                    BidiFormatters.latinIdentifier(
                      contextValue.graceWindowHours.toString(),
                    ),
                  ),
                ),
                if (contextValue.requestedAt != null)
                  ProfileSummaryRow(
                    label: s.carrierPayoutRequestedAtLabel,
                    value: _sharedFormatDate(contextValue.requestedAt!),
                  ),
                if (contextValue.payoutProcessedAt != null)
                  ProfileSummaryRow(
                    label: s.carrierPayoutReleasedAtLabel,
                    value: _sharedFormatDate(contextValue.payoutProcessedAt!),
                  ),
                if (_payoutRequestBlockedReasonLabel(s, contextValue.blockedReason)
                    case final blocked?)
                  ProfileSummaryRow(
                  label: s.reasonLabel,
                  value: blocked,
                ),
            ],
          ),
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'carrier_payout_context_failed',
              message: mapAppErrorMessage(s, error),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        payoutContextAsync.when(
            data: (contextValue) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInfoBanner(
                  message: _carrierPayoutGuidanceMessage(s, contextValue),
                ),
                const SizedBox(height: AppSpacing.md),
                if (contextValue.isEligible && !contextValue.hasRequestedPayout)
                  FilledButton.icon(
                    onPressed: onRequestPayout,
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  label: Text(s.carrierPayoutRequestAction),
                ),
              if (contextValue.hasRequestedPayout)
                AppStatusChip(
                  label: s.carrierPayoutRequestedLabel,
                  tone: AppStatusTone.warning,
                ),
              if (contextValue.isFulfilled) ...[
                const SizedBox(height: AppSpacing.sm),
                AppStatusChip(
                  label: s.paymentStatusReleasedToCarrierLabel,
                  tone: AppStatusTone.success,
                ),
              ],
            ],
          ),
          loading: () => const SizedBox.shrink(),
          error: (error, stackTrace) => const SizedBox.shrink(),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          s.carrierPayoutHistoryTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        bookingPayoutsAsync.when(
          data: (payouts) => payouts.isEmpty
              ? AppStateMessage(
                  icon: Icons.account_balance_wallet_outlined,
                  title: s.carrierPayoutHistoryTitle,
                  message: s.adminPayoutQueueEmptyMessage,
                )
              : Column(
                  children: payouts
                      .map(
                        (payout) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: AppListCard(
                            title: _sharedMoney(s, payout.amountDzd),
                            subtitle: payout.processedAt != null ||
                                    payout.createdAt != null
                                ? _sharedFormatDate(
                                    payout.processedAt ?? payout.createdAt!,
                                  )
                                : '-',
                            leading: AppStatusChip(
                              label: _transferStatusLabel(s, payout.status),
                              tone: AppStatusTone.success,
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
          loading: () => const AppLoadingState(),
          error: (error, stackTrace) => AppErrorState(
            error: AppError(
              code: 'carrier_payout_history_failed',
              message: mapAppErrorMessage(s, error),
            ),
          ),
        ),
      ],
    );
  }
}

class _BookingLifecycleTimeline extends StatelessWidget {
  const _BookingLifecycleTimeline({
    required this.events,
    required this.s,
  });

  final List<TrackingEventRecord> events;
  final S s;

  @override
  Widget build(BuildContext context) {
    final latestEventId = events.isEmpty ? null : events.first.id;
    return Column(
      children: events.asMap().entries.map((entry) {
        final index = entry.key;
        final event = entry.value;
        final isLast = index == events.length - 1;
        final isCurrent = event.id == latestEventId;
        final note = _trackingEventNote(s, event.eventType, event.note);
        final actorLabel = _trackingEventActorLabel(s, event.eventType, event.note);
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? colorScheme.tertiary
                            : colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 52,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: colorScheme.outlineVariant,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? colorScheme.tertiaryContainer
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: isCurrent
                          ? colorScheme.tertiary
                          : colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: [
                          if (isCurrent)
                            AppStatusChip(
                              label: s.bookingTimelineCurrentLabel,
                            ),
                          if (actorLabel != null)
                            AppStatusChip(
                              label: actorLabel,
                            ),
                        ],
                      ),
                      if (isCurrent || actorLabel != null)
                        const SizedBox(height: AppSpacing.sm),
                      Text(
                        _trackingEventLabel(s, event.eventType),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _sharedFormatDate(event.recordedAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (note != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          note,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(growable: false),
    );
  }
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

String _transferStatusLabel(S s, String status) {
  return switch (status) {
    'pending' => s.transferStatusPendingLabel,
    'sent' => s.transferStatusSentLabel,
    'failed' => s.transferStatusFailedLabel,
    'cancelled' => s.transferStatusCancelledLabel,
    _ => s.localizationUnknownLabel,
  };
}

bool _canOpenShipperBookingWorkspace(BookingRecord booking) {
  return booking.bookingStatus != BookingStatus.cancelled;
}

bool _canShipperCancelPendingBooking(BookingRecord booking) {
  return booking.bookingStatus == BookingStatus.pendingPayment &&
      (booking.paymentStatus == PaymentStatus.unpaid ||
          booking.paymentStatus == PaymentStatus.rejected);
}

String _shipperPaymentActionLabel(S s, BookingRecord booking) {
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => s.paymentFlowTitle,
    PaymentStatus.rejected => s.paymentProofResubmitAction,
    PaymentStatus.proofSubmitted => s.paymentFlowOpenAction,
    PaymentStatus.underVerification => s.paymentFlowOpenAction,
    PaymentStatus.secured => s.paymentFlowOpenAction,
    PaymentStatus.refunded => s.paymentFlowOpenAction,
    PaymentStatus.releasedToCarrier => s.paymentFlowOpenAction,
  };
}

String _generatedDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'payment_receipt' => s.generatedDocumentTypePaymentReceipt,
    'payout_receipt' => s.generatedDocumentTypePayoutReceipt,
    _ => s.generatedDocumentsTitle,
  };
}

String _trackingEventLabel(S s, String eventType) {
  return switch (eventType) {
    'payment_proof_submitted' => s.paymentStatusProofSubmittedLabel,
    'payment_under_review' => s.trackingEventPaymentUnderReviewLabel,
    'confirmed' => s.trackingEventConfirmedLabel,
    'picked_up' => s.trackingEventPickedUpLabel,
    'in_transit' => s.trackingEventInTransitLabel,
    'delivered_pending_review' => s.trackingEventDeliveredPendingReviewLabel,
    'completed' => s.trackingEventCompletedLabel,
    'cancelled' => s.trackingEventCancelledLabel,
    'disputed' => s.trackingEventDisputedLabel,
    'payout_requested' => s.trackingEventPayoutRequestedLabel,
    'payout_released' => s.trackingEventPayoutReleasedLabel,
    'refund_processed' => s.trackingEventRefundProcessedLabel,
    _ => s.localizationUnknownLabel,
  };
}

String? _trackingEventNote(S s, String eventType, String? note) {
  final trimmed = note?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }

  if (eventType == 'completed' &&
      trimmed == 'Booking auto-completed after delivery review grace window.') {
    return s.trackingEventAutoCompletedNote;
  }

  return trimmed;
}

String? _trackingEventActorLabel(S s, String eventType, String? note) {
  if (eventType == 'payment_proof_submitted') {
    return s.bookingTimelineActorShipperLabel;
  }
  if (eventType == 'payment_under_review' ||
      eventType == 'payout_released' ||
      eventType == 'refund_processed') {
    return s.bookingTimelineActorAdminLabel;
  }
  if (eventType == 'picked_up' ||
      eventType == 'in_transit' ||
      eventType == 'delivered_pending_review' ||
      eventType == 'payout_requested') {
    return s.bookingTimelineActorCarrierLabel;
  }
  if (eventType == 'confirmed' && note?.trim().isNotEmpty == true) {
    return s.bookingTimelineActorSystemLabel;
  }
  if (eventType == 'completed' &&
      note?.trim() ==
          'Booking auto-completed after delivery review grace window.') {
    return s.bookingTimelineActorSystemLabel;
  }
  if (eventType == 'completed') {
    return s.bookingTimelineActorShipperLabel;
  }
  return null;
}

String _bookingNextActionMessage(
  S s,
  BookingRecord booking,
  AuthSnapshot? auth,
  BookingPayoutRequestContext? payoutContext,
) {
  if (auth?.role == AppUserRole.shipper) {
    return switch (booking.paymentStatus) {
      PaymentStatus.unpaid => s.shipperNextActionPayment,
      PaymentStatus.rejected => s.shipperNextActionPayment,
      PaymentStatus.proofSubmitted => s.shipperNextActionReview,
      PaymentStatus.underVerification => s.shipperNextActionReview,
      PaymentStatus.secured when booking.bookingStatus == BookingStatus.confirmed =>
        s.carrierNextActionPickup,
      PaymentStatus.secured
          when booking.bookingStatus == BookingStatus.deliveredPendingReview =>
        s.shipperNextActionConfirmDelivery,
      PaymentStatus.releasedToCarrier => s.carrierNextActionReleased,
      _ => _bookingStatusLabel(s, booking.bookingStatus),
    };
  }

  if (auth?.role == AppUserRole.carrier) {
    if (booking.bookingStatus == BookingStatus.confirmed) {
      return s.carrierNextActionPickup;
    }
    if (booking.bookingStatus == BookingStatus.pickedUp) {
      return s.carrierNextActionTransit;
    }
    if (booking.bookingStatus == BookingStatus.inTransit) {
      return s.carrierNextActionDelivery;
    }
    if (payoutContext?.hasRequestedPayout == true) {
      return s.carrierNextActionAwaitingAdminRelease;
    }
    if (payoutContext?.isEligible == true) {
      return s.carrierNextActionPayoutRequest;
    }
    if (booking.paymentStatus == PaymentStatus.releasedToCarrier) {
      return s.carrierNextActionReleased;
    }
  }

  return _bookingStatusLabel(s, booking.bookingStatus);
}

String _carrierPayoutRequestStateLabel(
  S s,
  BookingPayoutRequestContext context,
) {
  if (context.isFulfilled) {
    return s.paymentStatusReleasedToCarrierLabel;
  }
  if (context.hasRequestedPayout) {
    return s.carrierPayoutRequestedLabel;
  }
  if (context.isEligible) {
    return s.carrierPayoutEligibleNowLabel;
  }
  return _payoutRequestBlockedReasonLabel(s, context.blockedReason) ??
      s.statusPendingLabel;
}

String _carrierPayoutGuidanceMessage(
  S s,
  BookingPayoutRequestContext context,
) {
  if (context.isFulfilled) {
    return s.carrierPayoutReleasedGuidance;
  }
  if (context.hasRequestedPayout) {
    return s.carrierPayoutRequestedGuidance;
  }
  if (context.isEligible) {
    return s.carrierPayoutEligibleGuidance;
  }
  return _payoutRequestBlockedReasonLabel(s, context.blockedReason) ??
      s.carrierPayoutPendingGuidance(
        BidiFormatters.latinIdentifier(context.graceWindowHours.toString()),
      );
}

String? _payoutRequestBlockedReasonLabel(S s, String? blockedReason) {
  return switch (blockedReason) {
    'booking_not_completed' => s.carrierPayoutBlockedReasonCompleted,
    'payment_not_secured' => s.carrierPayoutBlockedReasonPayment,
    'open_dispute' => s.carrierPayoutBlockedReasonDispute,
    'payout_account_required' => s.carrierPayoutBlockedReasonAccount,
    'payout_already_released' => s.carrierPayoutBlockedReasonReleased,
    _ => null,
  };
}
