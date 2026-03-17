import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.splashTitle,
      description: s.splashDescription,
      showSummary: false,
    );
  }
}

class MaintenanceModeScreen extends StatelessWidget {
  const MaintenanceModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.maintenanceTitle,
      description: s.maintenanceDescription,
      showSummary: false,
    );
  }
}

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.updateRequiredTitle,
      description: s.updateRequiredDescription,
      showSummary: false,
    );
  }
}

class ShipmentDetailScreen extends StatelessWidget {
  const ShipmentDetailScreen({required this.shipmentId, super.key});

  final String shipmentId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.shipmentDetailTitle(shipmentId),
      description: s.shipmentDetailDescription,
      showSummary: false,
    );
  }
}

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.bookingDetailTitle(bookingId),
      description: s.bookingDetailDescription,
      showSummary: false,
    );
  }
}

class BookingTrackingScreen extends StatelessWidget {
  const BookingTrackingScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.trackingDetailTitle(bookingId),
      description: s.trackingDetailDescription,
      showSummary: false,
    );
  }
}

class CarrierPublicProfileScreen extends StatelessWidget {
  const CarrierPublicProfileScreen({required this.carrierId, super.key});

  final String carrierId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.carrierPublicProfileTitle(carrierId),
      description: s.carrierPublicProfileDescription,
      showSummary: false,
    );
  }
}

class RouteDetailScreen extends StatelessWidget {
  const RouteDetailScreen({required this.routeId, super.key});

  final String routeId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.routeDetailTitle(routeId),
      description: s.routeDetailDescription,
      showSummary: false,
    );
  }
}

class OneOffTripDetailScreen extends StatelessWidget {
  const OneOffTripDetailScreen({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.oneOffTripDetailTitle(tripId),
      description: s.oneOffTripDetailDescription,
      showSummary: false,
    );
  }
}

class ProofViewerScreen extends StatelessWidget {
  const ProofViewerScreen({required this.proofId, super.key});

  final String proofId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.proofViewerTitle(proofId),
      description: s.proofViewerDescription,
      showSummary: false,
    );
  }
}

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.documentViewerTitle(documentId),
      description: s.documentViewerDescription,
      showSummary: false,
    );
  }
}

class GeneratedDocumentViewerScreen extends StatelessWidget {
  const GeneratedDocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.generatedDocumentViewerTitle(documentId),
      description: s.generatedDocumentViewerDescription,
      showSummary: false,
    );
  }
}
