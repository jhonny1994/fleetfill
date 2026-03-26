import 'package:fleetfill/core/utils/input_sanitizers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputSanitizers', () {
    test('normalizes Arabic and Latin person names', () {
      expect(
        InputSanitizers.normalizePersonName('  Med   Abderraouf  '),
        'Med Abderraouf',
      );
      expect(
        InputSanitizers.normalizePersonName('  محمد   الأمين  '),
        'محمد الأمين',
      );
      expect(
        InputSanitizers.isValidPersonName("O'Neil Ben-Ali"),
        isTrue,
      );
    });

    test('rejects invalid person names', () {
      expect(InputSanitizers.isValidPersonName('@@@'), isFalse);
      expect(InputSanitizers.isValidPersonName('12345'), isFalse);
    });

    test('normalizes and validates company names', () {
      expect(
        InputSanitizers.normalizeCompanyName('  SARL  Ben   Ali  24  '),
        'SARL Ben Ali 24',
      );
      expect(
        InputSanitizers.isValidCompanyName('SARL Ben Ali 24'),
        isTrue,
      );
    });

    test('normalizes Algerian phone numbers to local format', () {
      expect(
        InputSanitizers.normalizeAlgerianPhoneNumber('+213 550 12 34 56'),
        '0550123456',
      );
      expect(
        InputSanitizers.normalizeAlgerianPhoneNumber('213661234567'),
        '0661234567',
      );
      expect(
        InputSanitizers.normalizeAlgerianPhoneNumber('0550-12-34-56'),
        '0550123456',
      );
    });

    test('rejects invalid Algerian phone numbers', () {
      expect(InputSanitizers.isValidAlgerianPhoneNumber('123'), isFalse);
      expect(
        InputSanitizers.isValidAlgerianPhoneNumber('+33123456789'),
        isFalse,
      );
      expect(
        InputSanitizers.isValidAlgerianPhoneNumber('0150123456'),
        isFalse,
      );
    });
  });
}
