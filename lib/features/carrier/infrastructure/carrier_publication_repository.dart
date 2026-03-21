import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/capacity_publication_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final carrierPublicationRepositoryProvider =
    Provider<CarrierPublicationRepository>((ref) {
      final environment = ref.watch(appEnvironmentConfigProvider);
      final logger = ref.watch(appLoggerProvider);
      return CarrierPublicationRepository(
        environment: environment,
        logger: logger,
      );
    });

class CarrierPublicationRepository {
  const CarrierPublicationRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;
  static const defaultPageSize = 20;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<CarrierRoute>> fetchMyRoutes({
    int limit = defaultPageSize,
    int offset = 0,
  }) async {
    final response = await _client
        .from('routes')
        .select()
        .range(offset, offset + limit - 1)
        .order('updated_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(CarrierRoute.fromJson)
        .toList(growable: false);
  }

  Future<CarrierRoute?> fetchRouteById(String routeId) async {
    final response = await _client
        .from('routes')
        .select()
        .eq('id', routeId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return CarrierRoute.fromJson(response);
  }

  Future<List<RouteRevisionRecord>> fetchRouteRevisions(
    String routeId, {
    int limit = defaultPageSize,
  }) async {
    final response = await _client
        .from('route_revisions')
        .select()
        .eq('route_id', routeId)
        .limit(limit)
        .order('effective_from', ascending: false)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(RouteRevisionRecord.fromJson)
        .toList(growable: false);
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
    final response = await _client.rpc<Map<String, dynamic>>(
      'create_carrier_route',
      params: {
        'p_vehicle_id': vehicleId,
        'p_origin_commune_id': originCommuneId,
        'p_destination_commune_id': destinationCommuneId,
        'p_total_capacity_kg': totalCapacityKg,
        'p_total_capacity_volume_m3': totalCapacityVolumeM3,
        'p_price_per_kg_dzd': pricePerKgDzd,
        'p_default_departure_time': defaultDepartureTime,
        'p_recurring_days_of_week': recurringDaysOfWeek,
        'p_effective_from': effectiveFrom.toIso8601String(),
        'p_is_active': isActive,
      },
    );

    logger.info('Created carrier route', context: {'vehicleId': vehicleId});
    return CarrierRoute.fromJson(response);
  }

  Future<CarrierRoute> updateRouteWithRevision({
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
    final response = await _client.rpc<Map<String, dynamic>>(
      'update_route_with_revision',
      params: {
        'p_route_id': routeId,
        'p_vehicle_id': vehicleId,
        'p_origin_commune_id': originCommuneId,
        'p_destination_commune_id': destinationCommuneId,
        'p_total_capacity_kg': totalCapacityKg,
        'p_total_capacity_volume_m3': totalCapacityVolumeM3,
        'p_price_per_kg_dzd': pricePerKgDzd,
        'p_default_departure_time': defaultDepartureTime,
        'p_recurring_days_of_week': recurringDaysOfWeek,
        'p_effective_from': effectiveFrom.toIso8601String(),
        'p_is_active': isActive,
      },
    );

    logger.info(
      'Updated carrier route with revision',
      context: {'routeId': routeId},
    );
    return CarrierRoute.fromJson(response);
  }

  Future<void> deleteRoute(String routeId) async {
    await _client.from('routes').delete().eq('id', routeId);
  }

  Future<CarrierRoute> setRouteActive({
    required String routeId,
    required bool isActive,
  }) async {
    final route = await fetchRouteById(routeId);
    if (route == null) {
      throw const PostgrestException(message: 'route_not_found');
    }

    return updateRouteWithRevision(
      routeId: route.id,
      vehicleId: route.vehicleId,
      originCommuneId: route.originCommuneId,
      destinationCommuneId: route.destinationCommuneId,
      totalCapacityKg: route.totalCapacityKg,
      totalCapacityVolumeM3: route.totalCapacityVolumeM3,
      pricePerKgDzd: route.pricePerKgDzd,
      defaultDepartureTime: route.defaultDepartureTime,
      recurringDaysOfWeek: route.recurringDaysOfWeek,
      effectiveFrom: route.effectiveFrom,
      isActive: isActive,
    );
  }

  Future<List<CarrierOneOffTrip>> fetchMyOneOffTrips({
    int limit = defaultPageSize,
    int offset = 0,
  }) async {
    final response = await _client
        .from('oneoff_trips')
        .select()
        .range(offset, offset + limit - 1)
        .order('departure_at', ascending: true);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(CarrierOneOffTrip.fromJson)
        .toList(growable: false);
  }

  Future<CarrierOneOffTrip?> fetchOneOffTripById(String tripId) async {
    final response = await _client
        .from('oneoff_trips')
        .select()
        .eq('id', tripId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return CarrierOneOffTrip.fromJson(response);
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
    final response = await _client.rpc<Map<String, dynamic>>(
      'create_oneoff_trip',
      params: {
        'p_vehicle_id': vehicleId,
        'p_origin_commune_id': originCommuneId,
        'p_destination_commune_id': destinationCommuneId,
        'p_departure_at': departureAt.toIso8601String(),
        'p_total_capacity_kg': totalCapacityKg,
        'p_total_capacity_volume_m3': totalCapacityVolumeM3,
        'p_price_per_kg_dzd': pricePerKgDzd,
        'p_is_active': isActive,
      },
    );

    return CarrierOneOffTrip.fromJson(response);
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
    final response = await _client.rpc<Map<String, dynamic>>(
      'update_oneoff_trip',
      params: {
        'p_trip_id': tripId,
        'p_vehicle_id': vehicleId,
        'p_origin_commune_id': originCommuneId,
        'p_destination_commune_id': destinationCommuneId,
        'p_departure_at': departureAt.toIso8601String(),
        'p_total_capacity_kg': totalCapacityKg,
        'p_total_capacity_volume_m3': totalCapacityVolumeM3,
        'p_price_per_kg_dzd': pricePerKgDzd,
        'p_is_active': isActive,
      },
    );

    return CarrierOneOffTrip.fromJson(response);
  }

  Future<void> deleteOneOffTrip(String tripId) async {
    await _client.from('oneoff_trips').delete().eq('id', tripId);
  }

  Future<CarrierOneOffTrip> setOneOffTripActive({
    required String tripId,
    required bool isActive,
  }) async {
    final trip = await fetchOneOffTripById(tripId);
    if (trip == null) {
      throw const PostgrestException(message: 'oneoff_trip_not_found');
    }

    return updateOneOffTrip(
      tripId: trip.id,
      vehicleId: trip.vehicleId,
      originCommuneId: trip.originCommuneId,
      destinationCommuneId: trip.destinationCommuneId,
      departureAt: trip.departureAt,
      totalCapacityKg: trip.totalCapacityKg,
      totalCapacityVolumeM3: trip.totalCapacityVolumeM3,
      pricePerKgDzd: trip.pricePerKgDzd,
      isActive: isActive,
    );
  }

  Future<CapacityPublicationSummary> fetchPublicationSummary() async {
    final today = DateTime.now();
    final routesResponse = await _client
        .from('routes')
        .select('total_capacity_kg,is_active');
    final tripsResponse = await _client
        .from('oneoff_trips')
        .select('total_capacity_kg,is_active,departure_at');

    final departureResponse = await _client
        .from('route_departure_instances')
        .select('reserved_capacity_kg')
        .gte(
          'departure_date',
          DateTime(today.year, today.month, today.day).toIso8601String(),
        );

    final departureInstances = (departureResponse as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final routes = (routesResponse as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final trips = (tripsResponse as List<dynamic>).cast<Map<String, dynamic>>();

    final activeRoutes = routes
        .where((route) => route['is_active'] == true)
        .toList(growable: false);
    final activeTrips = trips
        .where((trip) {
          if (trip['is_active'] != true) {
            return false;
          }
          final departureAt = DateTime.tryParse(
            trip['departure_at'] as String? ?? '',
          );
          return departureAt != null && !departureAt.isBefore(today);
        })
        .toList(growable: false);

    final publishedCapacityKg =
        activeRoutes.fold<double>(
          0,
          (sum, route) =>
              sum + ((route['total_capacity_kg'] as num?)?.toDouble() ?? 0),
        ) +
        activeTrips.fold<double>(
          0,
          (sum, trip) =>
              sum + ((trip['total_capacity_kg'] as num?)?.toDouble() ?? 0),
        );
    final reservedCapacityKg = departureInstances.fold<double>(
      0,
      (sum, item) =>
          sum + ((item['reserved_capacity_kg'] as num?)?.toDouble() ?? 0),
    );

    return CapacityPublicationSummary(
      activeRecurringRouteCount: activeRoutes.length,
      activeOneOffTripCount: activeTrips.length,
      upcomingDepartureCount: departureInstances.length + activeTrips.length,
      publishedCapacityKg: publishedCapacityKg,
      reservedCapacityKg: reservedCapacityKg,
    );
  }
}
