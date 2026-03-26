import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:fleetfill/features/shipper/infrastructure/infrastructure.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingWorkflowControllerProvider = Provider<BookingWorkflowController>(
  BookingWorkflowController.new,
);

class BookingWorkflowController {
  const BookingWorkflowController(this.ref);

  final Ref ref;

  Future<BookingRecord> createBooking({
    required ShipmentDraftRecord shipment,
    required ShipmentSearchResult result,
    required bool includeInsurance,
  }) async {
    final booking = await ref
        .read(bookingRepositoryProvider)
        .createBooking(
          shipmentId: shipment.id,
          sourceType: result.sourceType,
          sourceId: result.sourceId,
          departureDate: result.departureDate,
          includeInsurance: includeInsurance,
          idempotencyKey:
              '${shipment.id}:${result.sourceType}:${result.sourceId}:${result.departureDate.toIso8601String()}:$includeInsurance',
        );

    ref
      ..invalidate(myShipperBookingsProvider)
      ..invalidate(myShipperShipmentsProvider)
      ..invalidate(shipmentDetailProvider(shipment.id))
      ..invalidate(bookingDetailProvider(booking.id));

    return booking;
  }

  Future<BookingRecord> carrierRecordMilestone({
    required String bookingId,
    required String milestone,
    String? note,
  }) async {
    final booking = await ref
        .read(bookingRepositoryProvider)
        .carrierRecordMilestone(
          bookingId: bookingId,
          milestone: milestone,
          note: note,
        );
    _invalidateBooking(booking.id, booking.shipmentId);
    return booking;
  }

  Future<BookingRecord> shipperConfirmDelivery({
    required String bookingId,
    required String shipmentId,
    String? note,
  }) async {
    final booking = await ref
        .read(bookingRepositoryProvider)
        .shipperConfirmDelivery(
          bookingId: bookingId,
          note: note,
        );
    _invalidateBooking(booking.id, shipmentId);
    return booking;
  }

  Future<BookingRecord> shipperCancelPendingBooking({
    required String bookingId,
    required String shipmentId,
    String? note,
  }) async {
    final booking = await ref
        .read(bookingRepositoryProvider)
        .shipperCancelPendingBooking(
          bookingId: bookingId,
          note: note,
        );
    _invalidateBooking(booking.id, shipmentId);
    return booking;
  }

  Future<void> submitCarrierReview({
    required String bookingId,
    required int score,
    String? comment,
  }) async {
    await ref
        .read(bookingRepositoryProvider)
        .submitCarrierReview(
          bookingId: bookingId,
          score: score,
          comment: comment,
        );
    ref
      ..invalidate(bookingDetailProvider(bookingId))
      ..invalidate(trackingEventsProvider(bookingId))
      ..invalidate(myNotificationsProvider);
  }

  Future<BookingPayoutRequestContext> carrierRequestPayout({
    required String bookingId,
    required String shipmentId,
    String? note,
  }) async {
    final context = await ref
        .read(bookingRepositoryProvider)
        .carrierRequestPayout(bookingId: bookingId, note: note);
    _invalidateBooking(bookingId, shipmentId);
    ref
      ..invalidate(bookingPayoutRequestContextProvider(bookingId))
      ..invalidate(payoutsForBookingProvider(bookingId))
      ..invalidate(payoutsProvider);
    return context;
  }

  void _invalidateBooking(String bookingId, String shipmentId) {
    ref
      ..invalidate(bookingDetailProvider(bookingId))
      ..invalidate(trackingEventsProvider(bookingId))
      ..invalidate(bookingPayoutRequestContextProvider(bookingId))
      ..invalidate(payoutsForBookingProvider(bookingId))
      ..invalidate(myShipperBookingsProvider)
      ..invalidate(myShipperShipmentsProvider)
      ..invalidate(shipmentDetailProvider(shipmentId))
      ..invalidate(carrierBookingsProvider);
  }
}
