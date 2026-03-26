import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppFeedback {
  const AppFeedback._();

  static Future<T?> showAdaptiveSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool useSafeArea = true,
  }) {
    final layout = AppBreakpoints.resolve(context);

    if (layout == AppLayoutSize.compact) {
      return showModalBottomSheet<T>(
        context: context,
        useSafeArea: useSafeArea,
        isScrollControlled: true,
        builder: builder,
      );
    }

    return showDialog<T>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: builder(context),
        ),
      ),
    );
  }

  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelLabel ?? S.of(context).cancelLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmLabel ?? S.of(context).confirmLabel),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
