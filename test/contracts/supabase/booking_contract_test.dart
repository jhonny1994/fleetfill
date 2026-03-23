import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _extractLastSqlBlock(String source, String marker) {
  final start = source.lastIndexOf(marker);
  if (start == -1) {
    return '';
  }

  const sqlBlockTerminator = '\n\$\$;';
  final end = source.indexOf(sqlBlockTerminator, start);
  if (end == -1) {
    return source.substring(start);
  }

  return source.substring(start, end + sqlBlockTerminator.length);
}

void main() {
  group('Supabase booking contracts', () {
    late String bookingRpcFunction;
    late String transitionMigration;

    setUpAll(() {
      final workflowLayer = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      bookingRpcFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.create_booking_from_search_result(',
      );
      transitionMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
    });

    test(
      'creates booking confirmation rpc without premature confirmation side effects',
      () {
        expect(
          bookingRpcFunction.contains(
            'create or replace function public.create_booking_from_search_result',
          ),
          isTrue,
        );
        expect(
          bookingRpcFunction.contains('pickup_date'),
          isTrue,
        );
        expect(
          bookingRpcFunction.contains(
            "raise exception 'Selected departure is outside the shipment pickup date'",
          ),
          isTrue,
        );
        expect(
          bookingRpcFunction.contains('insert into public.notifications'),
          isFalse,
        );
        expect(
          bookingRpcFunction.contains('insert into public.email_outbox_jobs'),
          isFalse,
        );
        expect(
          bookingRpcFunction.contains(
            'grant execute on function public.create_booking_from_search_result',
          ),
          isFalse,
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
