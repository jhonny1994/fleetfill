import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipment_models.freezed.dart';
part 'shipment_models.g.dart';

enum ShipmentStatus {
  draft,
  booked,
  cancelled;

  static ShipmentStatus fromDatabase(Object? value) {
    return switch (value) {
      'booked' => ShipmentStatus.booked,
      'cancelled' => ShipmentStatus.cancelled,
      _ => ShipmentStatus.draft,
    };
  }

  String get databaseValue => name;
}

@freezed
abstract class ShipmentDraftRecord with _$ShipmentDraftRecord {
  const factory ShipmentDraftRecord({
    required String id,
    required String shipperId,
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime pickupDate,
    required double totalWeightKg,
    required double? totalVolumeM3,
    required String? details,
    required ShipmentStatus status,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _ShipmentDraftRecord;

  const ShipmentDraftRecord._();

  factory ShipmentDraftRecord.fromJson(Map<String, dynamic> json) {
    return ShipmentDraftRecord(
      id: json['id'] as String,
      shipperId: json['shipper_id'] as String,
      originCommuneId: (json['origin_commune_id'] as num).toInt(),
      destinationCommuneId: (json['destination_commune_id'] as num).toInt(),
      pickupDate: DateTime.parse(json['pickup_date'] as String),
      totalWeightKg: (json['total_weight_kg'] as num).toDouble(),
      totalVolumeM3: (json['total_volume_m3'] as num?)?.toDouble(),
      details: (json['description'] as String?)?.trim(),
      status: ShipmentStatus.fromDatabase(json['status']),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class ShipmentDraftInput with _$ShipmentDraftInput {
  const factory ShipmentDraftInput({
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime pickupDate,
    required double totalWeightKg,
    required double? totalVolumeM3,
    required String? details,
  }) = _ShipmentDraftInput;

  const ShipmentDraftInput._();

  factory ShipmentDraftInput.fromJson(Map<String, dynamic> json) =>
      _$ShipmentDraftInputFromJson(json);
}

enum SearchResultMode {
  exact,
  nearestDate,
  redefineSearch;

  static SearchResultMode fromDatabase(String value) {
    return switch (value) {
      'nearest_date' => SearchResultMode.nearestDate,
      'redefine_search' => SearchResultMode.redefineSearch,
      _ => SearchResultMode.exact,
    };
  }
}

enum SearchSortOption { recommended, topRated, lowestPrice, nearestDeparture }

@freezed
abstract class ShipmentSearchQuery with _$ShipmentSearchQuery {
  const factory ShipmentSearchQuery({
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime requestedDate,
    required double totalWeightKg,
    required double? totalVolumeM3,
    @Default(SearchSortOption.recommended) SearchSortOption sort,
    @Default(0) int offset,
    @Default(20) int limit,
  }) = _ShipmentSearchQuery;

  const ShipmentSearchQuery._();

  factory ShipmentSearchQuery.fromJson(Map<String, dynamic> json) =>
      _$ShipmentSearchQueryFromJson(json);
}

@freezed
abstract class ShipmentSearchResult with _$ShipmentSearchResult {
  const factory ShipmentSearchResult({
    required String sourceId,
    required String sourceType,
    required String carrierId,
    required String carrierName,
    required String vehicleId,
    required int originCommuneId,
    required int destinationCommuneId,
    required DateTime departureAt,
    required DateTime departureDate,
    required double totalCapacityKg,
    required double? totalCapacityVolumeM3,
    required double remainingCapacityKg,
    required double? remainingVolumeM3,
    required double pricePerKgDzd,
    required double estimatedTotalDzd,
    required double ratingAverage,
    required int ratingCount,
    required int dayDistance,
  }) = _ShipmentSearchResult;

  const ShipmentSearchResult._();

  factory ShipmentSearchResult.fromJson(Map<String, dynamic> json) {
    return ShipmentSearchResult(
      sourceId: json['source_id'] as String,
      sourceType: (json['source_type'] as String?)?.trim() ?? 'route',
      carrierId: json['carrier_id'] as String,
      carrierName: (json['carrier_name'] as String?)?.trim() ?? '',
      vehicleId: json['vehicle_id'] as String,
      originCommuneId: (json['origin_commune_id'] as num).toInt(),
      destinationCommuneId: (json['destination_commune_id'] as num).toInt(),
      departureAt: DateTime.parse(json['departure_at'] as String),
      departureDate: DateTime.parse(json['departure_date'] as String),
      totalCapacityKg: (json['total_capacity_kg'] as num).toDouble(),
      totalCapacityVolumeM3:
          (json['total_capacity_volume_m3'] as num?)?.toDouble(),
      remainingCapacityKg: (json['remaining_capacity_kg'] as num).toDouble(),
      remainingVolumeM3: (json['remaining_volume_m3'] as num?)?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      estimatedTotalDzd: (json['estimated_total_dzd'] as num).toDouble(),
      ratingAverage: (json['rating_average'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
      dayDistance: (json['day_distance'] as num?)?.toInt() ?? 0,
    );
  }
}

@freezed
abstract class ShipmentSearchResponse with _$ShipmentSearchResponse {
  const factory ShipmentSearchResponse({
    required SearchResultMode mode,
    required List<ShipmentSearchResult> results,
    required List<DateTime> nearestDates,
    required int? nextOffset,
    required int totalCount,
  }) = _ShipmentSearchResponse;

  const ShipmentSearchResponse._();

  factory ShipmentSearchResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentSearchResponse(
      mode: SearchResultMode.fromDatabase((json['mode'] as String?) ?? 'exact'),
      results: ((json['results'] as List<dynamic>?) ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(ShipmentSearchResult.fromJson)
          .toList(growable: false),
      nearestDates:
          ((json['nearest_dates'] as List<dynamic>?) ?? const <dynamic>[])
              .map((value) => DateTime.parse(value as String))
              .toList(growable: false),
      nextOffset: (json['next_offset'] as num?)?.toInt(),
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
    );
  }
}

@freezed
abstract class BookingReviewSelection with _$BookingReviewSelection {
  const factory BookingReviewSelection({
    required ShipmentDraftRecord shipment,
    required ShipmentSearchResult result,
  }) = _BookingReviewSelection;

  const BookingReviewSelection._();
}
