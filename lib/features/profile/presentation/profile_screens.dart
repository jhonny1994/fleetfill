import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.settingsTitle,
      description: s.settingsDescription,
      showSummary: false,
    );
  }
}

class ShipperProfileScreen extends StatelessWidget {
  const ShipperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.shipperProfileTitle,
      description: s.shipperProfileDescription,
    );
  }
}

class EditShipperProfileScreen extends StatelessWidget {
  const EditShipperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.editShipperProfileTitle,
      description: s.editShipperProfileDescription,
      showSummary: false,
    );
  }
}

class CarrierProfileScreen extends StatelessWidget {
  const CarrierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.carrierProfileTitle,
      description: s.carrierProfileDescription,
    );
  }
}

class EditCarrierProfileScreen extends StatelessWidget {
  const EditCarrierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.editCarrierProfileTitle,
      description: s.editCarrierProfileDescription,
      showSummary: false,
    );
  }
}

class MyVehiclesScreen extends StatelessWidget {
  const MyVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.vehiclesTitle,
      description: s.vehiclesDescription,
      showSummary: false,
    );
  }
}

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.vehicleDetailTitle,
      description: s.vehicleDetailDescription,
      showSummary: false,
    );
  }
}

class PayoutAccountsScreen extends StatelessWidget {
  const PayoutAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.payoutAccountsTitle,
      description: s.payoutAccountsDescription,
      showSummary: false,
    );
  }
}
