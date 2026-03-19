class CarrierRoute {
  const CarrierRoute({
    required this.id,
    required this.carrierId,
    required this.vehicleId,
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.totalCapacityKg,
    required this.totalCapacityVolumeM3,
    required this.pricePerKgDzd,
    required this.defaultDepartureTime,
    required this.recurringDaysOfWeek,
    required this.effectiveFrom,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarrierRoute.fromJson(Map<String, dynamic> json) {
    return CarrierRoute(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: json['origin_commune_id'] as int,
      destinationCommuneId: json['destination_commune_id'] as int,
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3: (json['total_capacity_volume_m3'] as num?)
          ?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      defaultDepartureTime:
          (json['default_departure_time'] as String?)?.trim() ?? '',
      recurringDaysOfWeek: (json['recurring_days_of_week'] as List<dynamic>? ??
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

  final String id;
  final String carrierId;
  final String vehicleId;
  final int originCommuneId;
  final int destinationCommuneId;
  final double totalCapacityKg;
  final double? totalCapacityVolumeM3;
  final double pricePerKgDzd;
  final String defaultDepartureTime;
  final List<int> recurringDaysOfWeek;
  final DateTime effectiveFrom;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class CarrierOneOffTrip {
  const CarrierOneOffTrip({
    required this.id,
    required this.carrierId,
    required this.vehicleId,
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.departureAt,
    required this.totalCapacityKg,
    required this.totalCapacityVolumeM3,
    required this.pricePerKgDzd,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarrierOneOffTrip.fromJson(Map<String, dynamic> json) {
    return CarrierOneOffTrip(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: json['origin_commune_id'] as int,
      destinationCommuneId: json['destination_commune_id'] as int,
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

  final String id;
  final String carrierId;
  final String vehicleId;
  final int originCommuneId;
  final int destinationCommuneId;
  final DateTime departureAt;
  final double totalCapacityKg;
  final double? totalCapacityVolumeM3;
  final double pricePerKgDzd;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class RouteRevisionRecord {
  const RouteRevisionRecord({
    required this.id,
    required this.routeId,
    required this.vehicleId,
    required this.totalCapacityKg,
    required this.totalCapacityVolumeM3,
    required this.pricePerKgDzd,
    required this.defaultDepartureTime,
    required this.recurringDaysOfWeek,
    required this.effectiveFrom,
    required this.createdBy,
    required this.createdAt,
  });

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
      recurringDaysOfWeek: (json['recurring_days_of_week'] as List<dynamic>? ??
              const <dynamic>[])
          .cast<num>()
          .map((value) => value.toInt())
          .toList(growable: false),
      effectiveFrom: DateTime.parse(json['effective_from'] as String),
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  final String id;
  final String routeId;
  final String vehicleId;
  final double totalCapacityKg;
  final double? totalCapacityVolumeM3;
  final double pricePerKgDzd;
  final String defaultDepartureTime;
  final List<int> recurringDaysOfWeek;
  final DateTime effectiveFrom;
  final String? createdBy;
  final DateTime? createdAt;
}

class CapacityPublicationSummary {
  const CapacityPublicationSummary({
    required this.activeRecurringRouteCount,
    required this.activeOneOffTripCount,
    required this.upcomingDepartureCount,
    required this.publishedCapacityKg,
    required this.reservedCapacityKg,
  });

  const CapacityPublicationSummary.empty()
    : activeRecurringRouteCount = 0,
      activeOneOffTripCount = 0,
      upcomingDepartureCount = 0,
      publishedCapacityKg = 0,
      reservedCapacityKg = 0;

  final int activeRecurringRouteCount;
  final int activeOneOffTripCount;
  final int upcomingDepartureCount;
  final double publishedCapacityKg;
  final double reservedCapacityKg;

  double get utilizationRatio {
    if (publishedCapacityKg <= 0) {
      return 0;
    }
    return (reservedCapacityKg / publishedCapacityKg).clamp(0, 1);
  }
}
