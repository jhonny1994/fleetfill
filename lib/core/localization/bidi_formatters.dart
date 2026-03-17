import 'package:intl/intl.dart';

class BidiFormatters {
  static const String _leftToRightIsolate = '\u2066';
  static const String _popDirectionalIsolate = '\u2069';

  static String latinIdentifier(String value) {
    return '$_leftToRightIsolate${value.trim()}$_popDirectionalIsolate';
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
