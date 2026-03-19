import 'dart:io';

import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 6 migration contracts', () {
    late String constraintsMigration;
    late String searchMigration;

    setUpAll(() {
      constraintsMigration = File(
        'supabase/migrations/20260320120000_add_shipment_domain_constraints.sql',
      ).readAsStringSync();
      searchMigration = File(
        'supabase/migrations/20260320120100_create_exact_lane_search_rpc.sql',
      ).readAsStringSync();
    });

    test('adds shipment, item, booking, and departure constraints', () {
      expect(constraintsMigration.contains('shipments_positive_weight_check'), isTrue);
      expect(constraintsMigration.contains('shipments_pickup_window_order_check'), isTrue);
      expect(constraintsMigration.contains('shipment_items_positive_quantity_check'), isTrue);
      expect(constraintsMigration.contains('bookings_route_date_required_check'), isTrue);
      expect(
        constraintsMigration.contains('route_departure_instances_route_date_unique_idx'),
        isTrue,
      );
    });

    test('keeps one shipment to one booking contract in schema', () {
      final bookingSchemaMigration = File(
        'supabase/migrations/20260317143200_create_marketplace_core_tables.sql',
      ).readAsStringSync();

      expect(bookingSchemaMigration.contains('shipment_id uuid not null unique references public.shipments'), isTrue);
      expect(bookingSchemaMigration.contains('bookings_exactly_one_capacity_source'), isTrue);
    });

    test('creates exact lane search RPC with nearest-date fallback', () {
      expect(searchMigration.contains('create or replace function public.search_exact_lane_capacity'), isTrue);
      expect(searchMigration.contains("v_mode := 'nearest_date';"), isTrue);
      expect(searchMigration.contains("v_mode := 'redefine_search';"), isTrue);
      expect(searchMigration.contains('grant execute on function public.search_exact_lane_capacity'), isTrue);
    });
  });

  group('Shipment search models', () {
    test('maps response mode and nearest dates', () {
      final response = ShipmentSearchResponse.fromJson({
        'mode': 'nearest_date',
        'results': const <dynamic>[],
        'nearest_dates': ['2026-03-21', '2026-03-22'],
        'next_offset': 20,
        'total_count': 2,
      });

      expect(response.mode, SearchResultMode.nearestDate);
      expect(response.nearestDates, hasLength(2));
      expect(response.nextOffset, 20);
    });
  });
}
