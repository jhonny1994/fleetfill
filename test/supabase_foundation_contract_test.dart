import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase foundation contracts', () {
    late String schemaMigration;
    late String securityMigration;

    setUpAll(() {
      schemaMigration = File(
        'supabase/migrations/20260317143000_phase_2_schema_foundation.sql',
      ).readAsStringSync();
      securityMigration = File(
        'supabase/migrations/20260317150000_phase_2_security_and_runtime_foundation.sql',
      ).readAsStringSync();
    });

    test('keeps booking capacity exclusivity constraint', () {
      expect(
        schemaMigration.contains('bookings_exactly_one_capacity_source'),
        isTrue,
      );
    });

    test('keeps one active payout account index per carrier', () {
      expect(
        schemaMigration.contains('payout_accounts_one_active_per_carrier_idx'),
        isTrue,
      );
    });

    test('keeps upload and abuse control tables', () {
      expect(
        securityMigration.contains(
          'create table if not exists public.upload_sessions',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'create table if not exists public.security_rate_limits',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'create table if not exists public.security_abuse_events',
        ),
        isTrue,
      );
    });

    test('keeps RLS enabled and baseline location read policies', () {
      expect(
        securityMigration.contains(
          'alter table public.wilayas enable row level security;',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains('create policy wilayas_read_authenticated'),
        isTrue,
      );
      expect(
        securityMigration.contains('create policy communes_read_authenticated'),
        isTrue,
      );
    });
  });
}
