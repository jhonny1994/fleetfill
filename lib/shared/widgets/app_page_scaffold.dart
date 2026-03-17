import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    required this.title,
    required this.child,
    super.key,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final layout = AppBreakpoints.resolve(context);
    final horizontalPadding = switch (layout) {
      AppLayoutSize.compact => AppSpacing.md,
      AppLayoutSize.medium => AppSpacing.lg,
      AppLayoutSize.expanded => AppSpacing.xl,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
