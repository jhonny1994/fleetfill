import 'dart:io';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Capacity publication models', () {
    test('uses Arabic commune name when locale is Arabic', () {
      final commune = AlgeriaCommune.fromJson({
        'id': 1601,
        'wilaya_id': 16,
        'name': 'Alger Centre',
        'name_ar': 'الجزائر الوسطى',
      });

      expect(commune.displayName(const Locale('ar')), 'الجزائر الوسطى');
      expect(commune.displayName(const Locale('fr')), 'Alger Centre');
      expect(commune.matchesQuery('1601'), isTrue);
      expect(commune.matchesQuery('centre'), isTrue);
    });

    test('computes utilization ratio from published and reserved capacity', () {
      const summary = CapacityPublicationSummary(
        activeRecurringRouteCount: 2,
        activeOneOffTripCount: 1,
        upcomingDepartureCount: 5,
        publishedCapacityKg: 1000,
        reservedCapacityKg: 250,
      );

      expect(summary.utilizationRatio, 0.25);
    });
  });

  group('Phase 5 migration contracts', () {
    late String phase5Migration;

    setUpAll(() {
      phase5Migration = [
        'supabase/migrations/20260319120000_add_capacity_publication_constraints.sql',
        'supabase/migrations/20260319120100_backfill_route_revision_lane_history.sql',
        'supabase/migrations/20260319120200_create_capacity_publication_access_helpers.sql',
        'supabase/migrations/20260319120300_create_capacity_publication_integrity_guards.sql',
        'supabase/migrations/20260319120400_create_capacity_publication_routes_rpc.sql',
        'supabase/migrations/20260319120500_create_capacity_publication_oneoff_trip_rpc.sql',
        'supabase/migrations/20260319120600_enable_capacity_publication_policies.sql',
        'supabase/migrations/20260319120700_harden_verification_helper_access.sql',
      ].map((path) => File(path).readAsStringSync()).join('\n');
    });

    test('adds recurring route volume support and validation helpers', () {
      expect(phase5Migration.contains('alter table public.routes'), isTrue);
      expect(
        phase5Migration.contains('add column if not exists total_capacity_volume_m3 numeric;'),
        isTrue,
      );
      expect(phase5Migration.contains('create or replace function public.weekdays_are_valid'), isTrue);
      expect(phase5Migration.contains('routes_valid_weekdays_check'), isTrue);
    });

    test('protects route revisions as append-only history', () {
      expect(phase5Migration.contains('Route revision history is append-only'), isTrue);
      expect(phase5Migration.contains('route_revisions_append_only'), isTrue);
    });

    test('requires trusted route writes through publication functions', () {
      expect(phase5Migration.contains('Critical route changes must use update_route_with_revision'), isTrue);
      expect(phase5Migration.contains('create or replace function public.create_carrier_route'), isTrue);
      expect(phase5Migration.contains('create or replace function public.update_route_with_revision'), isTrue);
      expect(phase5Migration.contains('create or replace function public.create_oneoff_trip'), isTrue);
      expect(phase5Migration.contains('create or replace function public.update_oneoff_trip'), isTrue);
      expect(phase5Migration.contains("set_config('app.trusted_operation', 'true', true)"), isTrue);
    });

    test('hardens verification helper grants and carrier publication gates', () {
      expect(
        phase5Migration.contains(
          'Verification document access requires privileged access',
        ),
        isTrue,
      );
      expect(
        phase5Migration.contains(
          'grant execute on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;',
        ),
        isTrue,
      );
      expect(phase5Migration.contains('Only active verified carriers may publish capacity'), isTrue);
      expect(phase5Migration.contains('A verified vehicle is required for capacity publication'), isTrue);
    });
  });

  group('Phase 5 route helpers', () {
    test('builds centralized carrier route and trip paths', () {
      expect(AppRoutePath.carrierRouteCreate(), '/carrier/routes/new-route');
      expect(AppRoutePath.carrierRouteDetail('route-1'), '/carrier/routes/route/route-1');
      expect(AppRoutePath.carrierOneOffTripCreate(), '/carrier/routes/new-trip');
      expect(AppRoutePath.carrierOneOffTripDetail('trip-1'), '/carrier/routes/trip/trip-1');
    });
  });
}
