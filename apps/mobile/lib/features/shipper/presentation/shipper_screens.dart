import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/profile/profile.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        AppShellDestination(
          icon: Icons.home_outlined,
          label: s.shipperHomeNavLabel,
        ),
        AppShellDestination(
          icon: Icons.inventory_2_outlined,
          label: s.myShipmentsNavLabel,
        ),
        AppShellDestination(
          icon: Icons.search_rounded,
          label: s.searchTripsNavLabel,
        ),
        AppShellDestination(
          icon: Icons.person_outline_rounded,
          label: s.shipperProfileNavLabel,
        ),
      ],
    );
  }
}

class ShipperHomeScreen extends ConsumerWidget {
  const ShipperHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final shipmentsAsync = ref.watch(myShipperShipmentsProvider);
    final bookingsAsync = ref.watch(myShipperBookingsProvider);
    final bookings = bookingsAsync.asData?.value ?? const <BookingRecord>[];
    final shipments = shipmentsAsync.asData?.value ?? const <ShipmentDraftRecord>[];
    final activeBookings = bookings
        .where(
          (booking) =>
              booking.bookingStatus != BookingStatus.completed &&
              booking.bookingStatus != BookingStatus.cancelled,
        )
        .toList(growable: false);
    final draftShipments = shipments
        .where((shipment) => shipment.status == ShipmentStatus.draft)
        .toList(growable: false);
    final focusBooking = _highestPriorityShipperBooking(activeBookings);
    final focusShipment = draftShipments.firstOrNull;

    return AppPageScaffold(
      title: s.shipperHomeTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(myShipperShipmentsProvider)
            ..invalidate(myShipperBookingsProvider);
        },
        child: ListView(
          key: const PageStorageKey<String>('shipper-home-screen'),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AppSectionHeader(
              title: s.shipperHomeTitle,
              subtitle: s.shipperHomeDescription,
              showTitle: false,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileSummaryCard(
              title: s.shipperHomeTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.shipperHomeActiveBookingsLabel,
                  value: BidiFormatters.latinIdentifier(
                    activeBookings.length.toString(),
                  ),
                ),
                ProfileSummaryRow(
                  label: s.myShipmentsTitle,
                  value: BidiFormatters.latinIdentifier(
                    shipments.length.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              s.bookingNextActionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (focusBooking != null) ...[
              _OperationalFocusCard(
                title: _shipperHomeFocusTitle(s, focusBooking),
                message: _shipperHomeFocusMessage(s, focusBooking),
                tone: _shipperHomeFocusTone(focusBooking),
                buttonLabel: _shipperWorkspaceActionLabel(s, focusBooking),
                onPressed: () => context.push(
                  AppRoutePath.sharedShipmentDetail.replaceFirst(
                    ':id',
                    focusBooking.shipmentId,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ] else if (focusShipment != null) ...[
              _OperationalFocusCard(
                title: s.shipmentStatusDraftLabel,
                message: s.searchTripsRequiresDraftMessage,
                tone: AppStatusTone.info,
                buttonLabel: s.searchTripsAction,
                onPressed: () => context.go(AppRoutePath.shipperSearch),
              ),
              const SizedBox(height: AppSpacing.sm),
            ] else
              AppStateMessage(
                icon: Icons.task_alt_rounded,
                title: s.operationsActiveLabel,
                message: s.shipperActiveOperationsEmptyMessage,
              ),
            const SizedBox(height: AppSpacing.md),
            Text(
              s.shipperHomeQuickActionsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListCard(
              title: s.searchTripsTitle,
              subtitle: s.searchTripsDescription,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go(AppRoutePath.shipperSearch),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListCard(
              title: s.supportTitle,
              subtitle: s.supportDescription,
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(AppRoutePath.sharedSupport),
            ),
          ],
        ),
      ),
    );
  }
}

enum _OperationsListScope { active, history }

class MyShipmentsScreen extends ConsumerStatefulWidget {
  const MyShipmentsScreen({super.key});

  @override
  ConsumerState<MyShipmentsScreen> createState() => _MyShipmentsScreenState();
}

class _MyShipmentsScreenState extends ConsumerState<MyShipmentsScreen> {
  _OperationsListScope _scope = _OperationsListScope.active;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final shipmentsAsync = ref.watch(myShipperShipmentsProvider);
    final bookingsAsync = ref.watch(myShipperBookingsProvider);
    final locationDirectoryAsync = ref.watch(locationDirectoryProvider);

    return AppPageScaffold(
      title: s.myShipmentsTitle,
      child: AppAsyncStateView<List<ShipmentDraftRecord>>(
        value: shipmentsAsync,
        onRetry: () => ref.invalidate(myShipperShipmentsProvider),
        data: (shipments) {
          if (shipments.isEmpty) {
            return AppEmptyState(
              title: s.myShipmentsTitle,
              message: s.shipmentsEmptyMessage,
              action: FilledButton.icon(
                onPressed: () => _openShipmentEditor(context),
                icon: const Icon(Icons.add_rounded),
                label: Text(s.shipmentCreateAction),
              ),
            );
          }
          if (locationDirectoryAsync.isLoading) {
            return const AppLoadingState();
          }
          if (locationDirectoryAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'shipment_communes_load_failed',
                message: mapAppErrorMessage(
                  s,
                  locationDirectoryAsync.error ?? Exception('unknown'),
                ),
              ),
              onRetry: () => ref.invalidate(locationDirectoryProvider),
            );
          }
          final communeMap = {
            for (final commune in locationDirectoryAsync.requireValue.communes)
              commune.id: commune,
          };
          final bookingByShipmentId = {
            for (final booking
                in bookingsAsync.asData?.value ?? const <BookingRecord>[])
              booking.shipmentId: booking,
          };
          final filteredShipments = shipments.where((shipment) {
            final booking = bookingByShipmentId[shipment.id];
            final isHistory =
                shipment.status == ShipmentStatus.cancelled ||
                (booking != null &&
                    (booking.bookingStatus == BookingStatus.completed ||
                        booking.bookingStatus == BookingStatus.cancelled));
            return _scope == _OperationsListScope.active ? !isHistory : isHistory;
          }).toList(growable: false);

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(myShipperShipmentsProvider)
                ..invalidate(myShipperBookingsProvider)
                ..invalidate(locationDirectoryProvider);
            },
            child: ListView(
              key: const PageStorageKey<String>('shipper-shipments-list'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FilledButton.icon(
                    onPressed: () => _openShipmentEditor(context),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(s.shipmentCreateAction),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                SegmentedButton<_OperationsListScope>(
                  segments: [
                    ButtonSegment<_OperationsListScope>(
                      value: _OperationsListScope.active,
                      label: Text(s.operationsActiveLabel),
                      icon: const Icon(Icons.pending_actions_rounded),
                    ),
                    ButtonSegment<_OperationsListScope>(
                      value: _OperationsListScope.history,
                      label: Text(s.operationsHistoryLabel),
                      icon: const Icon(Icons.history_rounded),
                    ),
                  ],
                  selected: {_scope},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _scope = selection.first;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                if (filteredShipments.isEmpty)
                  AppEmptyState(
                    title: _scope == _OperationsListScope.active
                        ? s.operationsActiveLabel
                        : s.operationsHistoryLabel,
                    message: _scope == _OperationsListScope.active
                        ? s.shipperActiveOperationsEmptyMessage
                        : s.shipperHistoryOperationsEmptyMessage,
                  )
                else
                  ...filteredShipments.indexed.map((entry) {
                  final index = entry.$1;
                  final shipment = entry.$2;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == filteredShipments.length - 1
                          ? 0
                          : AppSpacing.sm,
                    ),
                    child: _ShipperShipmentListItem(
                      shipment: shipment,
                      booking: bookingByShipmentId[shipment.id],
                      communeMap: communeMap,
                      onOpenEditor: () =>
                          _openShipmentEditor(context, shipment: shipment),
                      onDeleteDraft: () => _deleteShipmentFromList(
                        context,
                        ref,
                        shipment,
                      ),
                      onCancelBooking: (booking) =>
                          _cancelBookingFromShipmentList(
                            context,
                            ref,
                            booking,
                          ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
      );
  }

  void _openShipmentEditor(
    BuildContext context, {
    ShipmentDraftRecord? shipment,
  }) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _ShipmentEditorSheet(shipment: shipment),
      ),
    );
  }

  Future<void> _deleteShipmentFromList(
    BuildContext context,
    WidgetRef ref,
    ShipmentDraftRecord shipment,
  ) async {
    final confirmed = await _confirmShipmentDelete(context);
    if (!context.mounted || confirmed != true) {
      return;
    }

    final s = S.of(context);
    try {
      await ref
          .read(shipmentWorkflowControllerProvider)
          .deleteShipmentDraft(shipment.id);
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.shipmentDeletedMessage);
    } on PostgrestException catch (error) {
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    }
  }

  Future<void> _cancelBookingFromShipmentList(
    BuildContext context,
    WidgetRef ref,
    BookingRecord booking,
  ) async {
    final confirmed = await _confirmBookingCancel(context);
    if (!context.mounted || confirmed != true) {
      return;
    }

    final s = S.of(context);
    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .shipperCancelPendingBooking(
            bookingId: booking.id,
            shipmentId: booking.shipmentId,
          );
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.bookingStatusCancelledLabel);
    } on PostgrestException catch (error) {
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
    }
  }
}

enum _ShipmentListAction { edit, delete }
enum _BookedShipmentAction { openPayment, cancel }

class _ShipperShipmentListItem extends StatelessWidget {
  const _ShipperShipmentListItem({
    required this.shipment,
    required this.booking,
    required this.communeMap,
    required this.onOpenEditor,
    required this.onDeleteDraft,
    required this.onCancelBooking,
  });

  final ShipmentDraftRecord shipment;
  final BookingRecord? booking;
  final Map<int, AlgeriaCommune> communeMap;
  final VoidCallback onOpenEditor;
  final Future<void> Function() onDeleteDraft;
  final Future<void> Function(BookingRecord booking) onCancelBooking;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cancellableBooking =
        booking != null && _canShipperCancelPendingBooking(booking!)
        ? booking
        : null;
    final paymentFlowBooking =
        booking != null && _canOpenShipperBookingWorkspace(booking!)
        ? booking
        : null;

    return AppListCard(
      title: _shipmentLaneLabel(context, shipment, communeMap),
      subtitle: _shipmentOperationalSubtitle(context, shipment, booking),
      leading: AppStatusChip(
        label: _shipmentPrimaryStateLabel(s, shipment, booking),
        tone: _shipmentPrimaryStateTone(shipment, booking),
      ),
      trailing: shipment.status == ShipmentStatus.draft
          ? PopupMenuButton<_ShipmentListAction>(
              tooltip: s.shipmentEditAction,
              onSelected: (action) {
                if (action == _ShipmentListAction.edit) {
                  onOpenEditor();
                  return;
                }
                unawaited(onDeleteDraft());
              },
              itemBuilder: (context) => [
                PopupMenuItem<_ShipmentListAction>(
                  value: _ShipmentListAction.edit,
                  child: Text(s.shipmentEditAction),
                ),
                PopupMenuItem<_ShipmentListAction>(
                  value: _ShipmentListAction.delete,
                  child: Text(s.shipmentDeleteAction),
                ),
              ],
            )
          : (cancellableBooking != null || paymentFlowBooking != null)
          ? PopupMenuButton<_BookedShipmentAction>(
              tooltip: s.paymentFlowTitle,
              onSelected: (action) {
                switch (action) {
                  case _BookedShipmentAction.openPayment:
                    if (paymentFlowBooking != null) {
                      unawaited(context.push(
                        AppRoutePath.sharedShipmentDetail.replaceFirst(
                          ':id',
                          shipment.id,
                        ),
                      ));
                    }
                  case _BookedShipmentAction.cancel:
                    if (cancellableBooking != null) {
                      unawaited(onCancelBooking(cancellableBooking));
                    }
                }
              },
              itemBuilder: (context) => [
                if (paymentFlowBooking != null)
                  PopupMenuItem<_BookedShipmentAction>(
                    value: _BookedShipmentAction.openPayment,
                    child: Text(
                      _shipperWorkspaceActionLabel(s, paymentFlowBooking),
                    ),
                  ),
                if (cancellableBooking != null)
                  PopupMenuItem<_BookedShipmentAction>(
                    value: _BookedShipmentAction.cancel,
                    child: Text(s.cancelLabel),
                  ),
              ],
            )
          : null,
      onTap: () {
        unawaited(context.push(
          AppRoutePath.sharedShipmentDetail.replaceFirst(':id', shipment.id),
        ));
      },
    );
  }
}

class SearchTripsScreen extends ConsumerStatefulWidget {
  const SearchTripsScreen({super.key});

  @override
  ConsumerState<SearchTripsScreen> createState() => _SearchTripsScreenState();
}

class _SearchTripsScreenState extends ConsumerState<SearchTripsScreen> {
  String? _selectedShipmentId;
  DateTime? _requestedDate;
  SearchSortOption _sort = SearchSortOption.recommended;
  bool _includeRecurring = true;
  bool _includeOneOff = true;
  bool _isSearching = false;
  ShipmentSearchResponse? _response;
  int _searchToken = 0;
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final shipmentsAsync = ref.watch(myShipperShipmentsProvider);
    final locationDirectoryAsync = ref.watch(locationDirectoryProvider);

    return AppPageScaffold(
      title: s.searchTripsTitle,
      child: AppAsyncStateView<List<ShipmentDraftRecord>>(
        value: shipmentsAsync,
        onRetry: () => ref.invalidate(myShipperShipmentsProvider),
        data: (shipments) {
          final draftShipments = shipments
              .where((shipment) => shipment.status == ShipmentStatus.draft)
              .toList(growable: false);
          if (draftShipments.isEmpty) {
            return AppEmptyState(
              title: s.searchTripsTitle,
              message: s.searchTripsRequiresDraftMessage,
            );
          }
          if (locationDirectoryAsync.isLoading) {
            return const AppLoadingState();
          }
          if (locationDirectoryAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'search_locations_load_failed',
                message: mapAppErrorMessage(
                  s,
                  locationDirectoryAsync.error ?? Exception('unknown'),
                ),
              ),
              onRetry: () => ref.invalidate(locationDirectoryProvider),
            );
          }
          _selectedShipmentId ??= draftShipments.first.id;
          final selectedShipment = draftShipments.firstWhere(
            (shipment) => shipment.id == _selectedShipmentId,
            orElse: () => draftShipments.first,
          );
          _requestedDate ??= DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );

          return RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(myShipperShipmentsProvider)
                ..invalidate(locationDirectoryProvider);
            },
            child: ListView(
              key: const PageStorageKey<String>('shipper-search-screen'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                AppSectionHeader(
                  title: s.searchTripsTitle,
                  subtitle: s.searchTripsDescription,
                  showTitle: false,
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        initialValue: _selectedShipmentId,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: s.searchShipmentSelectorLabel,
                        ),
                        selectedItemBuilder: (context) => draftShipments
                            .map(
                              (shipment) => Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _shipmentSelectorLabel(
                                    context,
                                    shipment,
                                    locationDirectoryAsync
                                        .asData!
                                        .value
                                        .communes,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(growable: false),
                        items: draftShipments
                            .map(
                              (shipment) => DropdownMenuItem(
                                value: shipment.id,
                                child: Text(
                                  _shipmentSelectorLabel(
                                    context,
                                    shipment,
                                    locationDirectoryAsync
                                        .asData!
                                        .value
                                        .communes,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(growable: false),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          final nextShipment = draftShipments.firstWhere(
                            (shipment) => shipment.id == value,
                          );
                          setState(() {
                            _selectedShipmentId = value;
                            _response = null;
                          });
                          _scheduleSearch(nextShipment, reset: true);
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _DateButtonField(
                        label: s.searchRequestedDateLabel,
                        value: _requestedDate == null
                            ? null
                            : _formatDate(_requestedDate!),
                        onPressed: () => unawaited(_pickRequestedDate(context)),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _CompactShipmentSummaryCard(
                        shipment: selectedShipment,
                        communes: locationDirectoryAsync.asData!.value.communes,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthSubmitButton(
                        label: s.searchTripsAction,
                        isLoading: _isSearching,
                        onPressed: () =>
                            _scheduleSearch(selectedShipment, reset: true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_response != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              unawaited(_openSearchControlsSheet(context)),
                          icon: const Icon(Icons.tune_rounded),
                          label: Text(s.searchTripsControlsAction),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _SearchResultsSection(
                    shipment: selectedShipment,
                    response: _response!,
                    sort: _sort,
                    includeRecurring: _includeRecurring,
                    includeOneOff: _includeOneOff,
                    onLoadMore: _response!.nextOffset == null
                        ? null
                        : () => _scheduleSearch(selectedShipment, reset: false),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _scheduleSearch(ShipmentDraftRecord shipment, {required bool reset}) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(_runSearch(shipment, reset: reset));
    });
  }

  Future<void> _openSearchControlsSheet(BuildContext context) async {
    final result =
        await showModalBottomSheet<
          (
            SearchSortOption,
            bool,
            bool,
          )
        >(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            var selectedSort = _sort;
            var includeRecurring = _includeRecurring;
            var includeOneOff = _includeOneOff;
            final s = S.of(context);
            return StatefulBuilder(
              builder: (context, setModalState) => SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.82,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            s.searchTripsControlsAction,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          RadioGroup<SearchSortOption>(
                            groupValue: selectedSort,
                            onChanged: (value) {
                              if (value != null) {
                                setModalState(() => selectedSort = value);
                              }
                            },
                            child: Column(
                              children: SearchSortOption.values
                                  .map(
                                    (option) => RadioListTile<SearchSortOption>(
                                      value: option,
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        switch (option) {
                                          SearchSortOption.recommended =>
                                            s.searchSortRecommendedLabel,
                                          SearchSortOption.topRated =>
                                            s.searchSortTopRatedLabel,
                                          SearchSortOption.lowestPrice =>
                                            s.searchSortLowestPriceLabel,
                                          SearchSortOption.nearestDeparture =>
                                            s.searchSortNearestDepartureLabel,
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          CheckboxListTile(
                            value: includeRecurring,
                            onChanged: (value) {
                              final nextValue = value ?? true;
                              if (!nextValue && !includeOneOff) {
                                return;
                              }
                              setModalState(() => includeRecurring = nextValue);
                            },
                            title: Text(s.searchTripsRecurringLabel),
                            contentPadding: EdgeInsets.zero,
                          ),
                          CheckboxListTile(
                            value: includeOneOff,
                            onChanged: (value) {
                              final nextValue = value ?? true;
                              if (!nextValue && !includeRecurring) {
                                return;
                              }
                              setModalState(() => includeOneOff = nextValue);
                            },
                            title: Text(s.searchTripsOneOffLabel),
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FilledButton(
                            onPressed: () => Navigator.of(context).pop((
                              selectedSort,
                              includeRecurring,
                              includeOneOff,
                            )),
                            child: Text(s.confirmLabel),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
    if (result == null || !mounted) {
      return;
    }
    setState(() {
      _sort = result.$1;
      _includeRecurring = result.$2;
      _includeOneOff = result.$3;
    });
  }

  Future<void> _runSearch(
    ShipmentDraftRecord shipment, {
    required bool reset,
  }) async {
    final requestedDate = _requestedDate;
    if (requestedDate == null) {
      return;
    }
    final token = ++_searchToken;
    setState(() => _isSearching = true);
    try {
      final response = await ref
          .read(shipmentRepositoryProvider)
          .searchExactLaneCapacity(
            ShipmentSearchQuery(
              originCommuneId: shipment.originCommuneId,
              destinationCommuneId: shipment.destinationCommuneId,
              requestedDate: requestedDate,
              totalWeightKg: shipment.totalWeightKg,
              totalVolumeM3: shipment.totalVolumeM3,
              sort: _sort,
              offset: reset ? 0 : (_response?.nextOffset ?? 0),
            ),
          );
      if (!mounted || token != _searchToken) {
        return;
      }
      setState(() {
        _response = reset || _response == null
            ? response
            : ShipmentSearchResponse(
                mode: response.mode,
                results: [..._response!.results, ...response.results],
                nearestDates: response.nearestDates,
                nextOffset: response.nextOffset,
                totalCount: response.totalCount,
              );
      });
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(
          context,
          mapAppErrorMessage(S.of(context), error),
        );
      }
    } finally {
      if (mounted && token == _searchToken) {
        setState(() => _isSearching = false);
      }
    }
  }

  Future<void> _pickRequestedDate(BuildContext context) async {
    final initial = _requestedDate ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: initial,
    );
    if (date == null || !mounted) {
      return;
    }
    setState(() {
      _requestedDate = DateTime(date.year, date.month, date.day);
      _response = null;
    });
  }
}

class BookingReviewScreen extends ConsumerStatefulWidget {
  const BookingReviewScreen({super.key, this.selection});

  final BookingReviewSelection? selection;

  @override
  ConsumerState<BookingReviewScreen> createState() =>
      _BookingReviewScreenState();
}

class _BookingReviewScreenState extends ConsumerState<BookingReviewScreen> {
  bool _includeInsurance = false;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bookingSelection = widget.selection;
    final clientSettingsAsync = ref.watch(clientSettingsProvider);

    if (bookingSelection == null) {
      return AppPageScaffold(
        title: s.bookingReviewTitle,
        child: const AppNotFoundState(),
      );
    }

    final quote = calculateBookingQuote(
      bookingSelection: bookingSelection,
      includeInsurance: _includeInsurance,
      settings: clientSettingsAsync.asData?.value,
    );

    return AppPageScaffold(
      title: s.bookingReviewTitle,
      child: ListView(
        key: const PageStorageKey<String>('shipper-booking-review-screen'),
        children: [
          AppSectionHeader(
            title: s.bookingReviewTitle,
            subtitle: s.bookingReviewDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSummaryCard(
            title: s.searchCarrierLabel,
            rows: [
              ProfileSummaryRow(
                label: s.searchCarrierLabel,
                value: bookingSelection.result.carrierName,
              ),
              ProfileSummaryRow(
                label: s.searchDepartureLabel,
                value: _formatDateTime(
                  context,
                  bookingSelection.result.departureAt,
                ),
              ),
              ProfileSummaryRow(
                label: s.searchResultTypeLabel,
                value: bookingSelection.result.sourceType == 'route'
                    ? s.searchTripsRecurringLabel
                    : s.searchTripsOneOffLabel,
              ),
              ProfileSummaryRow(
                label: s.searchCarrierRatingLabel,
                value: BidiFormatters.latinIdentifier(
                  bookingSelection.result.ratingAverage.toStringAsFixed(1),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileSummaryCard(
            title: s.searchShipmentSummaryTitle,
            rows: [
              if ((bookingSelection.shipment.details ?? '').trim().isNotEmpty)
                ProfileSummaryRow(
                  label: s.shipmentDescriptionLabel,
                  value: bookingSelection.shipment.details!,
                ),
              ProfileSummaryRow(
                label: s.vehicleCapacityWeightLabel,
                value:
                    '${BidiFormatters.latinIdentifier(bookingSelection.shipment.totalWeightKg.toStringAsFixed(0))} kg',
              ),
              ProfileSummaryRow(
                label: s.searchEstimatedPriceLabel,
                value:
                    '${BidiFormatters.latinIdentifier(quote.shipperTotalDzd.toStringAsFixed(0))} ${s.priceCurrencyLabel}',
              ),
              ProfileSummaryRow(
                label: s.bookingInsuranceLabel,
                value: _includeInsurance
                    ? s.bookingInsuranceIncludedLabel
                    : s.bookingInsuranceNotIncludedLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openInsuranceSheet(context),
                  child: Text(s.bookingInsuranceAction),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openPricingBreakdown(context, quote),
                  child: Text(s.bookingPricingBreakdownAction),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthSubmitButton(
            label: s.bookingConfirmAction,
            isLoading: _isSubmitting,
            onPressed: () =>
                unawaited(_confirmBooking(context, bookingSelection, quote)),
          ),
        ],
      ),
    );
  }

  void _openInsuranceSheet(BuildContext context) {
    final s = S.of(context);
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setModalState) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    s.bookingInsuranceAction,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(s.bookingInsuranceIncludedLabel),
                    subtitle: Text(s.bookingInsuranceDescription),
                    value: _includeInsurance,
                    onChanged: (value) {
                      setModalState(() => _includeInsurance = value);
                      setState(() => _includeInsurance = value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(s.confirmLabel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openPricingBreakdown(BuildContext context, BookingPricingQuote quote) {
    final s = S.of(context);
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: MoneySummaryCard(
              title: s.bookingPricingBreakdownAction,
              lines: [
                MoneySummaryLine(
                  label: s.bookingBasePriceLabel,
                  amount: _money(s, quote.basePriceDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingPlatformFeeLabel,
                  amount: _money(s, quote.platformFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingCarrierFeeLabel,
                  amount: _money(s, quote.carrierFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingInsuranceFeeLabel,
                  amount: _money(s, quote.insuranceFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingTaxFeeLabel,
                  amount: _money(s, quote.taxFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingCarrierPayoutLabel,
                  amount: _money(s, quote.carrierPayoutDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingTotalLabel,
                  amount: _money(s, quote.shipperTotalDzd),
                  emphasis: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmBooking(
    BuildContext context,
    BookingReviewSelection bookingSelection,
    BookingPricingQuote quote,
  ) async {
    final s = S.of(context);
    setState(() => _isSubmitting = true);
    try {
      final booking = await ref
          .read(bookingWorkflowControllerProvider)
          .createBooking(
            shipment: bookingSelection.shipment,
            result: bookingSelection.result,
            includeInsurance: _includeInsurance,
          );
      if (!context.mounted) return;
      AppFeedback.showSnackBar(context, s.bookingCreatedMessage);
      context.go(AppRoutePath.shipperPaymentFlow, extra: booking.id);
    } on PostgrestException catch (error) {
      if (context.mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class PaymentFlowScreen extends ConsumerStatefulWidget {
  const PaymentFlowScreen({
    super.key,
    this.bookingId,
    this.includePageScaffold = true,
  });

  final String? bookingId;
  final bool includePageScaffold;

  @override
  ConsumerState<PaymentFlowScreen> createState() => _PaymentFlowScreenState();
}

class _PaymentFlowScreenState extends ConsumerState<PaymentFlowScreen> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final id = widget.bookingId;
    if (id == null) {
      if (widget.includePageScaffold) {
        return AppPageScaffold(
          title: s.paymentFlowTitle,
          child: const AppNotFoundState(),
        );
      }
      return const AppNotFoundState();
    }
    final bookingAsync = ref.watch(bookingDetailProvider(id));
    final settingsAsync = ref.watch(clientSettingsProvider);
    final proofsAsync = ref.watch(paymentProofsForBookingProvider(id));
    final documentsAsync = ref.watch(generatedDocumentsForBookingProvider(id));

    final content = AppAsyncStateView<BookingRecord?>(
      value: bookingAsync,
      onRetry: () => ref.invalidate(bookingDetailProvider(id)),
      data: (booking) {
        if (booking == null) return const AppNotFoundState();
        final paymentAccounts = _paymentAccountsFromSettings(
          settingsAsync.asData?.value,
        );
        final latestProof = proofsAsync.asData?.value.firstOrNull;
        final canUploadProof =
            latestProof == null || latestProof.status == 'rejected';
        return ListView(
          key: const PageStorageKey<String>('shipper-payment-flow-screen'),
          children: [
            AppSectionHeader(
              title: s.paymentFlowTitle,
              subtitle: s.paymentFlowDescription,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileSummaryCard(
              title: s.bookingReviewTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.bookingPaymentReferenceLabel,
                  value: BidiFormatters.latinIdentifier(
                    booking.paymentReference,
                  ),
                ),
                ProfileSummaryRow(
                  label: s.bookingTrackingNumberLabel,
                  value: BidiFormatters.latinIdentifier(
                    booking.trackingNumber,
                  ),
                ),
                ProfileSummaryRow(
                  label: s.bookingTotalLabel,
                  value: _money(
                    s,
                    BookingPricingQuote(
                      pricePerKgDzd: booking.pricePerKgDzd,
                      basePriceDzd: booking.basePriceDzd,
                      platformFeeDzd: booking.platformFeeDzd,
                      carrierFeeDzd: booking.carrierFeeDzd,
                      insuranceRate: booking.insuranceRate,
                      insuranceFeeDzd: booking.insuranceFeeDzd,
                      taxFeeDzd: booking.taxFeeDzd,
                      shipperTotalDzd: booking.shipperTotalDzd,
                      carrierPayoutDzd: booking.carrierPayoutDzd,
                    ).shipperTotalDzd,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            MoneySummaryCard(
              title: s.bookingPricingBreakdownAction,
              lines: [
                MoneySummaryLine(
                  label: s.bookingBasePriceLabel,
                  amount: _money(s, booking.basePriceDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingPlatformFeeLabel,
                  amount: _money(s, booking.platformFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingCarrierFeeLabel,
                  amount: _money(s, booking.carrierFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingInsuranceFeeLabel,
                  amount: _money(s, booking.insuranceFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingTaxFeeLabel,
                  amount: _money(s, booking.taxFeeDzd),
                ),
                MoneySummaryLine(
                  label: s.bookingTotalLabel,
                  amount: _money(s, booking.shipperTotalDzd),
                  emphasis: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AuthInfoBanner(
              message: _paymentFlowGuidanceMessage(s, booking, latestProof),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.paymentProofSectionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            if (latestProof != null)
              ProfileSummaryCard(
                title: s.paymentProofLatestTitle,
                rows: [
                  ProfileSummaryRow(
                    label: s.paymentProofStatusLabel,
                    value: _paymentProofStatusLabel(s, latestProof.status),
                  ),
                  ProfileSummaryRow(
                    label: s.paymentProofAmountLabel,
                    value: _money(s, latestProof.submittedAmountDzd),
                  ),
                  ProfileSummaryRow(
                    label: s.paymentProofReferenceLabel,
                    value: latestProof.submittedReference ?? '-',
                  ),
                  if ((latestProof.rejectionReason ?? '').isNotEmpty)
                    ProfileSummaryRow(
                      label: s.paymentProofRejectionReasonLabel,
                      value: latestProof.rejectionReason!,
                    ),
                ],
              )
            else
              AppStateMessage(
                icon: Icons.receipt_long_outlined,
                title: s.paymentProofLatestTitle,
                message: s.paymentProofEmptyMessage,
              ),
            const SizedBox(height: AppSpacing.md),
            if (booking.bookingStatus == BookingStatus.deliveredPendingReview) ...[
              FilledButton(
                onPressed: () => unawaited(_confirmDelivery(booking)),
                child: Text(s.deliveryConfirmAction),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Row(
              children: [
                if (canUploadProof)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isUploading
                          ? null
                          : () => unawaited(_uploadProof(context, booking)),
                      child: Text(
                        latestProof?.status == 'rejected'
                            ? s.paymentProofResubmitAction
                            : s.paymentProofUploadAction,
                      ),
                    ),
                  ),
                if (_canShipperCancelPendingBooking(booking)) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isUploading
                          ? null
                          : () => unawaited(_cancelBooking(booking)),
                      child: Text(s.cancelLabel),
                    ),
                  ),
                ],
                if (latestProof != null) ...[
                  if (canUploadProof || _canShipperCancelPendingBooking(booking))
                    const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.push(
                        AppRoutePath.sharedProofViewer.replaceFirst(
                          ':id',
                          latestProof.id,
                        ),
                      ),
                      child: Text(s.documentViewerOpenAction),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            proofsAsync.when(
              data: (proofs) => proofs.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: proofs
                          .map(
                            (proof) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: AppListCard(
                                title:
                                    '${_paymentProofStatusLabel(s, proof.status)} • ${_money(s, proof.submittedAmountDzd)}',
                                subtitle: _formatDateTime(
                                  context,
                                  proof.submittedAt,
                                ),
                                onTap: () => context.push(
                                  AppRoutePath.sharedProofViewer.replaceFirst(
                                    ':id',
                                    proof.id,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(growable: false),
                    ),
              loading: () => const AppLoadingState(),
              error: (error, stackTrace) => AppErrorState(
                error: AppError(
                  code: 'payment_proofs_load_failed',
                  message: mapAppErrorMessage(s, error),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.paymentInstructionsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            ProfileSummaryCard(
              title: s.paymentInstructionsTitle,
              rows: [
                ProfileSummaryRow(
                  label: s.bookingTotalLabel,
                  value: _money(s, booking.shipperTotalDzd),
                ),
                ProfileSummaryRow(
                  label: s.bookingPaymentReferenceLabel,
                  value: BidiFormatters.latinIdentifier(
                    booking.paymentReference,
                  ),
                ),
                ProfileSummaryRow(
                  label: s.paymentProofStatusLabel,
                  value: latestProof == null
                      ? s.paymentStatusUnpaidLabel
                      : _paymentProofStatusLabel(s, latestProof.status),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ...paymentAccounts.map(
              (account) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppListCard(
                  title: account.displayName,
                  subtitle:
                      '${account.accountIdentifier} • ${account.accountHolderName}',
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              s.generatedDocumentsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(s.generatedDocumentsTapReadyHint),
            const SizedBox(height: AppSpacing.sm),
            documentsAsync.when(
              data: (documents) => documents.isEmpty
                  ? AppStateMessage(
                      icon: Icons.description_outlined,
                      title: s.generatedDocumentsTitle,
                      message: s.generatedDocumentsEmptyMessage,
                    )
                  : Column(
                      children: documents
                          .map(
                            (document) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: AppListCard(
                                title: _generatedDocumentTypeLabel(
                                  s,
                                  document.documentType,
                                ),
                                subtitle: _generatedDocumentSubtitle(
                                  context,
                                  s,
                                  document,
                                ),
                                leading: AppStatusChip(
                                  label: _generatedDocumentStatusLabel(
                                    s,
                                    document,
                                  ),
                                  tone: _generatedDocumentStatusTone(
                                    document,
                                  ),
                                ),
                                trailing: document.isReady
                                    ? const Icon(Icons.chevron_right_rounded)
                                    : document.isPending
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.error_outline_rounded),
                                onTap: document.isReady
                                    ? () => context.push(
                                        AppRoutePath.sharedGeneratedDocumentViewer
                                            .replaceFirst(':id', document.id),
                                      )
                                    : null,
                              ),
                            ),
                          )
                          .toList(growable: false),
                    ),
              loading: () => const AppLoadingState(),
              error: (error, stackTrace) => AppErrorState(
                error: AppError(
                  code: 'generated_documents_load_failed',
                  message: mapAppErrorMessage(s, error),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (!widget.includePageScaffold) {
      return content;
    }

    return AppPageScaffold(
      title: s.paymentFlowTitle,
      child: content,
    );
  }

  Future<void> _uploadProof(BuildContext context, BookingRecord booking) async {
    final s = S.of(context);
    final settings = ref.read(clientSettingsProvider).asData?.value;
    final paymentAccounts = _paymentAccountsFromSettings(settings);
    var paymentRail =
        paymentAccounts.firstOrNull?.displayName.toLowerCase().contains(
              'dahab',
            ) ==
            true
        ? 'dahabia'
        : paymentAccounts.firstOrNull?.displayName.toLowerCase().contains(
                'bank',
              ) ==
              true
        ? 'bank'
        : 'ccp';
    final amountController = TextEditingController(
      text: booking.shipperTotalDzd.toStringAsFixed(0),
    );
    final referenceController = TextEditingController(
      text: booking.paymentReference,
    );

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.paymentProofUploadAction,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                initialValue: paymentRail,
                items: [
                  DropdownMenuItem(
                    value: 'ccp',
                    child: Text(s.paymentRailCcpLabel),
                  ),
                  DropdownMenuItem(
                    value: 'dahabia',
                    child: Text(s.paymentRailDahabiaLabel),
                  ),
                  DropdownMenuItem(
                    value: 'bank',
                    child: Text(s.paymentRailBankLabel),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setModalState(() => paymentRail = value);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: amountController,
                label: s.paymentProofAmountLabel,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: referenceController,
                label: s.paymentProofReferenceLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(s.confirmLabel),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true) {
      amountController.dispose();
      referenceController.dispose();
      return;
    }

    final submittedAmount = _tryParseMoneyAmount(amountController.text);
    if (submittedAmount == null || submittedAmount <= 0) {
      amountController.dispose();
      referenceController.dispose();
      if (mounted) {
        AppFeedback.showSnackBar(this.context, s.vehiclePositiveNumberMessage);
      }
      return;
    }

    setState(() => _isUploading = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        withData: kIsWeb,
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (result == null) return;
      final file = result.files.single;
      final extension = (file.extension ?? '').toLowerCase();
      final contentType = switch (extension) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        _ => 'application/pdf',
      };
      final draft = VerificationUploadDraft(
        path: file.path ?? file.name,
        filename: file.name,
        extension: extension,
        contentType: contentType,
        byteSize: file.size,
        bytes: file.bytes,
      );
      await ref
          .read(paymentProofRepositoryProvider)
          .uploadPaymentProof(
            bookingId: booking.id,
            paymentRail: paymentRail,
            draft: draft,
            submittedAmountDzd: submittedAmount,
            submittedReference: referenceController.text,
          );
      ref
        ..invalidate(paymentProofsForBookingProvider(booking.id))
        ..invalidate(bookingDetailProvider(booking.id))
        ..invalidate(trackingEventsProvider(booking.id))
        ..invalidate(myShipperBookingsProvider)
        ..invalidate(myShipperShipmentsProvider)
        ..invalidate(shipmentDetailProvider(booking.shipmentId))
        ..invalidate(myNotificationsProvider);
      if (!mounted) return;
      AppFeedback.showSnackBar(this.context, s.paymentProofUploadedMessage);
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(this.context, mapAppErrorMessage(s, error));
      }
    } finally {
      amountController.dispose();
      referenceController.dispose();
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _cancelBooking(BookingRecord booking) async {
    final confirmed = await _confirmBookingCancel(context);
    if (confirmed != true || !mounted) {
      return;
    }

    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .shipperCancelPendingBooking(
            bookingId: booking.id,
            shipmentId: booking.shipmentId,
          );
      ref
        ..invalidate(myShipperBookingsProvider)
        ..invalidate(myShipperShipmentsProvider)
        ..invalidate(bookingDetailProvider(booking.id))
        ..invalidate(shipmentDetailProvider(booking.shipmentId));
      if (!mounted) return;
      final s = S.of(context);
      AppFeedback.showSnackBar(context, s.bookingStatusCancelledLabel);
      context.go(AppRoutePath.shipperSearch);
    } on PostgrestException catch (error) {
      if (mounted) {
        final s = S.of(context);
        AppFeedback.showSnackBar(
          context,
          mapAppErrorMessage(s, error),
        );
      }
    }
  }

  Future<void> _confirmDelivery(BookingRecord booking) async {
    final s = S.of(context);
    try {
      await ref
          .read(bookingWorkflowControllerProvider)
          .shipperConfirmDelivery(
            bookingId: booking.id,
            shipmentId: booking.shipmentId,
          );
      ref
        ..invalidate(myShipperBookingsProvider)
        ..invalidate(bookingDetailProvider(booking.id))
        ..invalidate(shipmentDetailProvider(booking.shipmentId));
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.deliveryConfirmedMessage);
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    }
  }
}

double? _tryParseMoneyAmount(String value) {
  final normalized = value.trim().replaceAll(',', '.');
  if (normalized.isEmpty) {
    return null;
  }
  return double.tryParse(normalized);
}

class _ShipmentEditorSheet extends ConsumerStatefulWidget {
  const _ShipmentEditorSheet({this.shipment});

  final ShipmentDraftRecord? shipment;

  @override
  ConsumerState<_ShipmentEditorSheet> createState() =>
      _ShipmentEditorSheetState();
}

class _ShipmentEditorSheetState extends ConsumerState<_ShipmentEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _volumeController = TextEditingController();
  final _detailsController = TextEditingController();

  int? _originWilayaId;
  int? _originCommuneId;
  int? _destinationWilayaId;
  int? _destinationCommuneId;
  bool _isSaving = false;
  bool _initialized = false;
  String? _lastLocationDebugSnapshot;

  @override
  void dispose() {
    _weightController.dispose();
    _volumeController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _debugLocationPicker(String message) {
    if (!kDebugMode) {
      return;
    }
    debugPrint('[ShipmentLocationPicker] $message');
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
        ' originCommune=$_originCommuneId'
        ' originCommunes=${originCommunes.length}'
        ' originLoading=$isOriginCommunesLoading'
        ' destinationWilaya=$resolvedDestinationWilayaId'
        ' destinationCommune=$_destinationCommuneId'
        ' destinationCommunes=${destinationCommunes.length}'
        ' destinationLoading=$isDestinationCommunesLoading';
    if (snapshot == _lastLocationDebugSnapshot) {
      return;
    }
    _lastLocationDebugSnapshot = snapshot;
    _debugLocationPicker(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (!_initialized) {
      final shipment = widget.shipment;
      _originCommuneId = shipment?.originCommuneId;
      _originWilayaId = null;
      _destinationCommuneId = shipment?.destinationCommuneId;
      _destinationWilayaId = null;
      _weightController.text = shipment?.totalWeightKg.toStringAsFixed(0) ?? '';
      _volumeController.text = shipment?.totalVolumeM3?.toString() ?? '';
      _detailsController.text = shipment?.details ?? '';
      _initialized = true;
    }

    final wilayasAsync = ref.watch(wilayasProvider);
    final originSeedAsync = _originWilayaId == null && _originCommuneId != null
        ? ref.watch(communeByIdProvider(_originCommuneId!))
        : null;
    final destinationSeedAsync =
        _destinationWilayaId == null && _destinationCommuneId != null
        ? ref.watch(communeByIdProvider(_destinationCommuneId!))
        : null;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: AppFocusTraversal.sheet(
        child: Builder(
          builder: (context) {
            final initialLocationError =
                wilayasAsync.error ??
                originSeedAsync?.error ??
                destinationSeedAsync?.error;

            if (initialLocationError != null) {
              _debugLocationPicker(
                'initial location load failed: $initialLocationError',
              );
              return AppErrorState(
                error: AppError(
                  code: 'shipment_locations_load_failed',
                  message: mapAppErrorMessage(s, initialLocationError),
                ),
                onRetry: () {
                  ref.invalidate(wilayasProvider);
                  if (_originCommuneId != null) {
                    ref.invalidate(communeByIdProvider(_originCommuneId!));
                  }
                  if (_destinationCommuneId != null) {
                    ref.invalidate(
                      communeByIdProvider(_destinationCommuneId!),
                    );
                  }
                },
              );
            }

            if (wilayasAsync.isLoading ||
                originSeedAsync?.isLoading == true ||
                destinationSeedAsync?.isLoading == true) {
              return const AppLoadingState();
            }

            final resolvedOriginWilayaId =
                _originWilayaId ?? originSeedAsync?.asData?.value?.wilayaId;
            final resolvedDestinationWilayaId =
                _destinationWilayaId ??
                destinationSeedAsync?.asData?.value?.wilayaId;

            _originWilayaId = resolvedOriginWilayaId;
            _destinationWilayaId = resolvedDestinationWilayaId;

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
                  code: 'shipment_communes_by_wilaya_failed',
                  message: mapAppErrorMessage(s, communeOptionsError),
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

            final wilayas = wilayasAsync.requireValue;
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
              wilayas: wilayas,
              resolvedOriginWilayaId: resolvedOriginWilayaId,
              resolvedDestinationWilayaId: resolvedDestinationWilayaId,
              originCommunes: originCommunes,
              destinationCommunes: destinationCommunes,
              isOriginCommunesLoading: isOriginCommunesLoading,
              isDestinationCommunesLoading: isDestinationCommunesLoading,
            );

            return Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    widget.shipment == null
                        ? s.shipmentCreateTitle
                        : s.shipmentEditTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _WilayaPickerField(
                    label: s.routeOriginWilayaLabel,
                    value: _originWilayaId,
                    wilayas: wilayas,
                    onChanged: (value) => setState(() {
                      _debugLocationPicker(
                        'origin wilaya changed: $value -> reset origin commune',
                      );
                      _originWilayaId = value;
                      _originCommuneId = null;
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CommunePickerField(
                    label: s.routeOriginLabel,
                    value: _originCommuneId,
                    enabled: resolvedOriginWilayaId != null,
                    isLoading: isOriginCommunesLoading,
                    communeOptions: originCommunes,
                    onChanged: (value) => setState(() {
                      _debugLocationPicker('origin commune changed: $value');
                      _originCommuneId = value;
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _WilayaPickerField(
                    label: s.routeDestinationWilayaLabel,
                    value: _destinationWilayaId,
                    wilayas: wilayas,
                    onChanged: (value) => setState(() {
                      _debugLocationPicker(
                        'destination wilaya changed: $value -> reset destination commune',
                      );
                      _destinationWilayaId = value;
                      _destinationCommuneId = null;
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CommunePickerField(
                    label: s.routeDestinationLabel,
                    value: _destinationCommuneId,
                    enabled: resolvedDestinationWilayaId != null,
                    isLoading: isDestinationCommunesLoading,
                    communeOptions: destinationCommunes,
                    onChanged: (value) => setState(() {
                      _debugLocationPicker(
                        'destination commune changed: $value',
                      );
                      _destinationCommuneId = value;
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _weightController,
                    label: s.vehicleCapacityWeightLabel,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _positiveValidator,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _volumeController,
                    label: s.vehicleCapacityVolumeLabel,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _optionalPositiveValidator,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _detailsController,
                    label: s.shipmentDescriptionLabel,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AuthSubmitButton(
                    label: widget.shipment == null
                        ? s.shipmentCreateAction
                        : s.shipmentSaveAction,
                    isLoading: _isSaving,
                    onPressed: () => unawaited(_save()),
                  ),
                  if (widget.shipment != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton(
                      onPressed: _isSaving ? null : () => unawaited(_delete()),
                      child: Text(s.shipmentDeleteAction),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _save() async {
    final s = S.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_originCommuneId == null || _destinationCommuneId == null) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    if (_originCommuneId == _destinationCommuneId) {
      AppFeedback.showSnackBar(context, s.publicationSameLaneErrorMessage);
      return;
    }
    setState(() => _isSaving = true);
    try {
      final input = ShipmentDraftInput(
        originCommuneId: _originCommuneId!,
        destinationCommuneId: _destinationCommuneId!,
        totalWeightKg: double.parse(_weightController.text.trim()),
        totalVolumeM3: _parseOptional(_volumeController.text),
        details: _detailsController.text,
      );
      final workflow = ref.read(shipmentWorkflowControllerProvider);
      if (widget.shipment == null) {
        await workflow.createShipmentDraft(input);
      } else {
        await workflow.updateShipmentDraft(
          shipmentId: widget.shipment!.id,
          input: input,
        );
      }
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.shipmentSavedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _delete() async {
    final shipment = widget.shipment;
    if (shipment == null) return;
    final s = S.of(context);
    final confirmed = await _confirmShipmentDelete(context);
    if (confirmed != true) return;
    setState(() => _isSaving = true);
    try {
      await ref
          .read(shipmentWorkflowControllerProvider)
          .deleteShipmentDraft(shipment.id);
      if (!mounted) return;
      AppFeedback.showSnackBar(context, s.shipmentDeletedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String? _positiveValidator(String? value) {
    final s = S.of(context);
    if ((value ?? '').trim().isEmpty) {
      return s.authRequiredFieldMessage;
    }
    return validatePositiveNumberField(
      s,
      value,
      invalidMessage: s.vehiclePositiveNumberMessage,
    );
  }

  String? _optionalPositiveValidator(String? value) {
    return validateOptionalPositiveNumberField(
      S.of(context),
      value,
      invalidMessage: S.of(context).vehiclePositiveNumberMessage,
    );
  }

  double? _parseOptional(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return double.tryParse(trimmed);
  }
}

class _SearchResultsSection extends StatelessWidget {
  const _SearchResultsSection({
    required this.shipment,
    required this.response,
    required this.sort,
    required this.includeRecurring,
    required this.includeOneOff,
    required this.onLoadMore,
  });

  final ShipmentDraftRecord shipment;
  final ShipmentSearchResponse response;
  final SearchSortOption sort;
  final bool includeRecurring;
  final bool includeOneOff;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (response.results.isEmpty) {
      return response.mode == SearchResultMode.redefineSearch
          ? AppEmptyState(
              title: s.searchTripsNoRouteTitle,
              message: s.searchTripsNoRouteMessage,
            )
          : const AppNoExactResultsState();
    }

    final results = response.results
        .where((result) {
          if (result.sourceType == 'route' && !includeRecurring) {
            return false;
          }
          if (result.sourceType == 'oneoff_trip' && !includeOneOff) {
            return false;
          }
          return true;
        })
        .toList(growable: false);

    if (results.isEmpty) {
      return AppEmptyState(
        title: s.searchTripsNoRouteTitle,
        message: s.searchTripsFilterEmptyMessage,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (response.mode == SearchResultMode.nearestDate) ...[
          AppStateMessage(
            icon: Icons.calendar_month_outlined,
            title: s.searchTripsNearestDateTitle,
            message: response.nearestDates.isEmpty
                ? s.noExactResultsMessage
                : s.searchTripsNearestDateMessage(
                    response.nearestDates.map(_formatDate).join(', '),
                  ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Text(
          s.searchTripsResultsTitle(
            BidiFormatters.latinIdentifier('${response.totalCount}'),
          ),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.insights_outlined),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    _searchRecommendationSummary(s, sort),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final result = results[index];
            final capacitySummary = result.remainingVolumeM3 == null
                ? '${BidiFormatters.latinIdentifier(result.remainingCapacityKg.toStringAsFixed(0))} kg'
                : '${BidiFormatters.latinIdentifier(result.remainingCapacityKg.toStringAsFixed(0))} kg • ${BidiFormatters.latinIdentifier(result.remainingVolumeM3!.toStringAsFixed(1))} m3';
            return AppListCard(
              title: result.carrierName,
              subtitle: [
                _searchResultReasonLine(s, sort, result),
                _formatDateTime(context, result.departureAt),
                '${s.searchEstimatedPriceLabel}: ${BidiFormatters.latinIdentifier(result.estimatedTotalDzd.toStringAsFixed(0))} ${s.priceCurrencyLabel}',
                '${s.vehicleCapacityWeightLabel}: $capacitySummary',
                '${s.searchCarrierRatingLabel}: ${BidiFormatters.latinIdentifier(result.ratingAverage.toStringAsFixed(1))} (${BidiFormatters.latinIdentifier('${result.ratingCount}')})',
              ].join('\n'),
              leading: AppStatusChip(
                label: result.sourceType == 'route'
                    ? s.searchTripsRecurringLabel
                    : s.searchTripsOneOffLabel,
                tone: AppStatusTone.info,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(
                AppRoutePath.shipperBookingReview,
                extra: BookingReviewSelection(
                  shipment: shipment,
                  result: result,
                  requestedDate: result.departureDate,
                ),
              ),
            );
          },
        ),
        if (onLoadMore != null) ...[
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: onLoadMore, child: Text(s.loadMoreLabel)),
        ],
      ],
    );
  }
}

class _CompactShipmentSummaryCard extends StatelessWidget {
  const _CompactShipmentSummaryCard({
    required this.shipment,
    required this.communes,
  });

  final ShipmentDraftRecord shipment;
  final List<AlgeriaCommune> communes;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final communeMap = {for (final commune in communes) commune.id: commune};
    final detail = (shipment.details ?? '').trim();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _shipmentLaneLabel(context, shipment, communeMap),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _SummaryChip(
                  label:
                      '${BidiFormatters.latinIdentifier(shipment.totalWeightKg.toStringAsFixed(0))} kg',
                ),
                if (shipment.totalVolumeM3 != null)
                  _SummaryChip(
                    label:
                        '${BidiFormatters.latinIdentifier(shipment.totalVolumeM3!.toStringAsFixed(1))} m3',
                  ),
              ],
            ),
            if (detail.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${s.shipmentDescriptionLabel}: $detail',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(label),
      ),
    );
  }
}

String _shipmentLaneLabel(
  BuildContext context,
  ShipmentDraftRecord shipment,
  Map<int, AlgeriaCommune> communeMap,
) {
  final locale = Localizations.localeOf(context);
  final origin =
      communeMap[shipment.originCommuneId]?.displayName(locale) ??
      S.of(context).locationUnavailableLabel;
  final destination =
      communeMap[shipment.destinationCommuneId]?.displayName(locale) ??
      S.of(context).locationUnavailableLabel;
  return '$origin -> $destination';
}

String _shipmentSubtitle(BuildContext context, ShipmentDraftRecord shipment) {
  final parts = <String>[
    '${BidiFormatters.latinIdentifier(shipment.totalWeightKg.toStringAsFixed(0))} kg',
  ];
  if (shipment.totalVolumeM3 != null) {
    parts.add(
      '${BidiFormatters.latinIdentifier(shipment.totalVolumeM3!.toStringAsFixed(1))} m3',
    );
  }
  final details = (shipment.details ?? '').trim();
  if (details.isNotEmpty) {
    parts.add(details);
  }
  return parts.join(' • ');
}

String _shipmentOperationalSubtitle(
  BuildContext context,
  ShipmentDraftRecord shipment,
  BookingRecord? booking,
) {
  final s = S.of(context);
  final parts = <String>[
    _shipmentSubtitle(context, shipment),
  ];
  if (booking != null) {
    parts.add(_shipperHomeFocusMessage(s, booking));
  }
  return parts.join('\n');
}

String _shipmentPrimaryStateLabel(
  S s,
  ShipmentDraftRecord shipment,
  BookingRecord? booking,
) {
  if (shipment.status == ShipmentStatus.draft || booking == null) {
    return _shipmentStatusLabel(s, shipment.status);
  }
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => s.paymentStatusUnpaidLabel,
    PaymentStatus.rejected => s.paymentStatusRejectedLabel,
    PaymentStatus.proofSubmitted => s.paymentStatusProofSubmittedLabel,
    PaymentStatus.underVerification => s.paymentStatusUnderVerificationLabel,
    _ => _shipmentStatusLabel(s, shipment.status),
  };
}

AppStatusTone _shipmentPrimaryStateTone(
  ShipmentDraftRecord shipment,
  BookingRecord? booking,
) {
  if (shipment.status == ShipmentStatus.draft || booking == null) {
    return shipment.status == ShipmentStatus.draft
        ? AppStatusTone.info
        : shipment.status == ShipmentStatus.booked
        ? AppStatusTone.success
        : AppStatusTone.warning;
  }
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => AppStatusTone.warning,
    PaymentStatus.rejected => AppStatusTone.danger,
    PaymentStatus.proofSubmitted => AppStatusTone.info,
    PaymentStatus.underVerification => AppStatusTone.info,
    PaymentStatus.secured => AppStatusTone.success,
    PaymentStatus.refunded => AppStatusTone.neutral,
    PaymentStatus.releasedToCarrier => AppStatusTone.success,
  };
}

BookingRecord? _highestPriorityShipperBooking(List<BookingRecord> bookings) {
  if (bookings.isEmpty) {
    return null;
  }
  final ordered = [...bookings]
    ..sort((a, b) => _shipperBookingPriority(a).compareTo(_shipperBookingPriority(b)));
  return ordered.first;
}

int _shipperBookingPriority(BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.unpaid ||
      booking.paymentStatus == PaymentStatus.rejected) {
    return 0;
  }
  if (booking.paymentStatus == PaymentStatus.proofSubmitted ||
      booking.paymentStatus == PaymentStatus.underVerification) {
    return 1;
  }
  if (booking.bookingStatus == BookingStatus.deliveredPendingReview) {
    return 2;
  }
  if (booking.bookingStatus == BookingStatus.confirmed) {
    return 3;
  }
  if (booking.bookingStatus == BookingStatus.pickedUp ||
      booking.bookingStatus == BookingStatus.inTransit) {
    return 4;
  }
  return 5;
}

String _shipperHomeFocusTitle(S s, BookingRecord booking) {
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => s.paymentFlowTitle,
    PaymentStatus.rejected => s.paymentProofResubmitAction,
    PaymentStatus.proofSubmitted => s.paymentStatusProofSubmittedLabel,
    PaymentStatus.underVerification => s.paymentStatusUnderVerificationLabel,
    _ when booking.bookingStatus == BookingStatus.deliveredPendingReview =>
      s.bookingStatusDeliveredPendingReviewLabel,
    _ => s.bookingTrackingNumberLabel,
  };
}

String _shipperHomeFocusMessage(S s, BookingRecord booking) {
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => s.shipperNextActionPayment,
    PaymentStatus.rejected => s.shipperNextActionPayment,
    PaymentStatus.proofSubmitted => s.shipperNextActionReview,
    PaymentStatus.underVerification => s.shipperNextActionReview,
    _ when booking.bookingStatus == BookingStatus.deliveredPendingReview =>
      s.shipperNextActionConfirmDelivery,
    _ => _shipperOperationalSummary(s, booking),
  };
}

String _shipperOperationalSummary(S s, BookingRecord booking) {
  return switch (booking.bookingStatus) {
    BookingStatus.confirmed => s.carrierNextActionPickup,
    BookingStatus.pickedUp => s.carrierNextActionTransit,
    BookingStatus.inTransit => s.carrierNextActionDelivery,
    BookingStatus.completed => s.bookingStatusCompletedLabel,
    BookingStatus.cancelled => s.bookingStatusCancelledLabel,
    BookingStatus.disputed => s.bookingStatusDisputedLabel,
    BookingStatus.paymentUnderReview => s.shipperNextActionReview,
    BookingStatus.pendingPayment => s.shipperNextActionPayment,
    BookingStatus.deliveredPendingReview => s.shipperNextActionConfirmDelivery,
  };
}

AppStatusTone _shipperHomeFocusTone(BookingRecord booking) {
  if (booking.paymentStatus == PaymentStatus.rejected) {
    return AppStatusTone.danger;
  }
  if (booking.paymentStatus == PaymentStatus.unpaid) {
    return AppStatusTone.warning;
  }
  if (booking.paymentStatus == PaymentStatus.proofSubmitted ||
      booking.paymentStatus == PaymentStatus.underVerification) {
    return AppStatusTone.info;
  }
  if (booking.bookingStatus == BookingStatus.deliveredPendingReview) {
    return AppStatusTone.warning;
  }
  return AppStatusTone.success;
}

String _searchRecommendationSummary(S s, SearchSortOption sort) {
  return switch (sort) {
    SearchSortOption.recommended =>
      '${s.searchSortRecommendedLabel}: ${s.searchRecommendationBalancedMessage}',
    SearchSortOption.topRated =>
      '${s.searchSortTopRatedLabel}: ${s.searchRecommendationTopRatedMessage}',
    SearchSortOption.lowestPrice =>
      '${s.searchSortLowestPriceLabel}: ${s.searchRecommendationLowestPriceMessage}',
    SearchSortOption.nearestDeparture =>
      '${s.searchSortNearestDepartureLabel}: ${s.searchRecommendationNearestMessage}',
  };
}

String _searchResultReasonLine(
  S s,
  SearchSortOption sort,
  ShipmentSearchResult result,
) {
  return switch (sort) {
    SearchSortOption.recommended =>
      s.searchRecommendationBalancedResult(
        BidiFormatters.latinIdentifier(result.ratingAverage.toStringAsFixed(1)),
        _formatDate(result.departureDate),
      ),
    SearchSortOption.topRated =>
      s.searchRecommendationTopRatedResult(
        BidiFormatters.latinIdentifier(result.ratingAverage.toStringAsFixed(1)),
        BidiFormatters.latinIdentifier(result.ratingCount.toString()),
      ),
    SearchSortOption.lowestPrice =>
      s.searchRecommendationLowestPriceResult(
        BidiFormatters.latinIdentifier(result.estimatedTotalDzd.toStringAsFixed(0)),
      ),
    SearchSortOption.nearestDeparture =>
      s.searchRecommendationNearestResult(_formatDate(result.departureDate)),
  };
}

class _OperationalFocusCard extends StatelessWidget {
  const _OperationalFocusCard({
    required this.title,
    required this.message,
    required this.tone,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String message;
  final AppStatusTone tone;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStatusChip(label: title, tone: tone),
            const SizedBox(height: AppSpacing.sm),
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: Text(buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> _confirmShipmentDelete(BuildContext context) {
  final s = S.of(context);
  return showDialog<bool>(
    context: context,
    builder: (context) => AppFocusTraversal.dialog(
      child: AlertDialog(
        title: Text(s.shipmentDeleteAction),
        content: Text(s.shipmentDeleteConfirmationMessage),
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

Future<bool?> _confirmBookingCancel(BuildContext context) {
  final s = S.of(context);
  return showDialog<bool>(
    context: context,
    builder: (context) => AppFocusTraversal.dialog(
      child: AlertDialog(
        title: Text(s.bookingStatusCancelledLabel),
        content: Text(s.paymentFlowDescription),
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

bool _canOpenShipperBookingWorkspace(BookingRecord booking) {
  return booking.bookingStatus != BookingStatus.cancelled;
}

bool _canShipperCancelPendingBooking(BookingRecord booking) {
  return booking.bookingStatus == BookingStatus.pendingPayment &&
      (booking.paymentStatus == PaymentStatus.unpaid ||
          booking.paymentStatus == PaymentStatus.rejected);
}

String _shipperWorkspaceActionLabel(S s, BookingRecord booking) {
  if (booking.bookingStatus == BookingStatus.deliveredPendingReview) {
    return s.deliveryConfirmAction;
  }
  return switch (booking.paymentStatus) {
    PaymentStatus.unpaid => s.paymentFlowTitle,
    PaymentStatus.rejected => s.paymentProofResubmitAction,
    PaymentStatus.proofSubmitted => s.paymentFlowOpenAction,
    PaymentStatus.underVerification => s.paymentFlowOpenAction,
    PaymentStatus.secured => s.paymentFlowOpenAction,
    PaymentStatus.refunded => s.paymentStatusRefundedLabel,
    PaymentStatus.releasedToCarrier => s.paymentStatusReleasedToCarrierLabel,
  };
}

String _shipmentSelectorLabel(
  BuildContext context,
  ShipmentDraftRecord shipment,
  List<AlgeriaCommune> communes,
) {
  final communeMap = {for (final commune in communes) commune.id: commune};
  final lane = _shipmentLaneLabel(context, shipment, communeMap);
  return '$lane • ${BidiFormatters.latinIdentifier(shipment.totalWeightKg.toStringAsFixed(0))} kg';
}

String _shipmentStatusLabel(S s, ShipmentStatus status) {
  return switch (status) {
    ShipmentStatus.booked => s.shipmentStatusBookedLabel,
    ShipmentStatus.cancelled => s.shipmentStatusCancelledLabel,
    ShipmentStatus.draft => s.shipmentStatusDraftLabel,
  };
}

String _formatDate(DateTime value) {
  return BidiFormatters.latinIdentifier(
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}',
  );
}

String _formatDateTime(BuildContext context, DateTime value) {
  return '${_formatDate(value)} • ${TimeOfDay.fromDateTime(value).format(context)}';
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

String _money(S s, double amount) {
  return '${BidiFormatters.latinIdentifier(amount.toStringAsFixed(0))} ${s.priceCurrencyLabel}';
}

List<_PlatformPaymentAccountView> _paymentAccountsFromSettings(
  ClientSettings? settings,
) {
  final raw =
      settings?.paymentAccounts ?? const <PlatformPaymentAccountSettings>[];
  return raw
      .map(
        (item) => _PlatformPaymentAccountView(
          displayName: item.displayName,
          accountIdentifier: item.accountIdentifier,
          accountHolderName: item.accountHolderName,
        ),
      )
      .toList(growable: false);
}

String _paymentProofStatusLabel(S s, String status) {
  return switch (status) {
    'verified' => s.paymentProofStatusVerifiedLabel,
    'rejected' => s.paymentProofStatusRejectedLabel,
    _ => s.paymentProofStatusPendingLabel,
  };
}

String _paymentFlowGuidanceMessage(
  S s,
  BookingRecord booking,
  PaymentProofRecord? latestProof,
) {
  if (latestProof?.status == 'rejected') {
    return latestProof?.rejectionReason?.trim().isNotEmpty == true
        ? s.paymentFlowRejectedGuidanceWithReason(latestProof!.rejectionReason!)
        : s.paymentFlowRejectedGuidance;
  }
  if (latestProof != null) {
    return switch (latestProof.status) {
      'verified' => s.paymentFlowSecuredGuidance,
      _ => s.paymentFlowSubmittedGuidance,
    };
  }
  return s.paymentFlowExactTransferGuidance(
    BidiFormatters.latinIdentifier(booking.shipperTotalDzd.toStringAsFixed(0)),
    BidiFormatters.latinIdentifier(booking.paymentReference),
  );
}

String _generatedDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'payment_receipt' => s.generatedDocumentTypePaymentReceipt,
    'payout_receipt' => s.generatedDocumentTypePayoutReceipt,
    _ => s.generatedDocumentsTitle,
  };
}

String _generatedDocumentSubtitle(
  BuildContext context,
  S s,
  GeneratedDocumentRecord document,
) {
  final detail = switch (document.status) {
    GeneratedDocumentStatus.pending => s.generatedDocumentPendingMessage,
    GeneratedDocumentStatus.failed => s.generatedDocumentFailedMessage,
    GeneratedDocumentStatus.ready =>
      document.availableAt == null
          ? s.verificationDocumentOpenPreparedMessage
          : '${s.generatedDocumentAvailableAtLabel}: ${_formatDateTime(context, document.availableAt!)}',
  };

  return '${_generatedDocumentStatusLabel(s, document)} • $detail';
}

String _generatedDocumentStatusLabel(S s, GeneratedDocumentRecord document) {
  return switch (document.status) {
    GeneratedDocumentStatus.ready => s.statusReadyLabel,
    GeneratedDocumentStatus.failed => s.generatedDocumentStatusFailedLabel,
    GeneratedDocumentStatus.pending => s.generatedDocumentStatusPendingLabel,
  };
}

AppStatusTone _generatedDocumentStatusTone(GeneratedDocumentRecord document) {
  return switch (document.status) {
    GeneratedDocumentStatus.ready => AppStatusTone.success,
    GeneratedDocumentStatus.failed => AppStatusTone.danger,
    GeneratedDocumentStatus.pending => AppStatusTone.warning,
  };
}

class _PlatformPaymentAccountView {
  const _PlatformPaymentAccountView({
    required this.displayName,
    required this.accountIdentifier,
    required this.accountHolderName,
  });

  final String displayName;
  final String accountIdentifier;
  final String accountHolderName;
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
