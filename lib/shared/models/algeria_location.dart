import 'package:flutter/widgets.dart';

class AlgeriaCommune {
  const AlgeriaCommune({
    required this.id,
    required this.wilayaId,
    required this.nameFr,
    required this.nameAr,
  });

  factory AlgeriaCommune.fromJson(Map<String, dynamic> json) {
    return AlgeriaCommune(
      id: json['id'] as int,
      wilayaId: json['wilaya_id'] as int,
      nameFr:
          (json['name_fr'] as String?)?.trim() ??
          (json['name'] as String?)?.trim() ??
          '',
      nameAr: (json['name_ar'] as String?)?.trim() ?? '',
    );
  }

  final int id;
  final int wilayaId;
  final String nameFr;
  final String nameAr;

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
        nameAr.toLowerCase().contains(normalized);
  }
}

class AlgeriaWilaya {
  const AlgeriaWilaya({
    required this.id,
    required this.nameFr,
    required this.nameAr,
  });

  factory AlgeriaWilaya.fromJson(Map<String, dynamic> json) {
    return AlgeriaWilaya(
      id: json['id'] as int,
      nameFr: (json['name'] as String?)?.trim() ?? '',
      nameAr: (json['name_ar'] as String?)?.trim() ?? '',
    );
  }

  final int id;
  final String nameFr;
  final String nameAr;

  String displayName(Locale locale) {
    if (locale.languageCode == 'ar' && nameAr.isNotEmpty) {
      return nameAr;
    }
    return nameFr;
  }
}

class AlgeriaLocationDirectory {
  const AlgeriaLocationDirectory({
    required this.wilayas,
    required this.communes,
  });

  final List<AlgeriaWilaya> wilayas;
  final List<AlgeriaCommune> communes;
}
