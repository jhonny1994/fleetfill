import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppListCard extends StatelessWidget {
  const AppListCard({
    required this.title,
    super.key,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final semanticsLabel = subtitle == null ? title : '$title. $subtitle';

    return Semantics(
      container: true,
      button: onTap != null,
      label: semanticsLabel,
      child: Card(
        child: ListTile(
          minVerticalPadding: AppSpacing.sm,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          onTap: onTap,
          leading: leading,
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: subtitle == null
              ? null
              : Text(subtitle!, maxLines: 3, overflow: TextOverflow.ellipsis),
          trailing: trailing,
        ),
      ),
    );
  }
}
