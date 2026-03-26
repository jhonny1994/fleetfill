import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.trailing,
    this.showTitle = true,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showTitle)
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                if (subtitle != null) ...[
                  SizedBox(height: showTitle ? AppSpacing.xs : 0),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
