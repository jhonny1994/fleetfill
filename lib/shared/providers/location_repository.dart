import 'package:fleetfill/shared/models/algeria_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return const LocationRepository();
});

class LocationRepository {
  const LocationRepository();

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<AlgeriaCommune>> fetchCommunes() async {
    final response = await _client
        .from('communes')
        .select()
        .order('name', ascending: true);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AlgeriaCommune.fromJson)
        .toList(growable: false);
  }
}
