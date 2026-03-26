import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
}

abstract final class AppRadius {
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;
}

abstract final class AppElevation {
  static const double low = 1;
  static const double medium = 3;
  static const double high = 6;
}

abstract final class AppBorders {
  static const double thin = 1;
  static const double regular = 1.5;
}

abstract final class AppIconSize {
  static const double sm = 18;
  static const double md = 22;
  static const double lg = 28;
}

abstract final class AppTypography {
  static const String fontFamily = 'Roboto';
  static const double display = 34;
  static const double title = 20;
  static const double body = 16;
  static const double label = 14;
}

abstract final class AppMotion {
  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 140);
  static const Duration medium = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 320);
  static const Curve emphasized = Curves.easeOutCubic;
}

class AppStatusPalette extends ThemeExtension<AppStatusPalette> {
  const AppStatusPalette({
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
    required this.neutral,
  });

  final Color info;
  final Color success;
  final Color warning;
  final Color danger;
  final Color neutral;

  @override
  ThemeExtension<AppStatusPalette> copyWith({
    Color? info,
    Color? success,
    Color? warning,
    Color? danger,
    Color? neutral,
  }) {
    return AppStatusPalette(
      info: info ?? this.info,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ThemeExtension<AppStatusPalette> lerp(
    covariant ThemeExtension<AppStatusPalette>? other,
    double t,
  ) {
    if (other is! AppStatusPalette) {
      return this;
    }

    return AppStatusPalette(
      info: Color.lerp(info, other.info, t) ?? info,
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      neutral: Color.lerp(neutral, other.neutral, t) ?? neutral,
    );
  }
}
