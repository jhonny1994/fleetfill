import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/models/algeria_location.dart';
import 'package:fleetfill/shared/providers/location_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final communesProvider = FutureProvider<List<AlgeriaCommune>>((ref) {
  return ref.read(locationRepositoryProvider).fetchCommunes();
});

final publicCarrierProfileProvider =
    FutureProvider.autoDispose.family<CarrierPublicProfileView, String>((ref, carrierId) {
      return ref
          .read(authRepositoryProvider)
          .fetchCarrierPublicProfile(carrierId);
    });

final myVehiclesProvider = FutureProvider<List<CarrierVehicle>>((ref) {
  return ref.read(vehicleRepositoryProvider).fetchMyVehicles();
});

final myPayoutAccountsProvider = FutureProvider<List<CarrierPayoutAccount>>((ref) {
  return ref.read(payoutAccountRepositoryProvider).fetchMyPayoutAccounts();
});

final myShipperShipmentsProvider =
    FutureProvider<List<ShipmentDraftRecord>>((ref) {
      return ref.read(shipmentRepositoryProvider).fetchMyShipments();
    });

final shipmentDetailProvider =
    FutureProvider.autoDispose.family<ShipmentDraftRecord?, String>((
      ref,
      shipmentId,
    ) {
      return ref.read(shipmentRepositoryProvider).fetchShipmentById(shipmentId);
    });

final vehicleDetailProvider = FutureProvider.autoDispose.family<CarrierVehicle?, String>((
  ref,
  vehicleId,
) {
  return ref.read(vehicleRepositoryProvider).fetchVehicleById(vehicleId);
});

final myCarrierRoutesProvider = FutureProvider.family<List<CarrierRoute>, int>((
  ref,
  limit,
) {
  return ref.read(carrierPublicationRepositoryProvider).fetchMyRoutes(limit: limit);
});

final carrierRouteDetailProvider = FutureProvider.autoDispose.family<CarrierRoute?, String>((
  ref,
  routeId,
) {
  return ref.read(carrierPublicationRepositoryProvider).fetchRouteById(routeId);
});

final routeRevisionsProvider =
    FutureProvider.autoDispose.family<List<RouteRevisionRecord>, String>((ref, routeId) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchRouteRevisions(routeId);
    });

final myOneOffTripsProvider = FutureProvider.family<List<CarrierOneOffTrip>, int>((
  ref,
  limit,
) {
  return ref
      .read(carrierPublicationRepositoryProvider)
      .fetchMyOneOffTrips(limit: limit);
});

final oneOffTripDetailProvider =
    FutureProvider.autoDispose.family<CarrierOneOffTrip?, String>((ref, tripId) {
      return ref
          .read(carrierPublicationRepositoryProvider)
          .fetchOneOffTripById(tripId);
    });

final capacityPublicationSummaryProvider =
    FutureProvider<CapacityPublicationSummary>((ref) {
      return ref.read(carrierPublicationRepositoryProvider).fetchPublicationSummary();
    });

final myVerificationDocumentsProvider =
    FutureProvider<List<VerificationDocumentRecord>>((ref) {
      return ref.read(vehicleRepositoryProvider).fetchMyVerificationDocuments();
    });

final verificationDocumentDetailProvider =
    FutureProvider.autoDispose.family<VerificationDocumentRecord?, String>((
      ref,
      documentId,
    ) {
      return ref
          .read(vehicleRepositoryProvider)
          .fetchVerificationDocumentById(documentId);
    });

final verificationDocumentsForEntityProvider =
    FutureProvider.autoDispose.family<
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

final pendingVerificationPacketProvider =
    FutureProvider.autoDispose.family<VerificationReviewPacket?, String>((ref, carrierId) {
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
