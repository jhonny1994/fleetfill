import 'package:fleetfill/shared/models/algeria_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return const LocationRepository();
});

class LocationRepository {
  const LocationRepository();

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<AlgeriaWilaya>> fetchWilayas() async {
    final response = await _client.from('wilayas').select().order('name');

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AlgeriaWilaya.fromJson)
        .toList(growable: false);
  }

  Future<List<AlgeriaCommune>> fetchCommunes() async {
    final response = await _client
        .from('communes')
        .select()
        .order('wilaya_id', ascending: true)
        .order('name', ascending: true);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AlgeriaCommune.fromJson)
        .toList(growable: false);
  }

  Future<AlgeriaLocationDirectory> fetchLocationDirectory() async {
    final results = await Future.wait([
      fetchWilayas(),
      fetchCommunes(),
    ]);

    return AlgeriaLocationDirectory(
      wilayas: results[0].cast<AlgeriaWilaya>(),
      communes: results[1].cast<AlgeriaCommune>(),
    );
  }
}
