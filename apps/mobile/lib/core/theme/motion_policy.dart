import 'package:fleetfill/core/theme/design_tokens.dart';
import 'package:flutter/widgets.dart';

class MotionPolicy {
  const MotionPolicy._();

  static Duration duration(BuildContext context, Duration fallback) {
    final mediaQuery = MediaQuery.maybeOf(context);
    final reduceMotion =
        mediaQuery?.disableAnimations == true ||
        mediaQuery?.accessibleNavigation == true;

    return reduceMotion ? AppMotion.instant : fallback;
  }
}
