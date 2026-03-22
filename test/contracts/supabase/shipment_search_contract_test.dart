import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase shipment search contracts', () {
    late String constraintsMigration;
    late String searchMigration;
    late String bookingSchemaMigration;
    late String simplificationMigration;

    setUpAll(() {
      constraintsMigration = File(
        'supabase/migrations/20260320120000_add_shipment_domain_constraints.sql',
      ).readAsStringSync();
      searchMigration = File(
        'supabase/migrations/20260320120100_create_exact_lane_search_rpc.sql',
      ).readAsStringSync();
      bookingSchemaMigration = File(
        'supabase/migrations/20260317143200_create_marketplace_core_tables.sql',
      ).readAsStringSync();
      simplificationMigration = File(
        'supabase/migrations/20260322123000_simplify_shipment_domain.sql',
      ).readAsStringSync();
    });

    test('keeps shipment and departure constraints in schema', () {
      expect(
        constraintsMigration.contains('shipments_positive_weight_check'),
        isTrue,
      );
      expect(
        simplificationMigration.contains(
          'drop column if exists pickup_window_end',
        ),
        isTrue,
      );
      expect(
        simplificationMigration.contains(
          'drop table if exists public.shipment_items cascade',
        ),
        isTrue,
      );
      expect(
        simplificationMigration.contains('shipments_lane_pickup_date_idx'),
        isTrue,
      );
      expect(
        bookingSchemaMigration.contains('shipment_id uuid not null unique'),
        isTrue,
      );
    });

    test('creates exact lane search rpc with nearest-date fallback', () {
      expect(searchMigration.contains('search_exact_lane_capacity'), isTrue);
      expect(searchMigration.contains("v_mode := 'nearest_date';"), isTrue);
      expect(searchMigration.contains("v_mode := 'redefine_search';"), isTrue);
    });
  });
}
