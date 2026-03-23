// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algeria_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlgeriaCommune _$AlgeriaCommuneFromJson(Map<String, dynamic> json) =>
    _AlgeriaCommune(
      id: (json['id'] as num).toInt(),
      wilayaId: (json['wilaya_id'] as num).toInt(),
      nameFr: _readCommuneLatinName(json, 'name_fr') as String,
      nameAr: json['name_ar'] as String,
    );

Map<String, dynamic> _$AlgeriaCommuneToJson(_AlgeriaCommune instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wilaya_id': instance.wilayaId,
      'name_fr': instance.nameFr,
      'name_ar': instance.nameAr,
    };

_AlgeriaWilaya _$AlgeriaWilayaFromJson(Map<String, dynamic> json) =>
    _AlgeriaWilaya(
      id: (json['id'] as num).toInt(),
      nameFr: json['nameFr'] as String,
      nameAr: json['name_ar'] as String,
    );

Map<String, dynamic> _$AlgeriaWilayaToJson(_AlgeriaWilaya instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameFr': instance.nameFr,
      'name_ar': instance.nameAr,
    };

_AlgeriaLocationDirectory _$AlgeriaLocationDirectoryFromJson(
  Map<String, dynamic> json,
) => _AlgeriaLocationDirectory(
  wilayas: (json['wilayas'] as List<dynamic>)
      .map((e) => AlgeriaWilaya.fromJson(e as Map<String, dynamic>))
      .toList(),
  communes: (json['communes'] as List<dynamic>)
      .map((e) => AlgeriaCommune.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AlgeriaLocationDirectoryToJson(
  _AlgeriaLocationDirectory instance,
) => <String, dynamic>{
  'wilayas': instance.wilayas,
  'communes': instance.communes,
};
