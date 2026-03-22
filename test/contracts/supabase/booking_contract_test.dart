import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase booking contracts', () {
    late String bookingRpcMigration;
    late String transitionMigration;

    setUpAll(() {
      bookingRpcMigration = File(
        'supabase/migrations/20260322123000_simplify_shipment_domain.sql',
      ).readAsStringSync();
      transitionMigration = File(
        'supabase/migrations/20260320120300_enforce_booking_status_transitions.sql',
      ).readAsStringSync();
    });

    test(
      'creates booking confirmation rpc with notification and outbox side effects',
      () {
        expect(
          bookingRpcMigration.contains(
            'create or replace function public.create_booking_from_search_result',
          ),
          isTrue,
        );
        expect(
          bookingRpcMigration.contains('insert into public.notifications'),
          isTrue,
        );
        expect(
          bookingRpcMigration.contains('insert into public.email_outbox_jobs'),
          isTrue,
        );
        expect(bookingRpcMigration.contains("'booking_confirmed'"), isTrue);
        expect(
          bookingRpcMigration.contains(
            'grant execute on function public.create_booking_from_search_result',
          ),
          isTrue,
        );
      },
    );

    test('enforces booking and payment status transitions', () {
      expect(
        transitionMigration.contains('booking_status_transition_allowed'),
        isTrue,
      );
      expect(
        transitionMigration.contains('payment_status_transition_allowed'),
        isTrue,
      );
      expect(
        transitionMigration.contains('bookings_state_transition_guard'),
        isTrue,
      );
    });
  });
}
