import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:fleetfill/features/shipper/infrastructure/infrastructure.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shipmentWorkflowControllerProvider =
    Provider<ShipmentWorkflowController>(ShipmentWorkflowController.new);

class ShipmentWorkflowController {
  const ShipmentWorkflowController(this.ref);

  final Ref ref;

  Future<ShipmentDraftRecord> createShipmentDraft(ShipmentDraftInput input) async {
    final shipment = await ref.read(shipmentRepositoryProvider).createShipmentDraft(input);
    _invalidateShipment(shipment.id);
    return shipment;
  }

  Future<ShipmentDraftRecord> updateShipmentDraft({
    required String shipmentId,
    required ShipmentDraftInput input,
  }) async {
    final shipment = await ref
        .read(shipmentRepositoryProvider)
        .updateShipmentDraft(shipmentId: shipmentId, input: input);
    _invalidateShipment(shipment.id);
    return shipment;
  }

  Future<void> deleteShipmentDraft(String shipmentId) async {
    await ref.read(shipmentRepositoryProvider).deleteShipmentDraft(shipmentId);
    _invalidateShipment(shipmentId);
  }

  void _invalidateShipment(String shipmentId) {
    ref
      ..invalidate(myShipperShipmentsProvider)
      ..invalidate(shipmentDetailProvider(shipmentId));
  }
}
