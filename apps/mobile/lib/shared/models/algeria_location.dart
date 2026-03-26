import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'algeria_location.freezed.dart';
part 'algeria_location.g.dart';

@freezed
abstract class AlgeriaCommune with _$AlgeriaCommune {
  const factory AlgeriaCommune({
    required int id,
    @JsonKey(name: 'wilaya_id') required int wilayaId,
    @JsonKey(
      name: 'name_fr',
      readValue: _readCommuneLatinName,
    )
    required String nameFr,
    @JsonKey(name: 'name_ar') required String nameAr,
  }) = _AlgeriaCommune;

  const AlgeriaCommune._();

  factory AlgeriaCommune.fromJson(Map<String, dynamic> json) =>
      _$AlgeriaCommuneFromJson(_normalizeCommuneJson(json));

  String displayName(Locale locale) {
    if (locale.languageCode == 'ar' && nameAr.isNotEmpty) {
      return nameAr;
    }
    return nameFr;
  }

  bool matchesQuery(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return true;
    }

    return nameFr.toLowerCase().contains(normalized) ||
        nameAr.toLowerCase().contains(normalized) ||
        id.toString().contains(normalized);
  }
}

@freezed
abstract class AlgeriaWilaya with _$AlgeriaWilaya {
  const factory AlgeriaWilaya({
    required int id,
    required String nameFr,
    @JsonKey(name: 'name_ar') required String nameAr,
  }) = _AlgeriaWilaya;

  const AlgeriaWilaya._();

  factory AlgeriaWilaya.fromJson(Map<String, dynamic> json) =>
      _$AlgeriaWilayaFromJson(_normalizeWilayaJson(json));

  String displayName(Locale locale) {
    if (locale.languageCode == 'ar' && nameAr.isNotEmpty) {
      return nameAr;
    }
    return nameFr;
  }
}

@freezed
abstract class AlgeriaLocationDirectory with _$AlgeriaLocationDirectory {
  const factory AlgeriaLocationDirectory({
    required List<AlgeriaWilaya> wilayas,
    required List<AlgeriaCommune> communes,
  }) = _AlgeriaLocationDirectory;

  const AlgeriaLocationDirectory._();

  factory AlgeriaLocationDirectory.fromJson(Map<String, dynamic> json) =>
      _$AlgeriaLocationDirectoryFromJson(json);
}

Object? _readCommuneLatinName(Map<dynamic, dynamic> json, String key) {
  return json[key] ?? json['name'];
}

Map<String, dynamic> _normalizeCommuneJson(Map<String, dynamic> json) {
  return {
    ...json,
    'name_fr':
        (json['name_fr'] as String?)?.trim() ??
        (json['name'] as String?)?.trim() ??
        '',
    'name_ar': (json['name_ar'] as String?)?.trim() ?? '',
  };
}

Map<String, dynamic> _normalizeWilayaJson(Map<String, dynamic> json) {
  return {
    ...json,
    'nameFr': (json['name'] as String?)?.trim() ?? '',
    'name_ar': (json['name_ar'] as String?)?.trim() ?? '',
  };
}
