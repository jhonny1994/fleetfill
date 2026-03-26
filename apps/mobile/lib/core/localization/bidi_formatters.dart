import 'package:intl/intl.dart';

class BidiFormatters {
  static const String _leftToRightIsolate = '\u2066';
  static const String _popDirectionalIsolate = '\u2069';
  static const Map<String, String> _localizedDigitMap = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
  };

  static String latinIdentifier(String value) {
    return '$_leftToRightIsolate${westernDigits(value).trim()}$_popDirectionalIsolate';
  }

  static String westernDigits(String value) {
    return value
        .split('')
        .map((char) => _localizedDigitMap[char] ?? char)
        .join();
  }

  static String phoneNumber(String value) => latinIdentifier(value);

  static String trackingId(String value) => latinIdentifier(value);

  static String paymentReference(String value) => latinIdentifier(value);

  static String price(
    num amount, {
    String locale = 'en',
    String currencyCode = 'DZD',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      name: currencyCode,
      symbol: currencyCode,
      decimalDigits: decimalDigits,
    );

    return latinIdentifier(formatter.format(amount));
  }

  static String licensePlate(String value) =>
      latinIdentifier(value.toUpperCase());
}
