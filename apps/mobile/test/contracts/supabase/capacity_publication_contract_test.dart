import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase capacity publication contracts', () {
    late String migrationBundle;

    setUpAll(() {
      migrationBundle = [
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
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
