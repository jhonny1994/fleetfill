import 'package:fleetfill/core/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('isEmailNotConfirmedAuthError', () {
    test('matches the Supabase email_not_confirmed code', () {
      expect(
        isEmailNotConfirmedAuthError(
          'Email delivery pending.',
          code: 'email_not_confirmed',
        ),
        isTrue,
      );
    });

    test('matches the fallback message when no code is present', () {
      expect(
        isEmailNotConfirmedAuthError('Email not confirmed'),
        isTrue,
      );
    });

    test('does not match unrelated auth errors', () {
      expect(
        isEmailNotConfirmedAuthError(
          'Invalid login credentials',
          code: 'invalid_credentials',
        ),
        isFalse,
      );
    });
  });

  group('isEmailNotConfirmedException', () {
    test('recognizes matching AuthException instances', () {
      expect(
        isEmailNotConfirmedException(
          const AuthException(
            'Email not confirmed',
            code: 'email_not_confirmed',
          ),
        ),
        isTrue,
      );
    });
  });
}
