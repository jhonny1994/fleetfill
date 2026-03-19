import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:fleetfill/features/shipper/infrastructure/infrastructure.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingWorkflowControllerProvider =
    Provider<BookingWorkflowController>(BookingWorkflowController.new);

class BookingWorkflowController {
  const BookingWorkflowController(this.ref);

  final Ref ref;

  Future<BookingRecord> createBooking({
    required ShipmentDraftRecord shipment,
    required ShipmentSearchResult result,
    required bool includeInsurance,
  }) async {
    final booking = await ref.read(bookingRepositoryProvider).createBooking(
          shipmentId: shipment.id,
          sourceType: result.sourceType,
          sourceId: result.sourceId,
          departureDate: result.departureDate,
          includeInsurance: includeInsurance,
          idempotencyKey: '${shipment.id}:${result.sourceType}:${result.sourceId}:${result.departureDate.toIso8601String()}:$includeInsurance',
        );

    ref
      ..invalidate(myShipperShipmentsProvider)
      ..invalidate(shipmentDetailProvider(shipment.id))
      ..invalidate(bookingDetailProvider(booking.id));

    return booking;
  }
}
