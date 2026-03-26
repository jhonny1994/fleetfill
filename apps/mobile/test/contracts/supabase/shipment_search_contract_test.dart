import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase shipment search contracts', () {
    late String constraintsMigration;
    late String searchMigration;
    late String bookingSchemaMigration;
    setUpAll(() {
      constraintsMigration = File(
        '../../backend/supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      searchMigration = File(
        '../../backend/supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      bookingSchemaMigration = File(
        '../../backend/supabase/migrations/20260317010000_create_foundation_layer.sql',
      ).readAsStringSync();
    });

    test('keeps shipment and departure constraints in schema', () {
      expect(
        constraintsMigration.contains('shipments_positive_weight_check'),
        isTrue,
      );
      expect(bookingSchemaMigration.contains('pickup_window_start'), isFalse);
      expect(bookingSchemaMigration.contains('pickup_window_end'), isFalse);
      expect(bookingSchemaMigration.contains('shipment_items'), isFalse);
      expect(
        constraintsMigration.contains('shipments_lane_lookup_idx'),
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
