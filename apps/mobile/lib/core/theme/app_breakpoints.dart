import 'package:flutter/widgets.dart';

enum AppLayoutSize {
  compact,
  medium,
  expanded,
}

abstract final class AppBreakpoints {
  static const double medium = 720;
  static const double expanded = 1100;
  static const double maxContentWidth = 1040;

  static AppLayoutSize resolve(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= expanded) {
      return AppLayoutSize.expanded;
    }

    if (width >= medium) {
      return AppLayoutSize.medium;
    }

    return AppLayoutSize.compact;
  }
}
