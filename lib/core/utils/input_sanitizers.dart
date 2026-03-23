class InputSanitizers {
  const InputSanitizers._();

  static String? normalizePersonName(String? value) {
    final collapsed = _collapseWhitespace(value);
    if (collapsed == null) {
      return null;
    }

    final sanitized = collapsed.runes
        .where(_isAllowedPersonNameRune)
        .map(String.fromCharCode)
        .join();
    final normalized = _collapseWhitespace(sanitized);
    return normalized;
  }

  static String? normalizeCompanyName(String? value) {
    final collapsed = _collapseWhitespace(value);
    if (collapsed == null) {
      return null;
    }

    final sanitized = collapsed.runes
        .where(_isAllowedCompanyRune)
        .map(String.fromCharCode)
        .join();
    final normalized = _collapseWhitespace(sanitized);
    return normalized;
  }

  static String? normalizeAlgerianPhoneNumber(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) {
      return null;
    }

    var digitsOnly = raw.replaceAll(RegExp(r'[^\d+]'), '');
    if (digitsOnly.startsWith('+')) {
      digitsOnly = '+${digitsOnly.substring(1).replaceAll('+', '')}';
    } else {
      digitsOnly = digitsOnly.replaceAll('+', '');
    }

    if (digitsOnly.startsWith('+213')) {
      digitsOnly = '0${digitsOnly.substring(4)}';
    } else if (digitsOnly.startsWith('213')) {
      digitsOnly = '0${digitsOnly.substring(3)}';
    }

    if (digitsOnly.length != 10 ||
        !RegExp(r'^0[2-7]\d{8}$').hasMatch(digitsOnly)) {
      return null;
    }

    return digitsOnly;
  }

  static bool isValidPersonName(String? value) {
    final normalized = normalizePersonName(value);
    if (normalized == null) {
      return false;
    }

    return normalized.runes.any(_isLetterRune);
  }

  static bool isValidCompanyName(String? value) {
    final normalized = normalizeCompanyName(value);
    if (normalized == null) {
      return false;
    }

    return normalized.runes.any(
      (rune) => _isLetterRune(rune) || _isAsciiDigitRune(rune),
    );
  }

  static bool isValidAlgerianPhoneNumber(String? value) {
    return normalizeAlgerianPhoneNumber(value) != null;
  }

  static String? _collapseWhitespace(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    return trimmed.replaceAll(RegExp(r'\s+'), ' ');
  }

  static bool _isAllowedPersonNameRune(int rune) {
    return _isLetterRune(rune) || rune == 0x20 || rune == 0x2D || rune == 0x27;
  }

  static bool _isAllowedCompanyRune(int rune) {
    return _isLetterRune(rune) ||
        _isAsciiDigitRune(rune) ||
        rune == 0x20 ||
        rune == 0x2D ||
        rune == 0x27 ||
        rune == 0x26 ||
        rune == 0x2E ||
        rune == 0x2F;
  }

  static bool _isAsciiDigitRune(int rune) => rune >= 0x30 && rune <= 0x39;

  static bool _isLetterRune(int rune) {
    return (rune >= 0x41 && rune <= 0x5A) ||
        (rune >= 0x61 && rune <= 0x7A) ||
        (rune >= 0x00C0 && rune <= 0x024F) ||
        (rune >= 0x1E00 && rune <= 0x1EFF) ||
        (rune >= 0x0600 && rune <= 0x06FF) ||
        (rune >= 0x0750 && rune <= 0x077F) ||
        (rune >= 0x08A0 && rune <= 0x08FF) ||
        (rune >= 0xFB50 && rune <= 0xFDFF) ||
        (rune >= 0xFE70 && rune <= 0xFEFF);
  }
}
