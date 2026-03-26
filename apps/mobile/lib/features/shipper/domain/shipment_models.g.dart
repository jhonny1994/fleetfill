// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipmentDraftInput _$ShipmentDraftInputFromJson(Map<String, dynamic> json) =>
    _ShipmentDraftInput(
      originCommuneId: (json['originCommuneId'] as num).toInt(),
      destinationCommuneId: (json['destinationCommuneId'] as num).toInt(),
      totalWeightKg: (json['totalWeightKg'] as num).toDouble(),
      totalVolumeM3: (json['totalVolumeM3'] as num?)?.toDouble(),
      details: json['details'] as String?,
    );

Map<String, dynamic> _$ShipmentDraftInputToJson(_ShipmentDraftInput instance) =>
    <String, dynamic>{
      'originCommuneId': instance.originCommuneId,
      'destinationCommuneId': instance.destinationCommuneId,
      'totalWeightKg': instance.totalWeightKg,
      'totalVolumeM3': instance.totalVolumeM3,
      'details': instance.details,
    };

_ShipmentSearchQuery _$ShipmentSearchQueryFromJson(Map<String, dynamic> json) =>
    _ShipmentSearchQuery(
      originCommuneId: (json['originCommuneId'] as num).toInt(),
      destinationCommuneId: (json['destinationCommuneId'] as num).toInt(),
      requestedDate: DateTime.parse(json['requestedDate'] as String),
      totalWeightKg: (json['totalWeightKg'] as num).toDouble(),
      totalVolumeM3: (json['totalVolumeM3'] as num?)?.toDouble(),
      sort:
          $enumDecodeNullable(_$SearchSortOptionEnumMap, json['sort']) ??
          SearchSortOption.recommended,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$ShipmentSearchQueryToJson(
  _ShipmentSearchQuery instance,
) => <String, dynamic>{
  'originCommuneId': instance.originCommuneId,
  'destinationCommuneId': instance.destinationCommuneId,
  'requestedDate': instance.requestedDate.toIso8601String(),
  'totalWeightKg': instance.totalWeightKg,
  'totalVolumeM3': instance.totalVolumeM3,
  'sort': _$SearchSortOptionEnumMap[instance.sort]!,
  'offset': instance.offset,
  'limit': instance.limit,
};

const _$SearchSortOptionEnumMap = {
  SearchSortOption.recommended: 'recommended',
  SearchSortOption.topRated: 'topRated',
  SearchSortOption.lowestPrice: 'lowestPrice',
  SearchSortOption.nearestDeparture: 'nearestDeparture',
};
