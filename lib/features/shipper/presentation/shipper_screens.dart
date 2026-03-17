import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShipperShellScreen extends StatelessWidget {
  const ShipperShellScreen({required this.navigationShell, super.key});

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
        AppShellDestination(icon: Icons.home_outlined, label: s.shipperHomeNavLabel),
        AppShellDestination(
          icon: Icons.inventory_2_outlined,
          label: s.myShipmentsNavLabel,
        ),
        AppShellDestination(icon: Icons.search_rounded, label: s.searchTripsNavLabel),
        AppShellDestination(
          icon: Icons.person_outline_rounded,
          label: s.shipperProfileNavLabel,
        ),
      ],
    );
  }
}

class ShipperHomeScreen extends StatelessWidget {
  const ShipperHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.shipperHomeTitle,
      description: s.shipperHomeDescription,
    );
  }
}

class MyShipmentsScreen extends StatelessWidget {
  const MyShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.myShipmentsTitle,
      description: s.myShipmentsDescription,
    );
  }
}

class SearchTripsScreen extends StatelessWidget {
  const SearchTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.searchTripsTitle,
      description: s.searchTripsDescription,
    );
  }
}

class BookingReviewScreen extends StatelessWidget {
  const BookingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.bookingReviewTitle,
      description: s.bookingReviewDescription,
    );
  }
}

class PaymentFlowScreen extends StatelessWidget {
  const PaymentFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.paymentFlowTitle,
      description: s.paymentFlowDescription,
    );
  }
}
