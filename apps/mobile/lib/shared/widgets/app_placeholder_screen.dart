import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppPlaceholderScreen extends StatelessWidget {
  const AppPlaceholderScreen({
    required this.title,
    required this.description,
    super.key,
    this.showSummary = true,
  });

  final String title;
  final String description;
  final bool showSummary;

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: title,
      child: ListView(
        children: [
          AppStateMessage(
            icon: Icons.upcoming_outlined,
            title: title,
            message: description,
            action: showSummary
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppStatusChip(
                        label: S.of(context).sharedScaffoldPreviewTitle,
                        tone: AppStatusTone.info,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        S.of(context).sharedScaffoldPreviewMessage,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
