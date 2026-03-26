import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

enum AppStatusTone {
  info,
  success,
  warning,
  danger,
  neutral,
}

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.label,
    super.key,
    this.tone = AppStatusTone.neutral,
  });

  final String label;
  final AppStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppStatusPalette>()!;
    final color = switch (tone) {
      AppStatusTone.info => palette.info,
      AppStatusTone.success => palette.success,
      AppStatusTone.warning => palette.warning,
      AppStatusTone.danger => palette.danger,
      AppStatusTone.neutral => palette.neutral,
    };

    return Semantics(
      container: true,
      label: label,
      child: Chip(
        label: Text(label),
        backgroundColor: color.withValues(alpha: 0.12),
        side: BorderSide(color: color.withValues(alpha: 0.24)),
        labelStyle: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: color),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
