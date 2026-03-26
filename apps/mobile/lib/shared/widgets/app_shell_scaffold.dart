import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';

class AppShellDestination {
  const AppShellDestination({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class AppShellScaffold extends StatelessWidget {
  const AppShellScaffold({
    required this.selectedIndex,
    required this.destinations,
    required this.body,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final List<AppShellDestination> destinations;
  final Widget body;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final layout = AppBreakpoints.resolve(context);

    if (layout == AppLayoutSize.compact) {
      return Scaffold(
        body: SafeArea(child: body),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final destination in destinations)
              NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.label,
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final destination in destinations)
                  NavigationRailDestination(
                    icon: Icon(destination.icon),
                    label: Text(destination.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
