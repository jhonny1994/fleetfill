import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class MoneySummaryLine {
  const MoneySummaryLine({
    required this.label,
    required this.amount,
    this.emphasis = false,
  });

  final String label;
  final String amount;
  final bool emphasis;
}

class MoneySummaryCard extends StatelessWidget {
  const MoneySummaryCard({required this.title, required this.lines, super.key});

  final String title;
  final List<MoneySummaryLine> lines;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final line in lines) ...[
              Row(
                children: [
                  Expanded(child: Text(line.label)),
                  Text(
                    line.amount,
                    style:
                        (line.emphasis
                                ? textTheme.titleMedium
                                : textTheme.bodyLarge)
                            ?.copyWith(
                              fontWeight: line.emphasis
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                  ),
                ],
              ),
              if (line != lines.last) const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}
