enum ShipmentStatus { draft, booked, cancelled;
  static ShipmentStatus fromDatabase(Object? value) {
    return switch (value) {
      'booked' => ShipmentStatus.booked,
      'cancelled' => ShipmentStatus.cancelled,
      _ => ShipmentStatus.draft,
    };
  }

  String get databaseValue => name;
}

class ShipmentItemDraft {
  const ShipmentItemDraft({
    required this.label,
    required this.quantity,
    this.id,
    this.weightKg,
    this.volumeM3,
    this.notes,
  });

  factory ShipmentItemDraft.fromJson(Map<String, dynamic> json) {
    return ShipmentItemDraft(
      id: json['id'] as String?,
      label: (json['label'] as String?)?.trim() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
      volumeM3: (json['volume_m3'] as num?)?.toDouble(),
      notes: (json['notes'] as String?)?.trim(),
    );
  }

  final String? id;
  final String label;
  final int quantity;
  final double? weightKg;
  final double? volumeM3;
  final String? notes;
}

class ShipmentDraftRecord {
  const ShipmentDraftRecord({
    required this.id,
    required this.shipperId,
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.pickupWindowStart,
    required this.pickupWindowEnd,
    required this.totalWeightKg,
    required this.totalVolumeM3,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory ShipmentDraftRecord.fromJson(
    Map<String, dynamic> json, {
    List<ShipmentItemDraft> items = const <ShipmentItemDraft>[],
  }) {
    return ShipmentDraftRecord(
      id: json['id'] as String,
      shipperId: json['shipper_id'] as String,
      originCommuneId: json['origin_commune_id'] as int,
      destinationCommuneId: json['destination_commune_id'] as int,
      pickupWindowStart: DateTime.parse(json['pickup_window_start'] as String),
      pickupWindowEnd: DateTime.parse(json['pickup_window_end'] as String),
      totalWeightKg: (json['total_weight_kg'] as num).toDouble(),
      totalVolumeM3: (json['total_volume_m3'] as num?)?.toDouble(),
      category: (json['category'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim(),
      status: ShipmentStatus.fromDatabase(json['status']),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
      items: items,
    );
  }

  final String id;
  final String shipperId;
  final int originCommuneId;
  final int destinationCommuneId;
  final DateTime pickupWindowStart;
  final DateTime pickupWindowEnd;
  final double totalWeightKg;
  final double? totalVolumeM3;
  final String category;
  final String? description;
  final ShipmentStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ShipmentItemDraft> items;
}

class ShipmentDraftInput {
  const ShipmentDraftInput({
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.pickupWindowStart,
    required this.pickupWindowEnd,
    required this.totalWeightKg,
    required this.totalVolumeM3,
    required this.category,
    required this.description,
    required this.items,
  });

  final int originCommuneId;
  final int destinationCommuneId;
  final DateTime pickupWindowStart;
  final DateTime pickupWindowEnd;
  final double totalWeightKg;
  final double? totalVolumeM3;
  final String category;
  final String? description;
  final List<ShipmentItemDraft> items;
}

enum SearchResultMode { exact, nearestDate, redefineSearch;
  static SearchResultMode fromDatabase(String value) {
    return switch (value) {
      'nearest_date' => SearchResultMode.nearestDate,
      'redefine_search' => SearchResultMode.redefineSearch,
      _ => SearchResultMode.exact,
    };
  }
}

enum SearchSortOption { recommended, topRated, lowestPrice, nearestDeparture }

class ShipmentSearchQuery {
  const ShipmentSearchQuery({
    required this.shipmentId,
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.requestedDate,
    required this.totalWeightKg,
    required this.totalVolumeM3,
    this.offset = 0,
    this.limit = 20,
  });

  final String shipmentId;
  final int originCommuneId;
  final int destinationCommuneId;
  final DateTime requestedDate;
  final double totalWeightKg;
  final double? totalVolumeM3;
  final int offset;
  final int limit;
}

class ShipmentSearchResult {
  const ShipmentSearchResult({
    required this.sourceId,
    required this.sourceType,
    required this.carrierId,
    required this.carrierName,
    required this.vehicleId,
    required this.originCommuneId,
    required this.destinationCommuneId,
    required this.departureAt,
    required this.departureDate,
    required this.totalCapacityKg,
    required this.totalCapacityVolumeM3,
    required this.remainingCapacityKg,
    required this.remainingVolumeM3,
    required this.pricePerKgDzd,
    required this.estimatedTotalDzd,
    required this.ratingAverage,
    required this.ratingCount,
    required this.dayDistance,
  });

  factory ShipmentSearchResult.fromJson(Map<String, dynamic> json) {
    return ShipmentSearchResult(
      sourceId: json['source_id'] as String,
      sourceType: (json['source_type'] as String?)?.trim() ?? 'route',
      carrierId: json['carrier_id'] as String,
      carrierName: (json['carrier_name'] as String?)?.trim() ?? '',
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: json['origin_commune_id'] as int,
      destinationCommuneId: json['destination_commune_id'] as int,
      departureAt: DateTime.parse(json['departure_at'] as String),
      departureDate: DateTime.parse(json['departure_date'] as String),
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3: (json['total_capacity_volume_m3'] as num?)?.toDouble(),
      remainingCapacityKg: (json['remaining_capacity_kg'] as num).toDouble(),
      remainingVolumeM3: (json['remaining_volume_m3'] as num?)?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      estimatedTotalDzd: (json['estimated_total_dzd'] as num).toDouble(),
      ratingAverage: (json['rating_average'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
      dayDistance: (json['day_distance'] as num?)?.toInt() ?? 0,
    );
  }

  final String sourceId;
  final String sourceType;
  final String carrierId;
  final String carrierName;
  final String vehicleId;
  final int originCommuneId;
  final int destinationCommuneId;
  final DateTime departureAt;
  final DateTime departureDate;
  final double totalCapacityKg;
  final double? totalCapacityVolumeM3;
  final double remainingCapacityKg;
  final double? remainingVolumeM3;
  final double pricePerKgDzd;
  final double estimatedTotalDzd;
  final double ratingAverage;
  final int ratingCount;
  final int dayDistance;
}

class ShipmentSearchResponse {
  const ShipmentSearchResponse({
    required this.mode,
    required this.results,
    required this.nearestDates,
    required this.nextOffset,
    required this.totalCount,
  });

  factory ShipmentSearchResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentSearchResponse(
      mode: SearchResultMode.fromDatabase((json['mode'] as String?) ?? 'exact'),
      results: ((json['results'] as List<dynamic>?) ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(ShipmentSearchResult.fromJson)
          .toList(growable: false),
      nearestDates: ((json['nearest_dates'] as List<dynamic>?) ?? const <dynamic>[])
          .map((value) => DateTime.parse(value as String))
          .toList(growable: false),
      nextOffset: (json['next_offset'] as num?)?.toInt(),
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
    );
  }

  final SearchResultMode mode;
  final List<ShipmentSearchResult> results;
  final List<DateTime> nearestDates;
  final int? nextOffset;
  final int totalCount;
}

class BookingReviewSelection {
  const BookingReviewSelection({
    required this.shipment,
    required this.result,
  });

  final ShipmentDraftRecord shipment;
  final ShipmentSearchResult result;
}
