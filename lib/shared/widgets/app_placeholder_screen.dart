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
          AppSectionHeader(title: title, subtitle: description),
          const SizedBox(height: AppSpacing.md),
          const AppOfflineBanner(),
          const SizedBox(height: AppSpacing.md),
          if (showSummary) ...[
            MoneySummaryCard(
              title: S.of(context).moneySummaryTitle,
              lines: [
                MoneySummaryLine(
                  label: S.of(context).sampleBasePriceLabel,
                  amount: S.of(context).sampleBasePriceAmount,
                ),
                MoneySummaryLine(
                  label: S.of(context).samplePlatformFeeLabel,
                  amount: S.of(context).samplePlatformFeeAmount,
                ),
                MoneySummaryLine(
                  label: S.of(context).sampleTotalLabel,
                  amount: S.of(context).sampleTotalAmount,
                  emphasis: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppStatusChip(
                label: S.of(context).statusReadyLabel,
                tone: AppStatusTone.success,
              ),
              AppStatusChip(
                label: S.of(context).statusNeedsReviewLabel,
                tone: AppStatusTone.warning,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppListCard(
            title: S.of(context).sharedScaffoldPreviewTitle,
            subtitle: S.of(context).sharedScaffoldPreviewMessage,
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
