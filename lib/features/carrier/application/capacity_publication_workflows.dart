import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final capacityPublicationWorkflowControllerProvider =
    Provider<CapacityPublicationWorkflowController>(
      CapacityPublicationWorkflowController.new,
    );

class CapacityPublicationWorkflowController {
  const CapacityPublicationWorkflowController(this.ref);

  final Ref ref;

  void invalidateAll() {
    ref
      ..invalidate(myCarrierRoutesProvider)
      ..invalidate(myOneOffTripsProvider)
      ..invalidate(capacityPublicationSummaryProvider);
  }

  void invalidateRoute(String routeId) {
    invalidateAll();
    ref
      ..invalidate(carrierRouteDetailProvider(routeId))
      ..invalidate(routeRevisionsProvider(routeId));
  }

  void invalidateOneOffTrip(String tripId) {
    invalidateAll();
    ref.invalidate(oneOffTripDetailProvider(tripId));
  }

  Future<CarrierRoute> createRoute({
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required String defaultDepartureTime,
    required List<int> recurringDaysOfWeek,
    required DateTime effectiveFrom,
    required bool isActive,
  }) async {
    final route = await ref.read(carrierPublicationRepositoryProvider).createRoute(
          vehicleId: vehicleId,
          originCommuneId: originCommuneId,
          destinationCommuneId: destinationCommuneId,
          totalCapacityKg: totalCapacityKg,
          totalCapacityVolumeM3: totalCapacityVolumeM3,
          pricePerKgDzd: pricePerKgDzd,
          defaultDepartureTime: defaultDepartureTime,
          recurringDaysOfWeek: recurringDaysOfWeek,
          effectiveFrom: effectiveFrom,
          isActive: isActive,
        );
    invalidateRoute(route.id);
    return route;
  }

  Future<CarrierRoute> updateRoute({
    required String routeId,
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required String defaultDepartureTime,
    required List<int> recurringDaysOfWeek,
    required DateTime effectiveFrom,
    required bool isActive,
  }) async {
    final route = await ref
        .read(carrierPublicationRepositoryProvider)
        .updateRouteWithRevision(
          routeId: routeId,
          vehicleId: vehicleId,
          originCommuneId: originCommuneId,
          destinationCommuneId: destinationCommuneId,
          totalCapacityKg: totalCapacityKg,
          totalCapacityVolumeM3: totalCapacityVolumeM3,
          pricePerKgDzd: pricePerKgDzd,
          defaultDepartureTime: defaultDepartureTime,
          recurringDaysOfWeek: recurringDaysOfWeek,
          effectiveFrom: effectiveFrom,
          isActive: isActive,
        );
    invalidateRoute(route.id);
    return route;
  }

  Future<void> deleteRoute(String routeId) async {
    await ref.read(carrierPublicationRepositoryProvider).deleteRoute(routeId);
    invalidateRoute(routeId);
  }

  Future<CarrierRoute> setRouteActive({
    required String routeId,
    required bool isActive,
  }) async {
    final route = await ref
        .read(carrierPublicationRepositoryProvider)
        .setRouteActive(routeId: routeId, isActive: isActive);
    invalidateRoute(route.id);
    return route;
  }

  Future<CarrierOneOffTrip> createOneOffTrip({
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime departureAt,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required bool isActive,
  }) async {
    final trip = await ref.read(carrierPublicationRepositoryProvider).createOneOffTrip(
          vehicleId: vehicleId,
          originCommuneId: originCommuneId,
          destinationCommuneId: destinationCommuneId,
          departureAt: departureAt,
          totalCapacityKg: totalCapacityKg,
          totalCapacityVolumeM3: totalCapacityVolumeM3,
          pricePerKgDzd: pricePerKgDzd,
          isActive: isActive,
        );
    invalidateOneOffTrip(trip.id);
    return trip;
  }

  Future<CarrierOneOffTrip> updateOneOffTrip({
    required String tripId,
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime departureAt,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required bool isActive,
  }) async {
    final trip = await ref.read(carrierPublicationRepositoryProvider).updateOneOffTrip(
          tripId: tripId,
          vehicleId: vehicleId,
          originCommuneId: originCommuneId,
          destinationCommuneId: destinationCommuneId,
          departureAt: departureAt,
          totalCapacityKg: totalCapacityKg,
          totalCapacityVolumeM3: totalCapacityVolumeM3,
          pricePerKgDzd: pricePerKgDzd,
          isActive: isActive,
        );
    invalidateOneOffTrip(trip.id);
    return trip;
  }

  Future<void> deleteOneOffTrip(String tripId) async {
    await ref.read(carrierPublicationRepositoryProvider).deleteOneOffTrip(tripId);
    invalidateOneOffTrip(tripId);
  }

  Future<CarrierOneOffTrip> setOneOffTripActive({
    required String tripId,
    required bool isActive,
  }) async {
    final trip = await ref
        .read(carrierPublicationRepositoryProvider)
        .setOneOffTripActive(tripId: tripId, isActive: isActive);
    invalidateOneOffTrip(trip.id);
    return trip;
  }
}
