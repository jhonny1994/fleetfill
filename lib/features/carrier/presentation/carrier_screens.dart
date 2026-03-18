import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarrierShellScreen extends StatelessWidget {
  const CarrierShellScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppShellScaffold(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      body: navigationShell,
      destinations: [
        AppShellDestination(
          icon: Icons.home_outlined,
          label: s.carrierHomeNavLabel,
        ),
        AppShellDestination(
          icon: Icons.alt_route_rounded,
          label: s.myRoutesNavLabel,
        ),
        AppShellDestination(
          icon: Icons.local_shipping_outlined,
          label: s.carrierBookingsNavLabel,
        ),
        AppShellDestination(
          icon: Icons.person_outline_rounded,
          label: s.carrierProfileNavLabel,
        ),
      ],
    );
  }
}

class CarrierHomeScreen extends StatelessWidget {
  const CarrierHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.carrierHomeTitle,
      description: s.carrierHomeDescription,
    );
  }
}

class MyRoutesScreen extends StatelessWidget {
  const MyRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.myRoutesTitle,
      description: s.myRoutesDescription,
    );
  }
}

class CarrierBookingsScreen extends StatelessWidget {
  const CarrierBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.carrierBookingsTitle,
      description: s.carrierBookingsDescription,
    );
  }
}
