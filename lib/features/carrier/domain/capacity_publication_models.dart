import 'package:freezed_annotation/freezed_annotation.dart';

part 'capacity_publication_models.freezed.dart';

@freezed
abstract class CarrierRoute with _$CarrierRoute {
  const factory CarrierRoute({
    required String id,
    required String carrierId,
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
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _CarrierRoute;

  const CarrierRoute._();

  factory CarrierRoute.fromJson(Map<String, dynamic> json) {
    return CarrierRoute(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: (json['origin_commune_id'] as num).toInt(),
      destinationCommuneId: (json['destination_commune_id'] as num).toInt(),
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3: (json['total_capacity_volume_m3'] as num?)
          ?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      defaultDepartureTime:
          (json['default_departure_time'] as String?)?.trim() ?? '',
      recurringDaysOfWeek:
          (json['recurring_days_of_week'] as List<dynamic>? ??
                  const <dynamic>[])
              .cast<num>()
              .map((value) => value.toInt())
              .toList(growable: false),
      effectiveFrom: DateTime.parse(json['effective_from'] as String),
      isActive: json['is_active'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class CarrierOneOffTrip with _$CarrierOneOffTrip {
  const factory CarrierOneOffTrip({
    required String id,
    required String carrierId,
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime departureAt,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required bool isActive,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _CarrierOneOffTrip;

  const CarrierOneOffTrip._();

  factory CarrierOneOffTrip.fromJson(Map<String, dynamic> json) {
    return CarrierOneOffTrip(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: (json['origin_commune_id'] as num).toInt(),
      destinationCommuneId: (json['destination_commune_id'] as num).toInt(),
      departureAt: DateTime.parse(json['departure_at'] as String),
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3: (json['total_capacity_volume_m3'] as num?)
          ?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      isActive: json['is_active'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class RouteRevisionRecord with _$RouteRevisionRecord {
  const factory RouteRevisionRecord({
    required String id,
    required String routeId,
    required String vehicleId,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double pricePerKgDzd,
    required String defaultDepartureTime,
    required List<int> recurringDaysOfWeek,
    required DateTime effectiveFrom,
    required String? createdBy,
    required DateTime? createdAt,
  }) = _RouteRevisionRecord;

  const RouteRevisionRecord._();

  factory RouteRevisionRecord.fromJson(Map<String, dynamic> json) {
    return RouteRevisionRecord(
      id: json['id'] as String,
      routeId: json['route_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3: (json['total_capacity_volume_m3'] as num?)
          ?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      defaultDepartureTime:
          (json['default_departure_time'] as String?)?.trim() ?? '',
      recurringDaysOfWeek:
          (json['recurring_days_of_week'] as List<dynamic>? ??
                  const <dynamic>[])
              .cast<num>()
              .map((value) => value.toInt())
              .toList(growable: false),
      effectiveFrom: DateTime.parse(json['effective_from'] as String),
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class CapacityPublicationSummary with _$CapacityPublicationSummary {
  const factory CapacityPublicationSummary({
    required int activeRecurringRouteCount,
    required int activeOneOffTripCount,
    required int upcomingDepartureCount,
    required double publishedCapacityKg,
    required double reservedCapacityKg,
  }) = _CapacityPublicationSummary;

  const CapacityPublicationSummary._();

  static const empty = CapacityPublicationSummary(
    activeRecurringRouteCount: 0,
    activeOneOffTripCount: 0,
    upcomingDepartureCount: 0,
    publishedCapacityKg: 0,
    reservedCapacityKg: 0,
  );

  double get utilizationRatio {
    if (publishedCapacityKg <= 0) {
      return 0;
    }
    return (reservedCapacityKg / publishedCapacityKg).clamp(0, 1);
  }
}
