import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyRoutesScreen extends ConsumerStatefulWidget {
  const MyRoutesScreen({super.key});

  @override
  ConsumerState<MyRoutesScreen> createState() => _MyRoutesScreenState();
}

class _MyRoutesScreenState extends ConsumerState<MyRoutesScreen> {
  CapacityPublicationTab _selectedTab = CapacityPublicationTab.recurring;
  int _routeLimit = CarrierPublicationRepository.defaultPageSize;
  int _tripLimit = CarrierPublicationRepository.defaultPageSize;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final summaryAsync = ref.watch(capacityPublicationSummaryProvider);
    final routesAsync = _selectedTab == CapacityPublicationTab.recurring
        ? ref.watch(myCarrierRoutesProvider(_routeLimit))
        : const AsyncData<List<CarrierRoute>>(<CarrierRoute>[]);
    final tripsAsync = _selectedTab == CapacityPublicationTab.oneOff
        ? ref.watch(myOneOffTripsProvider(_tripLimit))
        : const AsyncData<List<CarrierOneOffTrip>>(<CarrierOneOffTrip>[]);
    final communesAsync = ref.watch(communesProvider);
    final vehiclesAsync = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.myRoutesTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(capacityPublicationSummaryProvider)
            ..invalidate(myCarrierRoutesProvider(_routeLimit))
            ..invalidate(myOneOffTripsProvider(_tripLimit))
            ..invalidate(communesProvider)
            ..invalidate(myVehiclesProvider);
        },
        child: ListView(
          key: const PageStorageKey<String>(
            'carrier-capacity-publication-list',
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AppSectionHeader(
              title: s.myRoutesTitle,
              subtitle: s.myRoutesDescription,
              showTitle: false,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppAsyncStateView<CapacityPublicationSummary>(
              value: summaryAsync,
              onRetry: () => ref.invalidate(capacityPublicationSummaryProvider),
              data: (summary) => ProfileSummaryCard(
                title: s.myRoutesSummaryTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.myRoutesActiveRoutesLabel,
                    value: BidiFormatters.latinIdentifier(
                      summary.activeRecurringRouteCount.toString(),
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.myRoutesActiveTripsLabel,
                    value: BidiFormatters.latinIdentifier(
                      summary.activeOneOffTripCount.toString(),
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.myRoutesPublishedCapacityLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(summary.publishedCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.myRoutesReservedCapacityLabel,
                    value:
                        '${BidiFormatters.latinIdentifier(summary.reservedCapacityKg.toStringAsFixed(0))} kg',
                  ),
                  ProfileSummaryRow(
                    label: s.myRoutesUpcomingDeparturesLabel,
                    value: BidiFormatters.latinIdentifier(
                      summary.upcomingDepartureCount.toString(),
                    ),
                  ),
                  ProfileSummaryRow(
                    label: s.myRoutesUtilizationLabel,
                    value: BidiFormatters.latinIdentifier(
                      '${(summary.utilizationRatio * 100).toStringAsFixed(0)}%',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: FilledButton.icon(
                onPressed: () => unawaited(_showCreateChooser(context)),
                icon: const Icon(Icons.add_rounded),
                label: Text(s.myRoutesAddAction),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SegmentedButton<CapacityPublicationTab>(
              segments: [
                ButtonSegment(
                  value: CapacityPublicationTab.recurring,
                  label: Text(s.myRoutesRecurringTab),
                  icon: const Icon(Icons.repeat_rounded),
                ),
                ButtonSegment(
                  value: CapacityPublicationTab.oneOff,
                  label: Text(s.myRoutesOneOffTab),
                  icon: const Icon(Icons.schedule_send_rounded),
                ),
              ],
              selected: {_selectedTab},
              onSelectionChanged: (selection) {
                setState(() => _selectedTab = selection.first);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_selectedTab == CapacityPublicationTab.recurring)
              _PublicationRouteList(
                routesAsync: routesAsync,
                communesAsync: communesAsync,
                vehiclesAsync: vehiclesAsync,
                onLoadMore: () => setState(
                  () => _routeLimit +=
                      CarrierPublicationRepository.defaultPageSize,
                ),
              )
            else
              _PublicationOneOffTripList(
                tripsAsync: tripsAsync,
                communesAsync: communesAsync,
                vehiclesAsync: vehiclesAsync,
                onLoadMore: () => setState(
                  () => _tripLimit +=
                      CarrierPublicationRepository.defaultPageSize,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateChooser(BuildContext context) async {
    final s = S.of(context);

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppListCard(
                  title: s.myRoutesCreateRouteAction,
                  subtitle: s.routeEditorDescription,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(
                      this.context.push(AppRoutePath.carrierRouteCreate()),
                    );
                  },
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppListCard(
                  title: s.myRoutesCreateTripAction,
                  subtitle: s.oneOffTripEditorDescription,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(
                      this.context.push(AppRoutePath.carrierOneOffTripCreate()),
                    );
                  },
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum CapacityPublicationTab { recurring, oneOff }

class _PublicationRouteList extends StatelessWidget {
  const _PublicationRouteList({
    required this.routesAsync,
    required this.communesAsync,
    required this.vehiclesAsync,
    required this.onLoadMore,
  });

  final AsyncValue<List<CarrierRoute>> routesAsync;
  final AsyncValue<List<AlgeriaCommune>> communesAsync;
  final AsyncValue<List<CarrierVehicle>> vehiclesAsync;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (communesAsync.isLoading || vehiclesAsync.isLoading) {
      return const AppLoadingState();
    }

    if (communesAsync.hasError || vehiclesAsync.hasError) {
      return AppErrorState(
        error: AppError(
          code: 'publication_supporting_data_failed',
          message: s.routeErrorMessage,
          technicalDetails:
              '${communesAsync.error ?? ''} ${vehiclesAsync.error ?? ''}',
        ),
      );
    }

    final communeMap = {
      for (final commune in communesAsync.requireValue) commune.id: commune,
    };
    final vehicleMap = {
      for (final vehicle in vehiclesAsync.requireValue) vehicle.id: vehicle,
    };

    return routesAsync.when(
      data: (routes) {
        if (routes.isEmpty) {
          return AppEmptyState(
            title: s.myRoutesRouteListTitle,
            message: s.myRoutesEmptyMessage,
            action: FilledButton(
              onPressed: () => context.push(AppRoutePath.carrierRouteCreate()),
              child: Text(s.myRoutesCreateRouteAction),
            ),
          );
        }

        final canLoadMore =
            routes.length >= CarrierPublicationRepository.defaultPageSize;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.myRoutesRouteListTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            ...routes.map(
              (route) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppListCard(
                  title: _laneLabel(
                    context,
                    communeMap,
                    route.originCommuneId,
                    route.destinationCommuneId,
                  ),
                  subtitle: _routeSubtitle(
                    context,
                    route,
                    vehicleMap[route.vehicleId],
                  ),
                  leading: AppStatusChip(
                    label: route.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                    tone: route.isActive
                        ? AppStatusTone.success
                        : AppStatusTone.warning,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () =>
                      context.push(AppRoutePath.carrierRouteDetail(route.id)),
                ),
              ),
            ),
            if (canLoadMore) ...[
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: onLoadMore,
                child: Text(s.loadMoreLabel),
              ),
            ],
          ],
        );
      },
      loading: () => const AppLoadingState(),
      error: (error, stackTrace) => AppErrorState(
        error: AppError(
          code: 'routes_load_failed',
          message: mapAppErrorMessage(s, error),
          technicalDetails: stackTrace.toString(),
        ),
      ),
    );
  }
}

class _PublicationOneOffTripList extends StatelessWidget {
  const _PublicationOneOffTripList({
    required this.tripsAsync,
    required this.communesAsync,
    required this.vehiclesAsync,
    required this.onLoadMore,
  });

  final AsyncValue<List<CarrierOneOffTrip>> tripsAsync;
  final AsyncValue<List<AlgeriaCommune>> communesAsync;
  final AsyncValue<List<CarrierVehicle>> vehiclesAsync;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (communesAsync.isLoading || vehiclesAsync.isLoading) {
      return const AppLoadingState();
    }
    if (communesAsync.hasError || vehiclesAsync.hasError) {
      return AppErrorState(
        error: AppError(
          code: 'publication_supporting_data_failed',
          message: s.routeErrorMessage,
          technicalDetails:
              '${communesAsync.error ?? ''} ${vehiclesAsync.error ?? ''}',
        ),
      );
    }

    final communeMap = {
      for (final commune in communesAsync.requireValue) commune.id: commune,
    };
    final vehicleMap = {
      for (final vehicle in vehiclesAsync.requireValue) vehicle.id: vehicle,
    };

    return tripsAsync.when(
      data: (trips) {
        if (trips.isEmpty) {
          return AppEmptyState(
            title: s.myRoutesTripListTitle,
            message: s.myRoutesEmptyMessage,
            action: FilledButton(
              onPressed: () =>
                  context.push(AppRoutePath.carrierOneOffTripCreate()),
              child: Text(s.myRoutesCreateTripAction),
            ),
          );
        }

        final canLoadMore =
            trips.length >= CarrierPublicationRepository.defaultPageSize;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.myRoutesTripListTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            ...trips.map(
              (trip) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppListCard(
                  title: _laneLabel(
                    context,
                    communeMap,
                    trip.originCommuneId,
                    trip.destinationCommuneId,
                  ),
                  subtitle:
                      '${_formatDateTime(context, trip.departureAt)} • ${vehicleMap[trip.vehicleId] == null ? trip.vehicleId : _vehicleSummaryLabel(vehicleMap[trip.vehicleId]!)}',
                  leading: AppStatusChip(
                    label: trip.isActive
                        ? s.publicationActiveLabel
                        : s.publicationInactiveLabel,
                    tone: trip.isActive
                        ? AppStatusTone.success
                        : AppStatusTone.warning,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(
                    AppRoutePath.carrierOneOffTripDetail(trip.id),
                  ),
                ),
              ),
            ),
            if (canLoadMore) ...[
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: onLoadMore,
                child: Text(s.loadMoreLabel),
              ),
            ],
          ],
        );
      },
      loading: () => const AppLoadingState(),
      error: (error, stackTrace) => AppErrorState(
        error: AppError(
          code: 'trips_load_failed',
          message: mapAppErrorMessage(s, error),
          technicalDetails: stackTrace.toString(),
        ),
      ),
    );
  }
}

class CarrierRouteDetailScreen extends ConsumerWidget {
  const CarrierRouteDetailScreen({required this.routeId, super.key});

  final String routeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final routeAsync = ref.watch(carrierRouteDetailProvider(routeId));
    final revisionsAsync = ref.watch(routeRevisionsProvider(routeId));
    final communesAsync = ref.watch(communesProvider);
    final vehiclesAsync = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.routeDetailPageTitle,
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutePath.carrierRouteEdit(routeId)),
          icon: const Icon(Icons.edit_outlined),
          tooltip: s.routeEditTitle,
        ),
      ],
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
            for (final commune in communesAsync.requireValue)
              commune.id: commune,
          };
          final vehicleMap = {
            for (final vehicle in vehiclesAsync.requireValue)
              vehicle.id: vehicle,
          };

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(carrierRouteDetailProvider(routeId))
                ..invalidate(routeRevisionsProvider(routeId))
                ..invalidate(communesProvider)
                ..invalidate(myVehiclesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: _laneLabel(
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
                      value:
                          vehicleMap[route.vehicleId]?.plateNumber ??
                          route.vehicleId,
                    ),
                    ProfileSummaryRow(
                      label: s.routeDepartureTimeLabel,
                      value: _formatSqlTime(
                        context,
                        route.defaultDepartureTime,
                      ),
                    ),
                    ProfileSummaryRow(
                      label: s.routeRecurringDaysLabel,
                      value: _formatWeekdays(
                        context,
                        route.recurringDaysOfWeek,
                      ),
                    ),
                    ProfileSummaryRow(
                      label: s.routeEffectiveFromLabel,
                      value: _formatDate(context, route.effectiveFrom),
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
                const SizedBox(height: AppSpacing.md),
                _PublicationActionsRow(
                  onToggle: () => unawaited(_toggleActive(context, ref, route)),
                  onDelete: () =>
                      unawaited(_deleteRoute(context, ref, route.id)),
                  isActive: route.isActive,
                  activateLabel: s.routeActivateAction,
                  deactivateLabel: s.routeDeactivateAction,
                  deleteLabel: s.routeDeleteAction,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  s.publicationRevisionHistoryTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                revisionsAsync.when(
                  data: (revisions) {
                    if (revisions.isEmpty) {
                      return AppEmptyState(
                        title: s.publicationRevisionHistoryTitle,
                        message: s.publicationNoRevisionsMessage,
                      );
                    }
                    return Column(
                      children: revisions
                          .map(
                            (revision) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: AppListCard(
                                title: _formatDate(
                                  context,
                                  revision.effectiveFrom,
                                ),
                                subtitle:
                                    '${_formatSqlTime(context, revision.defaultDepartureTime)} • ${BidiFormatters.latinIdentifier(revision.pricePerKgDzd.toStringAsFixed(0))} ${s.pricePerKgUnitLabel}',
                              ),
                            ),
                          )
                          .toList(growable: false),
                    );
                  },
                  loading: () => const AppLoadingState(),
                  error: (error, stackTrace) => AppErrorState(
                    error: AppError(
                      code: 'route_revisions_load_failed',
                      message: mapAppErrorMessage(s, error),
                      technicalDetails: stackTrace.toString(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _toggleActive(
    BuildContext context,
    WidgetRef ref,
    CarrierRoute route,
  ) async {
    final s = S.of(context);
    try {
      final confirmed = await _confirmPublicationAction(
        context,
        title: route.isActive ? s.routeDeactivateAction : s.routeActivateAction,
        message: route.isActive
            ? s.routeDeactivateConfirmationMessage
            : s.routeActivateConfirmationMessage,
      );
      if (confirmed != true) {
        return;
      }

      final updated = await ref
          .read(capacityPublicationWorkflowControllerProvider)
          .setRouteActive(routeId: route.id, isActive: !route.isActive);
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        updated.isActive ? s.routeActivatedMessage : s.routeDeactivatedMessage,
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }

  Future<void> _deleteRoute(
    BuildContext context,
    WidgetRef ref,
    String routeId,
  ) async {
    final s = S.of(context);
    try {
      final confirmed = await _confirmPublicationAction(
        context,
        title: s.routeDeleteAction,
        message: s.routeDeleteConfirmationMessage,
      );
      if (confirmed != true) {
        return;
      }

      await ref
          .read(capacityPublicationWorkflowControllerProvider)
          .deleteRoute(routeId);
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.routeDeletedMessage);
      context.pop();
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class CarrierOneOffTripDetailScreen extends ConsumerWidget {
  const CarrierOneOffTripDetailScreen({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final tripAsync = ref.watch(oneOffTripDetailProvider(tripId));
    final communesAsync = ref.watch(communesProvider);
    final vehiclesAsync = ref.watch(myVehiclesProvider);

    return AppPageScaffold(
      title: s.oneOffTripDetailPageTitle,
      actions: [
        IconButton(
          onPressed: () =>
              context.push(AppRoutePath.carrierOneOffTripEdit(tripId)),
          icon: const Icon(Icons.edit_outlined),
          tooltip: s.oneOffTripEditTitle,
        ),
      ],
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
            for (final commune in communesAsync.requireValue)
              commune.id: commune,
          };
          final vehicleMap = {
            for (final vehicle in vehiclesAsync.requireValue)
              vehicle.id: vehicle,
          };

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(oneOffTripDetailProvider(tripId))
                ..invalidate(communesProvider)
                ..invalidate(myVehiclesProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: _laneLabel(
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
                      value:
                          vehicleMap[trip.vehicleId]?.plateNumber ??
                          trip.vehicleId,
                    ),
                    ProfileSummaryRow(
                      label: s.oneOffTripDepartureLabel,
                      value: _formatDateTime(context, trip.departureAt),
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
                const SizedBox(height: AppSpacing.md),
                _PublicationActionsRow(
                  onToggle: () => unawaited(_toggleActive(context, ref, trip)),
                  onDelete: () => unawaited(_deleteTrip(context, ref, trip.id)),
                  isActive: trip.isActive,
                  activateLabel: s.oneOffTripActivateAction,
                  deactivateLabel: s.oneOffTripDeactivateAction,
                  deleteLabel: s.oneOffTripDeleteAction,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _toggleActive(
    BuildContext context,
    WidgetRef ref,
    CarrierOneOffTrip trip,
  ) async {
    final s = S.of(context);
    try {
      final confirmed = await _confirmPublicationAction(
        context,
        title: trip.isActive
            ? s.oneOffTripDeactivateAction
            : s.oneOffTripActivateAction,
        message: trip.isActive
            ? s.oneOffTripDeactivateConfirmationMessage
            : s.oneOffTripActivateConfirmationMessage,
      );
      if (confirmed != true) {
        return;
      }

      final updated = await ref
          .read(capacityPublicationWorkflowControllerProvider)
          .setOneOffTripActive(tripId: trip.id, isActive: !trip.isActive);
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        updated.isActive
            ? s.oneOffTripActivatedMessage
            : s.oneOffTripDeactivatedMessage,
      );
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }

  Future<void> _deleteTrip(
    BuildContext context,
    WidgetRef ref,
    String tripId,
  ) async {
    final s = S.of(context);
    try {
      final confirmed = await _confirmPublicationAction(
        context,
        title: s.oneOffTripDeleteAction,
        message: s.oneOffTripDeleteConfirmationMessage,
      );
      if (confirmed != true) {
        return;
      }

      await ref
          .read(capacityPublicationWorkflowControllerProvider)
          .deleteOneOffTrip(tripId);
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.oneOffTripDeletedMessage);
      context.pop();
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

class RouteEditorScreen extends ConsumerStatefulWidget {
  const RouteEditorScreen({super.key, this.routeId});

  final String? routeId;

  @override
  ConsumerState<RouteEditorScreen> createState() => _RouteEditorScreenState();
}

class _RouteEditorScreenState
    extends _BasePublicationEditorState<RouteEditorScreen> {
  final Set<int> _selectedDays = <int>{};
  DateTime? _effectiveDate;
  TimeOfDay? _departureTime;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final routeAsync = widget.routeId == null
        ? const AsyncData<CarrierRoute?>(null)
        : ref.watch(carrierRouteDetailProvider(widget.routeId!));

    return _buildEditorScaffold<CarrierRoute?>(
      context: context,
      title: widget.routeId == null ? s.routeCreateTitle : s.routeEditTitle,
      description: s.routeEditorDescription,
      recordAsync: routeAsync,
      onRetry: widget.routeId == null
          ? null
          : () => ref.invalidate(carrierRouteDetailProvider(widget.routeId!)),
      initialize: (route) {
        if (_initialized) {
          return;
        }
        _selectedVehicleId = route?.vehicleId;
        _selectedOriginWilayaId = null;
        _selectedOriginCommuneId = route?.originCommuneId;
        _selectedDestinationWilayaId = null;
        _selectedDestinationCommuneId = route?.destinationCommuneId;
        _priceController.text = route?.pricePerKgDzd.toStringAsFixed(0) ?? '';
        _isActive = route?.isActive ?? true;
        _effectiveDate = route?.effectiveFrom ?? DateTime.now();
        _departureTime = route == null
            ? const TimeOfDay(hour: 8, minute: 0)
            : _parseTimeOfDay(route.defaultDepartureTime);
        _selectedDays
          ..clear()
          ..addAll(route?.recurringDaysOfWeek ?? const <int>[1]);
        _initialized = true;
      },
      buildFields:
          (
            context,
            vehicles,
            wilayas,
            originCommunes,
            destinationCommunes,
            route,
          ) {
            final eligibleVehicles = vehicles
                .where(
                  (vehicle) =>
                      vehicle.verificationStatus ==
                          AppVerificationState.verified ||
                      vehicle.id == _selectedVehicleId,
                )
                .toList(growable: false);
            final selectedVehicle = _selectedVehicle();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _WilayaPickerField(
                  label: s.routeOriginWilayaLabel,
                  value: _selectedOriginWilayaId,
                  wilayas: wilayas,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'origin wilaya changed: $value -> reset origin commune',
                    );
                    _selectedOriginWilayaId = value;
                    _selectedOriginCommuneId = null;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _CommunePickerField(
                  label: s.routeOriginLabel,
                  value: _selectedOriginCommuneId,
                  communeOptions: originCommunes,
                  enabled: _selectedOriginWilayaId != null,
                  isLoading: false,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker('origin commune changed: $value');
                    _selectedOriginCommuneId = value;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _WilayaPickerField(
                  label: s.routeDestinationWilayaLabel,
                  value: _selectedDestinationWilayaId,
                  wilayas: wilayas,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'destination wilaya changed: $value -> reset destination commune',
                    );
                    _selectedDestinationWilayaId = value;
                    _selectedDestinationCommuneId = null;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _CommunePickerField(
                  label: s.routeDestinationLabel,
                  value: _selectedDestinationCommuneId,
                  communeOptions: destinationCommunes,
                  enabled: _selectedDestinationWilayaId != null,
                  isLoading: false,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'destination commune changed: $value',
                    );
                    _selectedDestinationCommuneId = value;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _VehicleSelectorField(
                  label: s.routeVehicleLabel,
                  selectedVehicleId: _selectedVehicleId,
                  vehicles: eligibleVehicles,
                  onChanged: (value) =>
                      setState(() => _selectedVehicleId = value),
                ),
                const SizedBox(height: AppSpacing.md),
                if (selectedVehicle != null) ...[
                  ProfileSummaryCard(
                    title: s.routeVehicleLabel,
                    rows: [
                      ProfileSummaryRow(
                        label: s.vehicleTypeLabel,
                        value: selectedVehicle.vehicleType,
                      ),
                      ProfileSummaryRow(
                        label: s.vehicleCapacityWeightLabel,
                        value:
                            '${BidiFormatters.latinIdentifier(selectedVehicle.capacityWeightKg.toStringAsFixed(0))} kg',
                      ),
                      ProfileSummaryRow(
                        label: s.vehicleCapacityVolumeLabel,
                        value: selectedVehicle.capacityVolumeM3 == null
                            ? '-'
                            : BidiFormatters.latinIdentifier(
                                selectedVehicle.capacityVolumeM3!
                                    .toStringAsFixed(1),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                _NumericField(
                  controller: _priceController,
                  label: s.routePricePerKgLabel,
                ),
                const SizedBox(height: AppSpacing.md),
                _DateButtonField(
                  label: s.routeEffectiveFromLabel,
                  value: _effectiveDate == null
                      ? null
                      : _formatDate(context, _effectiveDate!),
                  onPressed: () => unawaited(_pickEffectiveDate(context)),
                ),
                const SizedBox(height: AppSpacing.md),
                _DateButtonField(
                  label: s.routeDepartureTimeLabel,
                  value: _departureTime?.format(context),
                  onPressed: () => unawaited(_pickDepartureTime(context)),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  s.routeRecurringDaysLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: List.generate(7, (index) {
                    final localizations = MaterialLocalizations.of(context);
                    final label = localizations.narrowWeekdays[index];
                    return FilterChip(
                      label: Text(label),
                      selected: _selectedDays.contains(index),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDays.add(index);
                          } else {
                            _selectedDays.remove(index);
                          }
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(s.routeStatusLabel),
                  value: _isActive,
                  onChanged: (value) => setState(() => _isActive = value),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthSubmitButton(
                  label: widget.routeId == null
                      ? s.myRoutesCreateRouteAction
                      : s.routeSaveAction,
                  isLoading: _isSaving,
                  onPressed: () => unawaited(_save(context)),
                ),
              ],
            );
          },
    );
  }

  Future<void> _pickEffectiveDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _effectiveDate ?? DateTime.now(),
    );
    if (selected == null || !mounted) {
      return;
    }
    setState(() => _effectiveDate = selected);
  }

  Future<void> _pickDepartureTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _departureTime ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (selected == null || !mounted) {
      return;
    }
    setState(() => _departureTime = selected);
  }

  Future<void> _save(BuildContext context) async {
    final s = S.of(context);
    final validation = _validateCommonInputs(s);
    if (validation != null) {
      AppFeedback.showSnackBar(context, validation);
      return;
    }
    if (_selectedDays.isEmpty) {
      AppFeedback.showSnackBar(context, s.publicationWeekdaysRequiredMessage);
      return;
    }
    setState(() => _isSaving = true);
    try {
      final effectiveFrom = DateTime(
        _effectiveDate!.year,
        _effectiveDate!.month,
        _effectiveDate!.day,
        _departureTime!.hour,
        _departureTime!.minute,
      );
      final workflow = ref.read(capacityPublicationWorkflowControllerProvider);
      final route = widget.routeId == null
          ? await workflow.createRoute(
              vehicleId: _selectedVehicleId!,
              originCommuneId: _selectedOriginCommuneId!,
              destinationCommuneId: _selectedDestinationCommuneId!,
              totalCapacityKg: _selectedVehicle()!.capacityWeightKg,
              totalCapacityVolumeM3: _selectedVehicle()!.capacityVolumeM3,
              pricePerKgDzd: double.parse(_priceController.text.trim()),
              defaultDepartureTime: _toSqlTime(_departureTime!),
              recurringDaysOfWeek: _selectedDays.toList()..sort(),
              effectiveFrom: effectiveFrom,
              isActive: _isActive,
            )
          : await workflow.updateRoute(
              routeId: widget.routeId!,
              vehicleId: _selectedVehicleId!,
              originCommuneId: _selectedOriginCommuneId!,
              destinationCommuneId: _selectedDestinationCommuneId!,
              totalCapacityKg: _selectedVehicle()!.capacityWeightKg,
              totalCapacityVolumeM3: _selectedVehicle()!.capacityVolumeM3,
              pricePerKgDzd: double.parse(_priceController.text.trim()),
              defaultDepartureTime: _toSqlTime(_departureTime!),
              recurringDaysOfWeek: _selectedDays.toList()..sort(),
              effectiveFrom: effectiveFrom,
              isActive: _isActive,
            );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        widget.routeId == null ? s.routeCreatedMessage : s.routeSavedMessage,
      );
      context.go(AppRoutePath.carrierRouteDetail(route.id));
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class OneOffTripEditorScreen extends ConsumerStatefulWidget {
  const OneOffTripEditorScreen({super.key, this.tripId});

  final String? tripId;

  @override
  ConsumerState<OneOffTripEditorScreen> createState() =>
      _OneOffTripEditorScreenState();
}

class _OneOffTripEditorScreenState
    extends _BasePublicationEditorState<OneOffTripEditorScreen> {
  DateTime? _departureAt;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final tripAsync = widget.tripId == null
        ? const AsyncData<CarrierOneOffTrip?>(null)
        : ref.watch(oneOffTripDetailProvider(widget.tripId!));

    return _buildEditorScaffold<CarrierOneOffTrip?>(
      context: context,
      title: widget.tripId == null
          ? s.oneOffTripCreateTitle
          : s.oneOffTripEditTitle,
      description: s.oneOffTripEditorDescription,
      recordAsync: tripAsync,
      onRetry: widget.tripId == null
          ? null
          : () => ref.invalidate(oneOffTripDetailProvider(widget.tripId!)),
      initialize: (trip) {
        if (_initialized) {
          return;
        }
        _selectedVehicleId = trip?.vehicleId;
        _selectedOriginWilayaId = null;
        _selectedOriginCommuneId = trip?.originCommuneId;
        _selectedDestinationWilayaId = null;
        _selectedDestinationCommuneId = trip?.destinationCommuneId;
        _priceController.text = trip?.pricePerKgDzd.toStringAsFixed(0) ?? '';
        _isActive = trip?.isActive ?? true;
        _departureAt =
            trip?.departureAt ?? DateTime.now().add(const Duration(days: 1));
        _initialized = true;
      },
      buildFields:
          (
            context,
            vehicles,
            wilayas,
            originCommunes,
            destinationCommunes,
            trip,
          ) {
            final eligibleVehicles = vehicles
                .where(
                  (vehicle) =>
                      vehicle.verificationStatus ==
                          AppVerificationState.verified ||
                      vehicle.id == _selectedVehicleId,
                )
                .toList(growable: false);
            final selectedVehicle = _selectedVehicle();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _WilayaPickerField(
                  label: s.routeOriginWilayaLabel,
                  value: _selectedOriginWilayaId,
                  wilayas: wilayas,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'origin wilaya changed: $value -> reset origin commune',
                    );
                    _selectedOriginWilayaId = value;
                    _selectedOriginCommuneId = null;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _CommunePickerField(
                  label: s.routeOriginLabel,
                  value: _selectedOriginCommuneId,
                  communeOptions: originCommunes,
                  enabled: _selectedOriginWilayaId != null,
                  isLoading: false,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker('origin commune changed: $value');
                    _selectedOriginCommuneId = value;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _WilayaPickerField(
                  label: s.routeDestinationWilayaLabel,
                  value: _selectedDestinationWilayaId,
                  wilayas: wilayas,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'destination wilaya changed: $value -> reset destination commune',
                    );
                    _selectedDestinationWilayaId = value;
                    _selectedDestinationCommuneId = null;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _CommunePickerField(
                  label: s.routeDestinationLabel,
                  value: _selectedDestinationCommuneId,
                  communeOptions: destinationCommunes,
                  enabled: _selectedDestinationWilayaId != null,
                  isLoading: false,
                  onChanged: (value) => setState(() {
                    _debugLocationPicker(
                      'destination commune changed: $value',
                    );
                    _selectedDestinationCommuneId = value;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
                _VehicleSelectorField(
                  label: s.routeVehicleLabel,
                  selectedVehicleId: _selectedVehicleId,
                  vehicles: eligibleVehicles,
                  onChanged: (value) =>
                      setState(() => _selectedVehicleId = value),
                ),
                const SizedBox(height: AppSpacing.md),
                if (selectedVehicle != null) ...[
                  ProfileSummaryCard(
                    title: s.routeVehicleLabel,
                    rows: [
                      ProfileSummaryRow(
                        label: s.vehicleTypeLabel,
                        value: selectedVehicle.vehicleType,
                      ),
                      ProfileSummaryRow(
                        label: s.vehicleCapacityWeightLabel,
                        value:
                            '${BidiFormatters.latinIdentifier(selectedVehicle.capacityWeightKg.toStringAsFixed(0))} kg',
                      ),
                      ProfileSummaryRow(
                        label: s.vehicleCapacityVolumeLabel,
                        value: selectedVehicle.capacityVolumeM3 == null
                            ? '-'
                            : BidiFormatters.latinIdentifier(
                                selectedVehicle.capacityVolumeM3!
                                    .toStringAsFixed(1),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                _NumericField(
                  controller: _priceController,
                  label: s.routePricePerKgLabel,
                ),
                const SizedBox(height: AppSpacing.md),
                _DateButtonField(
                  label: s.oneOffTripDepartureLabel,
                  value: _departureAt == null
                      ? null
                      : _formatDateTime(context, _departureAt!),
                  onPressed: () => unawaited(_pickDepartureAt(context)),
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(s.routeStatusLabel),
                  value: _isActive,
                  onChanged: (value) => setState(() => _isActive = value),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthSubmitButton(
                  label: widget.tripId == null
                      ? s.myRoutesCreateTripAction
                      : s.oneOffTripSaveAction,
                  isLoading: _isSaving,
                  onPressed: () => unawaited(_save(context)),
                ),
              ],
            );
          },
    );
  }

  Future<void> _pickDepartureAt(BuildContext context) async {
    final initial = _departureAt ?? DateTime.now().add(const Duration(days: 1));
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: initial,
    );
    if (date == null || !mounted) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !mounted) {
      return;
    }
    setState(() {
      _departureAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save(BuildContext context) async {
    final s = S.of(context);
    final validation = _validateCommonInputs(s);
    if (validation != null) {
      AppFeedback.showSnackBar(context, validation);
      return;
    }
    if (_departureAt == null) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    setState(() => _isSaving = true);
    try {
      final workflow = ref.read(capacityPublicationWorkflowControllerProvider);
      final trip = widget.tripId == null
          ? await workflow.createOneOffTrip(
              vehicleId: _selectedVehicleId!,
              originCommuneId: _selectedOriginCommuneId!,
              destinationCommuneId: _selectedDestinationCommuneId!,
              departureAt: _departureAt!,
              totalCapacityKg: _selectedVehicle()!.capacityWeightKg,
              totalCapacityVolumeM3: _selectedVehicle()!.capacityVolumeM3,
              pricePerKgDzd: double.parse(_priceController.text.trim()),
              isActive: _isActive,
            )
          : await workflow.updateOneOffTrip(
              tripId: widget.tripId!,
              vehicleId: _selectedVehicleId!,
              originCommuneId: _selectedOriginCommuneId!,
              destinationCommuneId: _selectedDestinationCommuneId!,
              departureAt: _departureAt!,
              totalCapacityKg: _selectedVehicle()!.capacityWeightKg,
              totalCapacityVolumeM3: _selectedVehicle()!.capacityVolumeM3,
              pricePerKgDzd: double.parse(_priceController.text.trim()),
              isActive: _isActive,
            );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        widget.tripId == null
            ? s.oneOffTripCreatedMessage
            : s.oneOffTripSavedMessage,
      );
      context.go(AppRoutePath.carrierOneOffTripDetail(trip.id));
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

abstract class _BasePublicationEditorState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  bool _initialized = false;
  bool _isSaving = false;
  String? _selectedVehicleId;
  int? _selectedOriginWilayaId;
  int? _selectedOriginCommuneId;
  int? _selectedDestinationWilayaId;
  int? _selectedDestinationCommuneId;
  bool _isActive = true;
  String? _lastLocationDebugSnapshot;

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _debugLocationPicker(String message) {
    if (!kDebugMode) {
      return;
    }
    debugPrint('[CarrierLocationPicker] $message');
  }

  void _logLocationSnapshot({
    required List<AlgeriaWilaya> wilayas,
    required int? resolvedOriginWilayaId,
    required int? resolvedDestinationWilayaId,
    required List<AlgeriaCommune> originCommunes,
    required List<AlgeriaCommune> destinationCommunes,
    required bool isOriginCommunesLoading,
    required bool isDestinationCommunesLoading,
  }) {
    if (!kDebugMode) {
      return;
    }
    final snapshot =
        'wilayas=${wilayas.length}'
        ' originWilaya=$resolvedOriginWilayaId'
        ' originCommune=$_selectedOriginCommuneId'
        ' originCommunes=${originCommunes.length}'
        ' originLoading=$isOriginCommunesLoading'
        ' destinationWilaya=$resolvedDestinationWilayaId'
        ' destinationCommune=$_selectedDestinationCommuneId'
        ' destinationCommunes=${destinationCommunes.length}'
        ' destinationLoading=$isDestinationCommunesLoading';
    if (snapshot == _lastLocationDebugSnapshot) {
      return;
    }
    _lastLocationDebugSnapshot = snapshot;
    _debugLocationPicker(snapshot);
  }

  Widget _buildEditorScaffold<R>({
    required BuildContext context,
    required String title,
    required String description,
    required AsyncValue<R> recordAsync,
    required VoidCallback? onRetry,
    required void Function(R record) initialize,
    required Widget Function(
      BuildContext context,
      List<CarrierVehicle> vehicles,
      List<AlgeriaWilaya> wilayas,
      List<AlgeriaCommune> originCommunes,
      List<AlgeriaCommune> destinationCommunes,
      R record,
    )
    buildFields,
  }) {
    return AppPageScaffold(
      title: title,
      child: AppAsyncStateView<R>(
        value: recordAsync,
        onRetry: onRetry,
        data: (record) {
          initialize(record);
          final vehiclesAsync = ref.watch(myVehiclesProvider);
          final wilayasAsync = ref.watch(wilayasProvider);
          final originSeedAsync =
              _selectedOriginWilayaId == null &&
                  _selectedOriginCommuneId != null
              ? ref.watch(communeByIdProvider(_selectedOriginCommuneId!))
              : null;
          final destinationSeedAsync =
              _selectedDestinationWilayaId == null &&
                  _selectedDestinationCommuneId != null
              ? ref.watch(
                  communeByIdProvider(_selectedDestinationCommuneId!),
                )
              : null;
          if (vehiclesAsync.isLoading ||
              wilayasAsync.isLoading ||
              originSeedAsync?.isLoading == true ||
              destinationSeedAsync?.isLoading == true) {
            return const AppLoadingState();
          }
          final initialLocationError =
              wilayasAsync.error ??
              originSeedAsync?.error ??
              destinationSeedAsync?.error;
          if (vehiclesAsync.hasError || initialLocationError != null) {
            if (vehiclesAsync.hasError) {
              _debugLocationPicker(
                'vehicle load failed: ${vehiclesAsync.error}',
              );
            }
            if (initialLocationError != null) {
              _debugLocationPicker(
                'initial location load failed: $initialLocationError',
              );
            }
            return AppErrorState(
              error: AppError(
                code: 'publication_editor_supporting_data_failed',
                message: S.of(context).routeErrorMessage,
                technicalDetails:
                    '${vehiclesAsync.error ?? ''} ${initialLocationError ?? ''}',
              ),
              onRetry: () {
                ref
                  ..invalidate(myVehiclesProvider)
                  ..invalidate(wilayasProvider);
                if (_selectedOriginCommuneId != null) {
                  ref.invalidate(
                    communeByIdProvider(_selectedOriginCommuneId!),
                  );
                }
                if (_selectedDestinationCommuneId != null) {
                  ref.invalidate(
                    communeByIdProvider(_selectedDestinationCommuneId!),
                  );
                }
              },
            );
          }
          final resolvedOriginWilayaId =
              _selectedOriginWilayaId ??
              originSeedAsync?.asData?.value?.wilayaId;
          final resolvedDestinationWilayaId =
              _selectedDestinationWilayaId ??
              destinationSeedAsync?.asData?.value?.wilayaId;
          _selectedOriginWilayaId = resolvedOriginWilayaId;
          _selectedDestinationWilayaId = resolvedDestinationWilayaId;

          final originCommunesAsync = resolvedOriginWilayaId == null
              ? null
              : ref.watch(communesForWilayaProvider(resolvedOriginWilayaId));
          final destinationCommunesAsync = resolvedDestinationWilayaId == null
              ? null
              : ref.watch(
                  communesForWilayaProvider(resolvedDestinationWilayaId),
                );
          final communeOptionsError =
              originCommunesAsync?.error ?? destinationCommunesAsync?.error;
          if (communeOptionsError != null) {
            _debugLocationPicker(
              'communes load failed: $communeOptionsError',
            );
            return AppErrorState(
              error: AppError(
                code: 'publication_communes_by_wilaya_failed',
                message: S.of(context).routeErrorMessage,
                technicalDetails: communeOptionsError.toString(),
              ),
              onRetry: () {
                if (resolvedOriginWilayaId != null) {
                  ref.invalidate(
                    communesForWilayaProvider(resolvedOriginWilayaId),
                  );
                }
                if (resolvedDestinationWilayaId != null) {
                  ref.invalidate(
                    communesForWilayaProvider(resolvedDestinationWilayaId),
                  );
                }
              },
            );
          }
          final originCommunes =
              originCommunesAsync?.asData?.value ?? const <AlgeriaCommune>[];
          final destinationCommunes =
              destinationCommunesAsync?.asData?.value ??
              const <AlgeriaCommune>[];
          final isOriginCommunesLoading =
              originCommunesAsync?.isLoading == true;
          final isDestinationCommunesLoading =
              destinationCommunesAsync?.isLoading == true;

          _logLocationSnapshot(
            wilayas: wilayasAsync.requireValue,
            resolvedOriginWilayaId: resolvedOriginWilayaId,
            resolvedDestinationWilayaId: resolvedDestinationWilayaId,
            originCommunes: originCommunes,
            destinationCommunes: destinationCommunes,
            isOriginCommunesLoading: isOriginCommunesLoading,
            isDestinationCommunesLoading: isDestinationCommunesLoading,
          );

          return ListView(
            children: [
              AppSectionHeader(title: title, subtitle: description),
              const SizedBox(height: AppSpacing.lg),
              AuthCard(
                child: AppFocusTraversal.form(
                  child: Form(
                    key: _formKey,
                    child: buildFields(
                      context,
                      vehiclesAsync.requireValue,
                      wilayasAsync.requireValue,
                      originCommunes,
                      destinationCommunes,
                      record,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String? _validateCommonInputs(S s) {
    if (!_formKey.currentState!.validate()) {
      return s.authRequiredFieldMessage;
    }
    if (_selectedOriginCommuneId == null ||
        _selectedDestinationCommuneId == null ||
        _selectedVehicleId == null) {
      return s.authRequiredFieldMessage;
    }
    if (_selectedOriginCommuneId == _selectedDestinationCommuneId) {
      return s.publicationSameLaneErrorMessage;
    }
    return null;
  }

  TimeOfDay _parseTimeOfDay(String raw) {
    final parts = raw.split(':');
    if (parts.length < 2) {
      return const TimeOfDay(hour: 8, minute: 0);
    }
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 8,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }

  String _toSqlTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  CarrierVehicle? _selectedVehicle() {
    final vehicles =
        ref.read(myVehiclesProvider).asData?.value ?? <CarrierVehicle>[];
    return vehicles
        .where((vehicle) => vehicle.id == _selectedVehicleId)
        .firstOrNull;
  }
}

class _WilayaPickerField extends StatelessWidget {
  const _WilayaPickerField({
    required this.label,
    required this.value,
    required this.wilayas,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final List<AlgeriaWilaya> wilayas;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final effectiveValue = wilayas.any((wilaya) => wilaya.id == value)
        ? value
        : null;
    return DropdownButtonFormField<int>(
      key: ValueKey<String>('wilaya-$label-$effectiveValue'),
      initialValue: effectiveValue,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: wilayas
          .map(
            (wilaya) => DropdownMenuItem<int>(
              value: wilaya.id,
              child: Text(wilaya.displayName(locale)),
            ),
          )
          .toList(growable: false),
      onChanged: onChanged,
      validator: (selected) {
        if (selected == null) {
          return S.of(context).authRequiredFieldMessage;
        }
        return null;
      },
    );
  }
}

class _CommunePickerField extends StatelessWidget {
  const _CommunePickerField({
    required this.label,
    required this.value,
    required this.communeOptions,
    required this.enabled,
    required this.isLoading,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final List<AlgeriaCommune> communeOptions;
  final bool enabled;
  final bool isLoading;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final effectiveValue = communeOptions.any((commune) => commune.id == value)
        ? value
        : null;
    return DropdownButtonFormField<int>(
      key: ValueKey<String>('commune-$label-$effectiveValue-$enabled'),
      initialValue: effectiveValue,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
      ),
      items: communeOptions
          .map(
            (commune) => DropdownMenuItem<int>(
              value: commune.id,
              child: Text(commune.displayName(locale)),
            ),
          )
          .toList(growable: false),
      onChanged: enabled && !isLoading ? onChanged : null,
      validator: (selected) {
        if (!enabled || isLoading || selected != null) {
          return null;
        }
        return S.of(context).authRequiredFieldMessage;
      },
    );
  }
}

class _VehicleSelectorField extends StatelessWidget {
  const _VehicleSelectorField({
    required this.label,
    required this.selectedVehicleId,
    required this.vehicles,
    required this.onChanged,
  });

  final String label;
  final String? selectedVehicleId;
  final List<CarrierVehicle> vehicles;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedVehicleId,
      decoration: InputDecoration(labelText: label),
      items: vehicles
          .map(
            (vehicle) => DropdownMenuItem(
              value: vehicle.id,
              child: Text(_vehicleMenuLabel(vehicle)),
            ),
          )
          .toList(growable: false),
      onChanged: onChanged,
      validator: (value) =>
          value == null ? S.of(context).authRequiredFieldMessage : null,
    );
  }
}

class _NumericField extends StatelessWidget {
  const _NumericField({
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      label: label,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        final trimmed = (value ?? '').trim();
        if (trimmed.isEmpty) {
          return S.of(context).authRequiredFieldMessage;
        }
        final normalized = double.tryParse(trimmed);
        if (normalized == null || normalized <= 0) {
          return S.of(context).vehiclePositiveNumberMessage;
        }
        return null;
      },
    );
  }
}

class _DateButtonField extends StatelessWidget {
  const _DateButtonField({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final String? value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$label: ${value ?? S.of(context).publicationSelectValueAction}',
        ),
      ),
    );
  }
}

class _PublicationActionsRow extends StatelessWidget {
  const _PublicationActionsRow({
    required this.onToggle,
    required this.onDelete,
    required this.isActive,
    required this.activateLabel,
    required this.deactivateLabel,
    required this.deleteLabel,
  });

  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final bool isActive;
  final String activateLabel;
  final String deactivateLabel;
  final String deleteLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onToggle,
            child: Text(isActive ? deactivateLabel : activateLabel),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: OutlinedButton(
            onPressed: onDelete,
            child: Text(deleteLabel),
          ),
        ),
      ],
    );
  }
}

String _laneLabel(
  BuildContext context,
  Map<int, AlgeriaCommune> communeMap,
  int originId,
  int destinationId,
) {
  final locale = Localizations.localeOf(context);
  final origin =
      communeMap[originId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(originId.toString());
  final destination =
      communeMap[destinationId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(destinationId.toString());
  return '$origin -> $destination';
}

String _routeSubtitle(
  BuildContext context,
  CarrierRoute route,
  CarrierVehicle? vehicle,
) {
  final price = BidiFormatters.latinIdentifier(
    route.pricePerKgDzd.toStringAsFixed(0),
  );
  return '${_formatWeekdays(context, route.recurringDaysOfWeek)} • ${vehicle == null ? route.vehicleId : _vehicleSummaryLabel(vehicle)} • $price ${S.of(context).pricePerKgUnitLabel}';
}

String _vehicleMenuLabel(CarrierVehicle vehicle) {
  return '${vehicle.vehicleType} • ${BidiFormatters.licensePlate(vehicle.plateNumber)}';
}

String _vehicleSummaryLabel(CarrierVehicle vehicle) {
  final capacity = BidiFormatters.latinIdentifier(
    vehicle.capacityWeightKg.toStringAsFixed(0),
  );
  return '${vehicle.vehicleType} • $capacity kg';
}

String _formatWeekdays(BuildContext context, List<int> weekdays) {
  final labels = MaterialLocalizations.of(context).narrowWeekdays;
  return weekdays.map((day) => labels[day]).join(', ');
}

String _formatDate(BuildContext context, DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

String _formatDateTime(BuildContext context, DateTime value) {
  final time = TimeOfDay.fromDateTime(value).format(context);
  return '${_formatDate(context, value)} • $time';
}

String _formatSqlTime(BuildContext context, String value) {
  final parts = value.split(':');
  final time = TimeOfDay(
    hour: int.tryParse(parts.firstOrNull ?? '') ?? 0,
    minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
  );
  return time.format(context);
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

Future<bool?> _confirmPublicationAction(
  BuildContext context, {
  required String title,
  required String message,
}) {
  final s = S.of(context);
  return showDialog<bool>(
    context: context,
    builder: (context) => AppFocusTraversal.dialog(
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.cancelLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(s.confirmLabel),
          ),
        ],
      ),
    ),
  );
}
