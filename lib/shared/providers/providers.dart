import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:fleetfill/shared/providers/location_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final communesProvider = FutureProvider<List<AlgeriaCommune>>((ref) {
  return ref.read(locationRepositoryProvider).fetchCommunes();
});

final publicCarrierProfileProvider = FutureProvider.autoDispose
    .family<CarrierPublicProfileView, String>((ref, carrierId) {
      return ref
          .read(authRepositoryProvider)
          .fetchCarrierPublicProfile(carrierId);
    });

final myVehiclesProvider = FutureProvider<List<CarrierVehicle>>((ref) {
  return ref.read(vehicleRepositoryProvider).fetchMyVehicles();
});

final myPayoutAccountsProvider = FutureProvider<List<CarrierPayoutAccount>>((
  ref,
) {
  return ref.read(payoutAccountRepositoryProvider).fetchMyPayoutAccounts();
});

final myShipperShipmentsProvider = FutureProvider<List<ShipmentDraftRecord>>((
  ref,
) {
  return ref.read(shipmentRepositoryProvider).fetchMyShipments();
});

final shipmentDetailProvider = FutureProvider.autoDispose
    .family<ShipmentDraftRecord?, String>((
      ref,
      shipmentId,
    ) {
      return ref.read(shipmentRepositoryProvider).fetchShipmentById(shipmentId);
    });

final bookingDetailProvider = FutureProvider.autoDispose
    .family<BookingRecord?, String>((
      ref,
      bookingId,
    ) {
      return ref.read(bookingRepositoryProvider).fetchBookingById(bookingId);
    });

final trackingEventsProvider = FutureProvider.autoDispose
    .family<List<TrackingEventRecord>, String>((
      ref,
      bookingId,
    ) {
      return ref.read(bookingRepositoryProvider).fetchTrackingEvents(bookingId);
    });

final carrierBookingsProvider = FutureProvider<List<BookingRecord>>((ref) {
  return ref.read(bookingRepositoryProvider).fetchCarrierBookings();
});

final myShipperBookingsProvider = FutureProvider<List<BookingRecord>>((ref) {
  return ref.read(bookingRepositoryProvider).fetchMyShipperBookings();
});

final openDisputesProvider = FutureProvider<List<DisputeRecord>>((ref) {
  return ref.read(disputeRepositoryProvider).fetchOpenDisputes();
});

final payoutsProvider = FutureProvider<List<PayoutRecord>>((ref) {
  return ref.read(disputeRepositoryProvider).fetchPayouts();
});

final paymentProofsForBookingProvider = FutureProvider.autoDispose
    .family<List<PaymentProofRecord>, String>((
      ref,
      bookingId,
    ) {
      return ref
          .read(paymentProofRepositoryProvider)
          .fetchPaymentProofsForBooking(bookingId);
    });

final paymentProofDetailProvider = FutureProvider.autoDispose
    .family<PaymentProofRecord?, String>((
      ref,
      proofId,
    ) {
      return ref
          .read(paymentProofRepositoryProvider)
          .fetchPaymentProofById(proofId);
    });

final generatedDocumentsForBookingProvider = FutureProvider.autoDispose
    .family<List<GeneratedDocumentRecord>, String>((
      ref,
      bookingId,
    ) {
      return ref
          .read(paymentProofRepositoryProvider)
          .fetchGeneratedDocumentsForBooking(bookingId);
    });

final generatedDocumentDetailProvider = FutureProvider.autoDispose
    .family<GeneratedDocumentRecord?, String>((
      ref,
      documentId,
    ) {
      return ref
          .read(paymentProofRepositoryProvider)
          .fetchGeneratedDocumentById(documentId);
    });

final pendingPaymentProofsProvider =
    FutureProvider<List<AdminPaymentProofQueueItem>>((ref) {
      return ref
          .read(paymentAdminRepositoryProvider)
          .fetchPendingPaymentProofs();
    });

final adminPaymentProofSearchResultsProvider = FutureProvider.autoDispose
    .family<List<AdminPaymentProofQueueItem>, String>((ref, query) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchPaymentProofQueue(query: query);
    });

final adminOperationalSummaryProvider = FutureProvider<AdminOperationalSummary>(
  (
    ref,
  ) {
    return ref
        .read(adminOperationsRepositoryProvider)
        .fetchOperationalSummary();
  },
);

final adminUsersProvider = FutureProvider<List<AdminUserListItem>>((ref) {
  return ref.read(adminOperationsRepositoryProvider).fetchUsers();
});

final adminUserSearchResultsProvider = FutureProvider.autoDispose
    .family<List<AdminUserListItem>, String>((
      ref,
      query,
    ) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchUsers(query: query);
    });

final adminUserDetailProvider = FutureProvider.autoDispose
    .family<AdminUserDetail?, String>((
      ref,
      profileId,
    ) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchUserDetail(profileId);
    });

final adminBookingSearchResultsProvider = FutureProvider.autoDispose
    .family<List<BookingRecord>, String>((ref, query) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchBookings(query: query);
    });

final adminPlatformSettingsProvider =
    FutureProvider<List<PlatformSettingRecord>>((ref) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchPlatformSettings();
    });

final adminAuditLogsProvider = FutureProvider<List<AdminAuditLogRecord>>((ref) {
  return ref.read(adminOperationsRepositoryProvider).fetchAuditLogs();
});

final adminEmailLogsProvider = FutureProvider<List<EmailDeliveryLogRecord>>((
  ref,
) {
  return ref.read(adminOperationsRepositoryProvider).fetchEmailLogs();
});

final adminFilteredEmailLogsProvider = FutureProvider.autoDispose
    .family<List<EmailDeliveryLogRecord>, ({String? status, String? query})>((
      ref,
      filter,
    ) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchEmailLogs(
            status: filter.status,
            query: filter.query,
          );
    });

final adminDeadLetterEmailJobsProvider =
    FutureProvider<List<EmailOutboxJobRecord>>((ref) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchDeadLetterEmailJobs();
    });

final adminEligiblePayoutsProvider =
    FutureProvider<List<EligiblePayoutQueueItem>>((ref) {
      return ref.read(adminOperationsRepositoryProvider).fetchEligiblePayouts();
    });

final adminEligiblePayoutSearchResultsProvider = FutureProvider.autoDispose
    .family<List<EligiblePayoutQueueItem>, String>((ref, query) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchEligiblePayoutQueue(query: query);
    });

final adminVerificationQueueSearchResultsProvider = FutureProvider.autoDispose
    .family<List<VerificationReviewPacket>, String>((ref, query) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchVerificationQueue(query: query);
    });

final adminDisputeQueueSearchResultsProvider = FutureProvider.autoDispose
    .family<List<DisputeRecord>, String>((ref, query) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchDisputeQueue(query: query);
    });

final adminAutomationAlertsProvider =
    FutureProvider<List<AdminAutomationAlertItem>>((ref) {
      return ref
          .read(adminOperationsRepositoryProvider)
          .fetchOverdueAutomationAlerts();
    });

final clientSettingsProvider = FutureProvider<ClientSettings>((ref) {
  return ref.read(bookingRepositoryProvider).fetchClientSettings();
});

final notificationDetailProvider = FutureProvider.autoDispose
    .family<AppNotificationRecord?, String>((
      ref,
      notificationId,
    ) {
      return ref
          .read(notificationRepositoryProvider)
          .fetchNotificationById(notificationId);
    });

final vehicleDetailProvider = FutureProvider.autoDispose
    .family<CarrierVehicle?, String>((
      ref,
      vehicleId,
    ) {
      return ref.read(vehicleRepositoryProvider).fetchVehicleById(vehicleId);
    });

final myCarrierRoutesProvider = FutureProvider.family<List<CarrierRoute>, int>((
  ref,
  limit,
) {
  return ref
      .read(carrierPublicationRepositoryProvider)
      .fetchMyRoutes(limit: limit);
});

final carrierRouteDetailProvider = FutureProvider.autoDispose
    .family<CarrierRoute?, String>((
      ref,
      routeId,
    ) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchRouteById(routeId);
    });

final routeRevisionsProvider = FutureProvider.autoDispose
    .family<List<RouteRevisionRecord>, String>((ref, routeId) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchRouteRevisions(routeId);
    });

final myOneOffTripsProvider =
    FutureProvider.family<List<CarrierOneOffTrip>, int>((
      ref,
      limit,
    ) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchMyOneOffTrips(limit: limit);
    });

final oneOffTripDetailProvider = FutureProvider.autoDispose
    .family<CarrierOneOffTrip?, String>((ref, tripId) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchOneOffTripById(tripId);
    });

final capacityPublicationSummaryProvider =
    FutureProvider<CapacityPublicationSummary>((ref) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchPublicationSummary();
    });

final myVerificationDocumentsProvider =
    FutureProvider<List<VerificationDocumentRecord>>((ref) {
      return ref.read(vehicleRepositoryProvider).fetchMyVerificationDocuments();
    });

final verificationDocumentDetailProvider = FutureProvider.autoDispose
    .family<VerificationDocumentRecord?, String>((
      ref,
      documentId,
    ) {
      return ref
          .read(vehicleRepositoryProvider)
          .fetchVerificationDocumentById(documentId);
    });

final verificationDocumentsForEntityProvider = FutureProvider.autoDispose
    .family<
      List<VerificationDocumentRecord>,
      ({
        VerificationEntityType entityType,
        String entityId,
      })
    >((ref, request) {
      return ref
          .read(vehicleRepositoryProvider)
          .fetchVerificationDocumentsForEntity(
            entityType: request.entityType,
            entityId: request.entityId,
          );
    });

final pendingVerificationPacketsProvider =
    FutureProvider<List<VerificationReviewPacket>>((ref) {
      return ref
          .read(verificationAdminRepositoryProvider)
          .fetchPendingReviewPackets();
    });

final pendingVerificationPacketProvider = FutureProvider.autoDispose
    .family<VerificationReviewPacket?, String>((ref, carrierId) {
      return ref
          .read(verificationAdminRepositoryProvider)
          .fetchPendingReviewPacketByCarrierId(carrierId);
    });

final verificationAuditProvider = FutureProvider<List<AdminAuditLogRecord>>((
  ref,
) {
  return ref
      .read(verificationAdminRepositoryProvider)
      .fetchLatestVerificationAudit();
});
