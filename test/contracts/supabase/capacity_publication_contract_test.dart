import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase capacity publication contracts', () {
    late String migrationBundle;

    setUpAll(() {
      migrationBundle = [
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

    test('keeps route publication constraints and trusted write posture', () {
      expect(migrationBundle.contains('alter table public.routes'), isTrue);
      expect(migrationBundle.contains('weekdays_are_valid'), isTrue);
      expect(migrationBundle.contains('route_revisions_append_only'), isTrue);
      expect(migrationBundle.contains('update_route_with_revision'), isTrue);
      expect(
        migrationBundle.contains(
          "set_config('app.trusted_operation', 'true', true)",
        ),
        isTrue,
      );
    });

    test('keeps carrier verification gates enforced server-side', () {
      expect(
        migrationBundle.contains(
          'Only active verified carriers may publish capacity',
        ),
        isTrue,
      );
      expect(
        migrationBundle.contains(
          'A verified vehicle is required for capacity publication',
        ),
        isTrue,
      );
    });
  });
}
