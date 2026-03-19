import 'dart:io';

import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 7 migration contracts', () {
    late String bookingRpcMigration;
    late String transitionMigration;

    setUpAll(() {
      bookingRpcMigration = File(
        'supabase/migrations/20260320120200_create_booking_confirmation_rpc.sql',
      ).readAsStringSync();
      transitionMigration = File(
        'supabase/migrations/20260320120300_enforce_booking_status_transitions.sql',
      ).readAsStringSync();
    });

    test('creates booking confirmation rpc with pricing and side effects', () {
      expect(
        bookingRpcMigration.contains('create or replace function public.create_booking_from_search_result'),
        isTrue,
      );
      expect(bookingRpcMigration.contains('insert into public.notifications'), isTrue);
      expect(bookingRpcMigration.contains('insert into public.email_outbox_jobs'), isTrue);
      expect(bookingRpcMigration.contains('insert into public.tracking_events'), isTrue);
      expect(bookingRpcMigration.contains('grant execute on function public.create_booking_from_search_result'), isTrue);
    });

    test('enforces booking and payment status transitions', () {
      expect(transitionMigration.contains('booking_status_transition_allowed'), isTrue);
      expect(transitionMigration.contains('payment_status_transition_allowed'), isTrue);
      expect(transitionMigration.contains('bookings_state_transition_guard'), isTrue);
    });
  });

  group('Booking shared models', () {
    test('maps booking and payment statuses from database values', () {
      expect(BookingStatus.fromDatabase('pending_payment'), BookingStatus.pendingPayment);
      expect(PaymentStatus.fromDatabase('released_to_carrier'), PaymentStatus.releasedToCarrier);
    });
  });
}
