import 'dart:async';

import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/errors/app_error.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/theme/design_tokens.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:fleetfill/shared/models/algeria_location.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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

class SessionExpiredScreen extends StatelessWidget {
  const SessionExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.authSessionExpiredTitle,
      child: AppStateMessage(
        icon: Icons.lock_clock_outlined,
        title: s.authSessionExpiredTitle,
        message: s.authSessionExpiredMessage,
        action: FilledButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(s.authSessionExpiredAction),
        ),
      ),
    );
  }
}

class ShipmentDetailScreen extends StatelessWidget {
  const ShipmentDetailScreen({required this.shipmentId, super.key});

  final String shipmentId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final formattedShipmentId = BidiFormatters.trackingId(shipmentId);

    return AppPlaceholderScreen(
      title: s.shipmentDetailTitle(formattedShipmentId),
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
    final formattedBookingId = BidiFormatters.trackingId(bookingId);

    return AppPlaceholderScreen(
      title: s.bookingDetailTitle(formattedBookingId),
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
    final formattedBookingId = BidiFormatters.trackingId(bookingId);

    return AppPlaceholderScreen(
      title: s.trackingDetailTitle(formattedBookingId),
      description: s.trackingDetailDescription,
      showSummary: false,
    );
  }
}

class CarrierPublicProfileScreen extends ConsumerWidget {
  const CarrierPublicProfileScreen({required this.carrierId, super.key});

  final String carrierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedCarrierId = BidiFormatters.latinIdentifier(carrierId);
    final profile = ref.watch(publicCarrierProfileProvider(carrierId));

    return AppPageScaffold(
      title: s.carrierPublicProfileTitle(formattedCarrierId),
      child: profile.when(
        loading: () => const AppLoadingState(),
        error: (error, stackTrace) {
          final normalizedError = error.toString().toLowerCase();
          if (normalizedError.contains('not found') ||
              normalizedError.contains('carrier_profile_not_found')) {
            return const AppNotFoundState();
          }

          return AppErrorState(
            error: AppError(
              code: 'carrier_public_profile_failed',
              message: s.routeErrorMessage,
              technicalDetails: stackTrace.toString(),
            ),
          );
        },
        data: (carrier) {
          final formattedRating = carrier.ratingAverage == null
              ? '-'
              : BidiFormatters.latinIdentifier(
                  carrier.ratingAverage!.toStringAsFixed(1),
                );
          final formattedReviewCount = BidiFormatters.latinIdentifier(
            carrier.ratingCount.toString(),
          );

          return ListView(
            children: [
              AppSectionHeader(
                title: carrier.displayName,
                subtitle: s.carrierPublicProfileDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.carrierPublicProfileSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.carrierPublicProfileRatingLabel,
                    value: formattedRating,
                  ),
                  ProfileSummaryRow(
                    label: s.carrierPublicProfileReviewCountLabel,
                    value: formattedReviewCount,
                  ),
                  ProfileSummaryRow(
                    label: s.carrierProfileVerificationLabel,
                    value: verificationStatusLabel(
                      s,
                      carrier.verificationStatus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                s.carrierPublicProfileCommentsTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              if (carrier.comments.isEmpty)
                AppEmptyState(
                  title: s.carrierPublicProfileCommentsTitle,
                  message: s.carrierPublicProfileNoCommentsMessage,
                )
              else
                ...carrier.comments.map(
                  (comment) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppListCard(
                      title: BidiFormatters.latinIdentifier(
                        '${comment.score}/5',
                      ),
                      subtitle: comment.comment,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class RouteDetailScreen extends ConsumerWidget {
  const RouteDetailScreen({required this.routeId, super.key});

  final String routeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedRouteId = BidiFormatters.latinIdentifier(routeId);
    final routeAsync = ref.watch(carrierRouteDetailProvider(routeId));
    final communesAsync = ref.watch(communesProvider);
    final vehiclesAsync = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.routeDetailTitle(formattedRouteId),
      child: AppAsyncStateView<CarrierRoute?>(
        value: routeAsync,
        onRetry: () => ref.invalidate(carrierRouteDetailProvider(routeId)),
        data: (route) {
          if (route == null) {
            return const AppNotFoundState();
          }
          if (communesAsync.isLoading || vehiclesAsync.isLoading) {
            return const AppLoadingState();
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue) commune.id: commune,
          };
          final vehicleMap = {
            for (final vehicle in vehiclesAsync.requireValue) vehicle.id: vehicle,
          };

          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedLaneLabel(
                  context,
                  communeMap,
                  route.originCommuneId,
                  route.destinationCommuneId,
                ),
                subtitle: s.routeDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.myRoutesSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.routeVehicleLabel,
                    value: vehicleMap[route.vehicleId]?.plateNumber ??
                        BidiFormatters.latinIdentifier(route.vehicleId),
                  ),
                  ProfileSummaryRow(
                    label: s.routeDepartureTimeLabel,
                    value: _sharedFormatSqlTime(context, route.defaultDepartureTime),
                  ),
                  ProfileSummaryRow(
                    label: s.routeRecurringDaysLabel,
                    value: _sharedFormatWeekdays(context, route.recurringDaysOfWeek),
                  ),
                  ProfileSummaryRow(
                    label: s.routeEffectiveFromLabel,
                    value: _sharedFormatDate(route.effectiveFrom),
                  ),
                  ProfileSummaryRow(
                    label: s.routePricePerKgLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(route.pricePerKgDzd.toStringAsFixed(0))} ${s.pricePerKgUnitLabel}',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(route.totalCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: route.totalCapacityVolumeM3 == null
                        ? '-'
                        : BidiFormatters.latinIdentifier(
                            route.totalCapacityVolumeM3!.toStringAsFixed(1),
                          ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: route.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class OneOffTripDetailScreen extends ConsumerWidget {
  const OneOffTripDetailScreen({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedTripId = BidiFormatters.latinIdentifier(tripId);
    final tripAsync = ref.watch(oneOffTripDetailProvider(tripId));
    final communesAsync = ref.watch(communesProvider);
    final vehiclesAsync = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.oneOffTripDetailTitle(formattedTripId),
      child: AppAsyncStateView<CarrierOneOffTrip?>(
        value: tripAsync,
        onRetry: () => ref.invalidate(oneOffTripDetailProvider(tripId)),
        data: (trip) {
          if (trip == null) {
            return const AppNotFoundState();
          }
          if (communesAsync.isLoading || vehiclesAsync.isLoading) {
            return const AppLoadingState();
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue) commune.id: commune,
          };
          final vehicleMap = {
            for (final vehicle in vehiclesAsync.requireValue) vehicle.id: vehicle,
          };

          return ListView(
            children: [
              AppSectionHeader(
                title: _sharedLaneLabel(
                  context,
                  communeMap,
                  trip.originCommuneId,
                  trip.destinationCommuneId,
                ),
                subtitle: s.oneOffTripDetailDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSummaryCard(
                title: s.myRoutesSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.routeVehicleLabel,
                    value: vehicleMap[trip.vehicleId]?.plateNumber ??
                        BidiFormatters.latinIdentifier(trip.vehicleId),
                  ),
                  ProfileSummaryRow(
                    label: s.oneOffTripDepartureLabel,
                    value: '${_sharedFormatDate(trip.departureAt)} • ${TimeOfDay.fromDateTime(trip.departureAt).format(context)}',
                  ),
                  ProfileSummaryRow(
                    label: s.routePricePerKgLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(trip.pricePerKgDzd.toStringAsFixed(0))} ${s.pricePerKgUnitLabel}',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityWeightLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(trip.totalCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.vehicleCapacityVolumeLabel,
                    value: trip.totalCapacityVolumeM3 == null
                        ? '-'
                        : BidiFormatters.latinIdentifier(
                            trip.totalCapacityVolumeM3!.toStringAsFixed(1),
                          ),
                  ),
                  ProfileSummaryRow(
                    label: s.routeStatusLabel,
                    value: trip.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProofViewerScreen extends StatelessWidget {
  const ProofViewerScreen({required this.proofId, super.key});

  final String proofId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final formattedProofId = BidiFormatters.latinIdentifier(proofId);

    return AppPlaceholderScreen(
      title: s.proofViewerTitle(formattedProofId),
      description: s.proofViewerDescription,
      showSummary: false,
    );
  }
}

class DocumentViewerScreen extends ConsumerWidget {
  const DocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final formattedDocumentId = BidiFormatters.latinIdentifier(documentId);
    final documentAsync = ref.watch(
      verificationDocumentDetailProvider(documentId),
    );

    return AppPageScaffold(
      title: s.documentViewerTitle(formattedDocumentId),
      child: AppAsyncStateView<VerificationDocumentRecord?>(
        value: documentAsync,
        onRetry: () =>
            ref.invalidate(verificationDocumentDetailProvider(documentId)),
        data: (document) {
          if (document == null) {
            return const AppNotFoundState();
          }

          return FutureBuilder<String>(
            future: ref
                .read(vehicleRepositoryProvider)
                .createSignedDocumentUrl(document),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState();
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return AppErrorState(
                  error: AppError(
                    code: 'document_signed_url_failed',
                    message: mapAuthErrorMessage(
                      s,
                      snapshot.error?.toString() ??
                          'document_signed_url_unavailable',
                    ),
                    technicalDetails: snapshot.error?.toString(),
                  ),
                  onRetry: () => ref.invalidate(
                    verificationDocumentDetailProvider(documentId),
                  ),
                );
              }

              return AppStateMessage(
                icon: Icons.description_outlined,
                title: s.documentViewerTitle(formattedDocumentId),
                message: s.verificationDocumentOpenPreparedMessage,
                action: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton.icon(
                      onPressed: () => unawaited(
                        launchUrl(
                          Uri.parse(snapshot.data!),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: Text(s.documentViewerOpenAction),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SelectionArea(child: Text(snapshot.data!)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GeneratedDocumentViewerScreen extends StatelessWidget {
  const GeneratedDocumentViewerScreen({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final formattedDocumentId = BidiFormatters.latinIdentifier(documentId);

    return AppPlaceholderScreen(
      title: s.generatedDocumentViewerTitle(formattedDocumentId),
      description: s.generatedDocumentViewerDescription,
      showSummary: false,
    );
  }
}

String _sharedLaneLabel(
  BuildContext context,
  Map<int, AlgeriaCommune> communeMap,
  int originId,
  int destinationId,
) {
  final locale = Localizations.localeOf(context);
  final origin = communeMap[originId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(originId.toString());
  final destination = communeMap[destinationId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(destinationId.toString());
  return '$origin -> $destination';
}

String _sharedFormatDate(DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

String _sharedFormatSqlTime(BuildContext context, String value) {
  final parts = value.split(':');
  final time = TimeOfDay(
    hour: int.tryParse(parts.isEmpty ? '' : parts[0]) ?? 0,
    minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
  );
  return time.format(context);
}

String _sharedFormatWeekdays(BuildContext context, List<int> weekdays) {
  final labels = MaterialLocalizations.of(context).narrowWeekdays;
  return weekdays.map((day) => labels[day]).join(', ');
}
