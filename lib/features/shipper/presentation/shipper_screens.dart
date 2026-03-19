import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
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

class MyShipmentsScreen extends ConsumerWidget {
  const MyShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final shipmentsAsync = ref.watch(myShipperShipmentsProvider);
    final communesAsync = ref.watch(communesProvider);

    return AppPageScaffold(
      title: s.myShipmentsTitle,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openShipmentEditor(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(s.shipmentCreateAction),
      ),
      child: AppAsyncStateView<List<ShipmentDraftRecord>>(
        value: shipmentsAsync,
        onRetry: () => ref.invalidate(myShipperShipmentsProvider),
        data: (shipments) {
          if (shipments.isEmpty) {
            return AppEmptyState(
              title: s.myShipmentsTitle,
              message: s.shipmentsEmptyMessage,
              action: FilledButton(
                onPressed: () => _openShipmentEditor(context),
                child: Text(s.shipmentCreateAction),
              ),
            );
          }
          if (communesAsync.isLoading) {
            return const AppLoadingState();
          }
          if (communesAsync.hasError) {
            return AppErrorState(
              error: AppError(
                code: 'shipment_communes_load_failed',
                message: mapAppErrorMessage(s, communesAsync.error ?? Exception('unknown')),
              ),
              onRetry: () => ref.invalidate(communesProvider),
            );
          }
          final communeMap = {
            for (final commune in communesAsync.requireValue) commune.id: commune,
          };

          return ListView.separated(
            key: const PageStorageKey<String>('shipper-shipments-list'),
            itemCount: shipments.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final shipment = shipments[index];
              return AppListCard(
                title: _shipmentLaneLabel(context, shipment, communeMap),
                subtitle: _shipmentSubtitle(context, shipment),
                leading: AppStatusChip(
                  label: _shipmentStatusLabel(s, shipment.status),
                  tone: shipment.status == ShipmentStatus.draft
                      ? AppStatusTone.info
                      : shipment.status == ShipmentStatus.booked
                          ? AppStatusTone.success
                          : AppStatusTone.warning,
                ),
                trailing: IconButton(
                  onPressed: shipment.status == ShipmentStatus.draft
                      ? () => _openShipmentEditor(context, shipment: shipment)
                      : null,
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: s.shipmentEditAction,
                ),
                onTap: () => context.push(
                  AppRoutePath.sharedShipmentDetail.replaceFirst(':id', shipment.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openShipmentEditor(BuildContext context, {ShipmentDraftRecord? shipment}) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _ShipmentEditorSheet(shipment: shipment),
      ),
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
    final communesAsync = ref.watch(communesProvider);

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
          _selectedShipmentId ??= draftShipments.first.id;
          final selectedShipment = draftShipments.firstWhere(
            (shipment) => shipment.id == _selectedShipmentId,
            orElse: () => draftShipments.first,
          );
          _requestedDate ??= DateTime(
            selectedShipment.pickupWindowStart.year,
            selectedShipment.pickupWindowStart.month,
            selectedShipment.pickupWindowStart.day,
          );

          return ListView(
            key: const PageStorageKey<String>('shipper-search-screen'),
            children: [
              AppSectionHeader(
                title: s.searchTripsTitle,
                subtitle: s.searchTripsDescription,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _selectedShipmentId,
                      decoration: InputDecoration(labelText: s.searchShipmentSelectorLabel),
                      items: draftShipments
                          .map(
                            (shipment) => DropdownMenuItem(
                              value: shipment.id,
                              child: Text(_shipmentCompactLabel(context, shipment)),
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
                          _requestedDate = DateTime(
                            nextShipment.pickupWindowStart.year,
                            nextShipment.pickupWindowStart.month,
                            nextShipment.pickupWindowStart.day,
                          );
                          _response = null;
                        });
                        _scheduleSearch(nextShipment, reset: true);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DateButtonField(
                      label: s.searchRequestedDateLabel,
                      value: _requestedDate == null ? null : _formatDate(_requestedDate!),
                      onPressed: () => unawaited(_pickRequestedDate(context)),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ProfileSummaryCard(
                      title: s.searchShipmentSummaryTitle,
                      rows: [
                        ProfileSummaryRow(
                          label: s.routeOriginLabel,
                          value: _communeName(
                            context,
                            communesAsync.asData?.value,
                            selectedShipment.originCommuneId,
                          ),
                        ),
                        ProfileSummaryRow(
                          label: s.routeDestinationLabel,
                          value: _communeName(
                            context,
                            communesAsync.asData?.value,
                            selectedShipment.destinationCommuneId,
                          ),
                        ),
                        ProfileSummaryRow(
                          label: s.vehicleCapacityWeightLabel,
                          value:
                              '${BidiFormatters.latinIdentifier(selectedShipment.totalWeightKg.toStringAsFixed(0))} kg',
                        ),
                        ProfileSummaryRow(
                          label: s.vehicleCapacityVolumeLabel,
                          value: selectedShipment.totalVolumeM3 == null
                              ? '-'
                              : BidiFormatters.latinIdentifier(
                                  selectedShipment.totalVolumeM3!.toStringAsFixed(1),
                                ),
                        ),
                        ProfileSummaryRow(
                          label: s.shipmentCategoryLabel,
                          value: selectedShipment.category,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AuthSubmitButton(
                      label: s.searchTripsAction,
                      isLoading: _isSearching,
                      onPressed: () => _scheduleSearch(selectedShipment, reset: true),
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
                        onPressed: () => unawaited(_openSearchControlsSheet(context)),
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
          );
        },
      ),
    );
  }

  Future<void> _pickRequestedDate(BuildContext context) async {
    final initial = _requestedDate ?? DateTime.now();
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: initial,
    );
    if (selected == null || !mounted) {
      return;
    }
    final shipment = ref.read(myShipperShipmentsProvider).asData?.value.firstWhere(
          (item) => item.id == _selectedShipmentId,
          orElse: () => ShipmentDraftRecord(
            id: '',
            shipperId: '',
            originCommuneId: 0,
            destinationCommuneId: 0,
            pickupWindowStart: selected,
            pickupWindowEnd: selected.add(const Duration(hours: 1)),
            totalWeightKg: 1,
            totalVolumeM3: null,
            category: '',
            description: null,
            status: ShipmentStatus.draft,
            createdAt: null,
            updatedAt: null,
            items: const <ShipmentItemDraft>[],
          ),
        );
    setState(() => _requestedDate = selected);
    if (shipment != null && shipment.id.isNotEmpty) {
      _scheduleSearch(shipment, reset: true);
    }
  }

  void _scheduleSearch(ShipmentDraftRecord shipment, {required bool reset}) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(_runSearch(shipment, reset: reset));
    });
  }

  Future<void> _openSearchControlsSheet(BuildContext context) async {
    final result = await showModalBottomSheet<(
      SearchSortOption,
      bool,
      bool,
    )>(
      context: context,
      builder: (context) {
        var selectedSort = _sort;
        var includeRecurring = _includeRecurring;
        var includeOneOff = _includeOneOff;
        final s = S.of(context);
        return StatefulBuilder(
          builder: (context, setModalState) => SafeArea(
            child: Padding(
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
      final response = await ref.read(shipmentRepositoryProvider).searchExactLaneCapacity(
            ShipmentSearchQuery(
              shipmentId: shipment.id,
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
        AppFeedback.showSnackBar(context, mapAppErrorMessage(S.of(context), error));
      }
    } finally {
      if (mounted && token == _searchToken) {
        setState(() => _isSearching = false);
      }
    }
  }
}

class BookingReviewScreen extends ConsumerStatefulWidget {
  const BookingReviewScreen({super.key, this.selection});

  final BookingReviewSelection? selection;

  @override
  ConsumerState<BookingReviewScreen> createState() => _BookingReviewScreenState();
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

    final quote = _quoteFromSelection(
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
                value: _formatDateTime(context, bookingSelection.result.departureAt),
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
              ProfileSummaryRow(
                label: s.shipmentCategoryLabel,
                value: bookingSelection.shipment.category,
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
            onPressed: () => unawaited(_confirmBooking(context, bookingSelection, quote)),
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
                  Text(s.bookingInsuranceAction, style: Theme.of(context).textTheme.titleMedium),
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
                MoneySummaryLine(label: s.bookingBasePriceLabel, amount: _money(s, quote.basePriceDzd)),
                MoneySummaryLine(label: s.bookingPlatformFeeLabel, amount: _money(s, quote.platformFeeDzd)),
                MoneySummaryLine(label: s.bookingCarrierFeeLabel, amount: _money(s, quote.carrierFeeDzd)),
                MoneySummaryLine(label: s.bookingInsuranceFeeLabel, amount: _money(s, quote.insuranceFeeDzd)),
                MoneySummaryLine(label: s.bookingTaxFeeLabel, amount: _money(s, quote.taxFeeDzd)),
                MoneySummaryLine(label: s.bookingCarrierPayoutLabel, amount: _money(s, quote.carrierPayoutDzd)),
                MoneySummaryLine(label: s.bookingTotalLabel, amount: _money(s, quote.shipperTotalDzd), emphasis: true),
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
      final booking = await ref.read(bookingWorkflowControllerProvider).createBooking(
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
  const PaymentFlowScreen({super.key, this.bookingId});

  final String? bookingId;

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
      return AppPageScaffold(title: s.paymentFlowTitle, child: const AppNotFoundState());
    }
    final bookingAsync = ref.watch(bookingDetailProvider(id));
    final settingsAsync = ref.watch(clientSettingsProvider);
    final proofsAsync = ref.watch(paymentProofsForBookingProvider(id));
    final documentsAsync = ref.watch(generatedDocumentsForBookingProvider(id));

    return AppPageScaffold(
      title: s.paymentFlowTitle,
      child: AppAsyncStateView<BookingRecord?>(
        value: bookingAsync,
        onRetry: () => ref.invalidate(bookingDetailProvider(id)),
        data: (booking) {
          if (booking == null) return const AppNotFoundState();
          final paymentAccounts = _paymentAccountsFromSettings(settingsAsync.asData?.value);
          final latestProof = proofsAsync.asData?.value.firstOrNull;
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
                  ProfileSummaryRow(label: s.bookingPaymentReferenceLabel, value: BidiFormatters.latinIdentifier(booking.paymentReference)),
                  ProfileSummaryRow(label: s.bookingTrackingNumberLabel, value: BidiFormatters.latinIdentifier(booking.trackingNumber)),
                  ProfileSummaryRow(label: s.bookingTotalLabel, value: _money(s, BookingPricingQuote(
                    pricePerKgDzd: booking.pricePerKgDzd,
                    basePriceDzd: booking.basePriceDzd,
                    platformFeeDzd: booking.platformFeeDzd,
                    carrierFeeDzd: booking.carrierFeeDzd,
                    insuranceRate: booking.insuranceRate,
                    insuranceFeeDzd: booking.insuranceFeeDzd,
                    taxFeeDzd: booking.taxFeeDzd,
                    shipperTotalDzd: booking.shipperTotalDzd,
                    carrierPayoutDzd: booking.carrierPayoutDzd,
                  ).shipperTotalDzd)),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              MoneySummaryCard(
                title: s.bookingPricingBreakdownAction,
                lines: [
                  MoneySummaryLine(label: s.bookingBasePriceLabel, amount: _money(s, booking.basePriceDzd)),
                  MoneySummaryLine(label: s.bookingPlatformFeeLabel, amount: _money(s, booking.platformFeeDzd)),
                  MoneySummaryLine(label: s.bookingCarrierFeeLabel, amount: _money(s, booking.carrierFeeDzd)),
                  MoneySummaryLine(label: s.bookingInsuranceFeeLabel, amount: _money(s, booking.insuranceFeeDzd)),
                  MoneySummaryLine(label: s.bookingTaxFeeLabel, amount: _money(s, booking.taxFeeDzd)),
                  MoneySummaryLine(label: s.bookingTotalLabel, amount: _money(s, booking.shipperTotalDzd), emphasis: true),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(s.paymentProofSectionTitle, style: Theme.of(context).textTheme.titleMedium),
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
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isUploading ? null : () => unawaited(_uploadProof(context, booking)),
                      child: Text(
                        latestProof == null || latestProof.status != 'rejected'
                            ? s.paymentProofUploadAction
                            : s.paymentProofResubmitAction,
                      ),
                    ),
                  ),
                  if (latestProof != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () => context.push(
                            AppRoutePath.sharedProofViewer.replaceFirst(':id', latestProof.id),
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
                                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                child: AppListCard(
                                  title: '${_paymentProofStatusLabel(s, proof.status)} • ${_money(s, proof.submittedAmountDzd)}',
                                  subtitle: _formatDateTime(context, proof.submittedAt),
                                  onTap: () => context.push(
                                    AppRoutePath.sharedProofViewer.replaceFirst(':id', proof.id),
                                  ),
                                ),
                              ),
                            )
                            .toList(growable: false),
                      ),
                loading: () => const AppLoadingState(),
                error: (error, stackTrace) => AppErrorState(
                  error: AppError(code: 'payment_proofs_load_failed', message: mapAppErrorMessage(s, error)),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(s.paymentInstructionsTitle, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              ...paymentAccounts.map(
                (account) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppListCard(
                    title: account.displayName,
                    subtitle: '${account.accountIdentifier} • ${account.accountHolderName}',
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(s.generatedDocumentsTitle, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
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
                                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                child: AppListCard(
                                  title: document.documentType,
                                  subtitle: document.storagePath,
                                  onTap: () => context.push(
                                    AppRoutePath.sharedGeneratedDocumentViewer.replaceFirst(':id', document.id),
                                  ),
                                ),
                              ),
                            )
                            .toList(growable: false),
                      ),
                loading: () => const AppLoadingState(),
                error: (error, stackTrace) => AppErrorState(
                  error: AppError(code: 'generated_documents_load_failed', message: mapAppErrorMessage(s, error)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _uploadProof(BuildContext context, BookingRecord booking) async {
    final s = S.of(context);
    final settings = ref.read(clientSettingsProvider).asData?.value;
    final paymentAccounts = _paymentAccountsFromSettings(settings);
    var paymentRail = paymentAccounts.firstOrNull?.displayName.toLowerCase().contains('dahab') == true
        ? 'dahabia'
        : paymentAccounts.firstOrNull?.displayName.toLowerCase().contains('bank') == true
            ? 'bank'
            : 'ccp';
    final amountController = TextEditingController(text: booking.shipperTotalDzd.toStringAsFixed(0));
    final referenceController = TextEditingController(text: booking.paymentReference);

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
              Text(s.paymentProofUploadAction, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                initialValue: paymentRail,
                items: const [
                  DropdownMenuItem(value: 'ccp', child: Text('CCP')),
                  DropdownMenuItem(value: 'dahabia', child: Text('Dahabia')),
                  DropdownMenuItem(value: 'bank', child: Text('Bank')),
                ],
                onChanged: (value) {
                  if (value != null) setModalState(() => paymentRail = value);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(controller: amountController, label: s.paymentProofAmountLabel, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(controller: referenceController, label: s.paymentProofReferenceLabel),
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
      await ref.read(paymentProofRepositoryProvider).uploadPaymentProof(
            bookingId: booking.id,
            paymentRail: paymentRail,
            draft: draft,
            submittedAmountDzd: double.parse(amountController.text.trim()),
            submittedReference: referenceController.text,
          );
      ref
        ..invalidate(paymentProofsForBookingProvider(booking.id))
        ..invalidate(bookingDetailProvider(booking.id));
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
}

class _ShipmentEditorSheet extends ConsumerStatefulWidget {
  const _ShipmentEditorSheet({this.shipment});

  final ShipmentDraftRecord? shipment;

  @override
  ConsumerState<_ShipmentEditorSheet> createState() => _ShipmentEditorSheetState();
}

class _ShipmentEditorSheetState extends ConsumerState<_ShipmentEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _volumeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<_ShipmentItemController> _items = [];

  int? _originCommuneId;
  int? _destinationCommuneId;
  DateTime? _pickupStart;
  DateTime? _pickupEnd;
  bool _isSaving = false;
  bool _initialized = false;

  @override
  void dispose() {
    _weightController.dispose();
    _volumeController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final communesAsync = ref.watch(communesProvider);

    if (!_initialized) {
      final shipment = widget.shipment;
      _originCommuneId = shipment?.originCommuneId;
      _destinationCommuneId = shipment?.destinationCommuneId;
      _pickupStart = shipment?.pickupWindowStart;
      _pickupEnd = shipment?.pickupWindowEnd;
      _weightController.text = shipment?.totalWeightKg.toStringAsFixed(0) ?? '';
      _volumeController.text = shipment?.totalVolumeM3?.toString() ?? '';
      _categoryController.text = shipment?.category ?? '';
      _descriptionController.text = shipment?.description ?? '';
      final baseItems = shipment?.items.isNotEmpty == true
          ? shipment!.items
          : const [ShipmentItemDraft(label: '', quantity: 1)];
      _items.addAll(baseItems.map(_ShipmentItemController.fromDraft));
      _initialized = true;
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: AppFocusTraversal.sheet(
        child: AppAsyncStateView<List<AlgeriaCommune>>(
          value: communesAsync,
          onRetry: () => ref.invalidate(communesProvider),
          data: (communes) {
            return Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    widget.shipment == null ? s.shipmentCreateTitle : s.shipmentEditTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CommuneSelectorField(
                    label: s.routeOriginLabel,
                    communeId: _originCommuneId,
                    communes: communes,
                    onSelect: (value) => setState(() => _originCommuneId = value),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CommuneSelectorField(
                    label: s.routeDestinationLabel,
                    communeId: _destinationCommuneId,
                    communes: communes,
                    onSelect: (value) => setState(() => _destinationCommuneId = value),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _DateButtonField(
                    label: s.shipmentPickupStartLabel,
                    value: _pickupStart == null ? null : _formatDateTime(context, _pickupStart!),
                    onPressed: () => unawaited(_pickDateTime(context, true)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _DateButtonField(
                    label: s.shipmentPickupEndLabel,
                    value: _pickupEnd == null ? null : _formatDateTime(context, _pickupEnd!),
                    onPressed: () => unawaited(_pickDateTime(context, false)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _weightController,
                    label: s.vehicleCapacityWeightLabel,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: _positiveValidator,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _volumeController,
                    label: s.vehicleCapacityVolumeLabel,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: _optionalPositiveValidator,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _categoryController,
                    label: s.shipmentCategoryLabel,
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _descriptionController,
                    label: s.shipmentDescriptionLabel,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    s.shipmentItemsTitle,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ..._items.asMap().entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _ShipmentItemEditor(
                            controller: entry.value,
                            title: s.shipmentItemTitle(BidiFormatters.latinIdentifier('${entry.key + 1}')),
                            onRemove: _items.length == 1
                                ? null
                                : () => setState(() {
                                      entry.value.dispose();
                                      _items.removeAt(entry.key);
                                    }),
                          ),
                        ),
                      ),
                  TextButton.icon(
                    onPressed: () => setState(() {
                      _items.add(_ShipmentItemController.empty());
                    }),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(s.shipmentAddItemAction),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AuthSubmitButton(
                    label: widget.shipment == null ? s.shipmentCreateAction : s.shipmentSaveAction,
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

  Future<void> _pickDateTime(BuildContext context, bool start) async {
    final initial = start ? (_pickupStart ?? DateTime.now()) : (_pickupEnd ?? DateTime.now().add(const Duration(hours: 2)));
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: initial,
    );
    if (date == null || !mounted) return;
    if (!context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !mounted) return;
    final picked = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (start) {
        _pickupStart = picked;
      } else {
        _pickupEnd = picked;
      }
    });
  }

  Future<void> _save() async {
    final s = S.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_originCommuneId == null || _destinationCommuneId == null || _pickupStart == null || _pickupEnd == null) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    if (_originCommuneId == _destinationCommuneId) {
      AppFeedback.showSnackBar(context, s.publicationSameLaneErrorMessage);
      return;
    }
    if (!_pickupEnd!.isAfter(_pickupStart!)) {
      AppFeedback.showSnackBar(context, s.shipmentPickupWindowOrderMessage);
      return;
    }
    setState(() => _isSaving = true);
    try {
      final input = ShipmentDraftInput(
        originCommuneId: _originCommuneId!,
        destinationCommuneId: _destinationCommuneId!,
        pickupWindowStart: _pickupStart!,
        pickupWindowEnd: _pickupEnd!,
        totalWeightKg: double.parse(_weightController.text.trim()),
        totalVolumeM3: _parseOptional(_volumeController.text),
        category: _categoryController.text.trim(),
        description: _descriptionController.text,
        items: _items.map((item) => item.toDraft()).toList(growable: false),
      );
      final workflow = ref.read(shipmentWorkflowControllerProvider);
      if (widget.shipment == null) {
        await workflow.createShipmentDraft(input);
      } else {
        await workflow.updateShipmentDraft(shipmentId: widget.shipment!.id, input: input);
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppFocusTraversal.dialog(
        child: AlertDialog(
          title: Text(s.shipmentDeleteAction),
          content: Text(s.shipmentDeleteConfirmationMessage),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(s.cancelLabel)),
            FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(s.confirmLabel)),
          ],
        ),
      ),
    );
    if (confirmed != true) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(shipmentWorkflowControllerProvider).deleteShipmentDraft(shipment.id);
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

  String? _requiredValidator(String? value) {
    return (value ?? '').trim().isEmpty ? S.of(context).authRequiredFieldMessage : null;
  }

  String? _positiveValidator(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return S.of(context).authRequiredFieldMessage;
    final parsed = double.tryParse(trimmed);
    if (parsed == null || parsed <= 0) return S.of(context).vehiclePositiveNumberMessage;
    return null;
  }

  String? _optionalPositiveValidator(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return null;
    final parsed = double.tryParse(trimmed);
    if (parsed == null || parsed <= 0) return S.of(context).vehiclePositiveNumberMessage;
    return null;
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

    final results = response.results.where((result) {
      if (result.sourceType == 'route' && !includeRecurring) {
        return false;
      }
      if (result.sourceType == 'oneoff_trip' && !includeOneOff) {
        return false;
      }
      return true;
    }).toList(growable: false);

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
          s.searchTripsResultsTitle(BidiFormatters.latinIdentifier('${response.totalCount}')),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final result = results[index];
            return AppListCard(
              title: result.carrierName,
              subtitle:
                  '${_formatDateTime(context, result.departureAt)} • ${BidiFormatters.latinIdentifier(result.estimatedTotalDzd.toStringAsFixed(0))} ${s.priceCurrencyLabel}',
              leading: AppStatusChip(
                label: result.sourceType == 'route'
                    ? s.searchTripsRecurringLabel
                    : s.searchTripsOneOffLabel,
                tone: AppStatusTone.info,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(
                AppRoutePath.shipperBookingReview,
                extra: BookingReviewSelection(shipment: shipment, result: result),
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

class _ShipmentItemEditor extends StatelessWidget {
  const _ShipmentItemEditor({
    required this.controller,
    required this.title,
    required this.onRemove,
  });

  final _ShipmentItemController controller;
  final String title;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
                if (onRemove != null)
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: s.shipmentRemoveItemAction,
                  ),
              ],
            ),
            AuthTextField(controller: controller.label, label: s.shipmentItemLabelField),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: controller.quantity,
              label: s.shipmentItemQuantityLabel,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: controller.weight,
              label: s.shipmentItemWeightLabel,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: controller.volume,
              label: s.shipmentItemVolumeLabel,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(controller: controller.notes, label: s.shipmentItemNotesLabel),
          ],
        ),
      ),
    );
  }
}

class _ShipmentItemController {
  _ShipmentItemController({required ShipmentItemDraft draft})
      : label = TextEditingController(text: draft.label),
        quantity = TextEditingController(text: draft.quantity.toString()),
        weight = TextEditingController(text: draft.weightKg?.toString() ?? ''),
        volume = TextEditingController(text: draft.volumeM3?.toString() ?? ''),
        notes = TextEditingController(text: draft.notes ?? '');

  factory _ShipmentItemController.empty() =>
      _ShipmentItemController(draft: const ShipmentItemDraft(label: '', quantity: 1));

  factory _ShipmentItemController.fromDraft(ShipmentItemDraft draft) =>
      _ShipmentItemController(draft: draft);

  final TextEditingController label;
  final TextEditingController quantity;
  final TextEditingController weight;
  final TextEditingController volume;
  final TextEditingController notes;

  ShipmentItemDraft toDraft() {
    return ShipmentItemDraft(
      label: label.text.trim(),
      quantity: int.tryParse(quantity.text.trim()) ?? 1,
      weightKg: double.tryParse(weight.text.trim()),
      volumeM3: double.tryParse(volume.text.trim()),
      notes: notes.text,
    );
  }

  void dispose() {
    label.dispose();
    quantity.dispose();
    weight.dispose();
    volume.dispose();
    notes.dispose();
  }
}

String _shipmentLaneLabel(
  BuildContext context,
  ShipmentDraftRecord shipment,
  Map<int, AlgeriaCommune> communeMap,
) {
  final locale = Localizations.localeOf(context);
  final origin = communeMap[shipment.originCommuneId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(shipment.originCommuneId.toString());
  final destination = communeMap[shipment.destinationCommuneId]?.displayName(locale) ??
      BidiFormatters.latinIdentifier(shipment.destinationCommuneId.toString());
  return '$origin -> $destination';
}

String _shipmentCompactLabel(BuildContext context, ShipmentDraftRecord shipment) {
  return '${shipment.category} • ${_formatDate(shipment.pickupWindowStart)}';
}

String _shipmentSubtitle(BuildContext context, ShipmentDraftRecord shipment) {
  final s = S.of(context);
  return '${shipment.category} • ${BidiFormatters.latinIdentifier(shipment.totalWeightKg.toStringAsFixed(0))} kg • ${s.shipmentPickupStartLabel}: ${_formatDateTime(context, shipment.pickupWindowStart)}';
}

String _shipmentStatusLabel(S s, ShipmentStatus status) {
  return switch (status) {
    ShipmentStatus.booked => s.shipmentStatusBookedLabel,
    ShipmentStatus.cancelled => s.shipmentStatusCancelledLabel,
    ShipmentStatus.draft => s.shipmentStatusDraftLabel,
  };
}

String _communeName(
  BuildContext context,
  List<AlgeriaCommune>? communes,
  int communeId,
) {
  final locale = Localizations.localeOf(context);
  final commune = communes?.where((item) => item.id == communeId).firstOrNull;
  return commune?.displayName(locale) ?? BidiFormatters.latinIdentifier('$communeId');
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

BookingPricingQuote _quoteFromSelection({
  required BookingReviewSelection bookingSelection,
  required bool includeInsurance,
  required Map<String, dynamic>? settings,
}) {
  final rawPricing = (settings?['booking_pricing'] as Map<String, dynamic>?) ?? const {};
  final platformFeeRate = (rawPricing['platform_fee_rate'] as num?)?.toDouble() ?? 0.05;
  final carrierFeeRate = (rawPricing['carrier_fee_rate'] as num?)?.toDouble() ?? 0;
  final insuranceRate = (rawPricing['insurance_rate'] as num?)?.toDouble() ?? 0.01;
  final insuranceMinFee = (rawPricing['insurance_min_fee_dzd'] as num?)?.toDouble() ?? 100;
  final taxRate = (rawPricing['tax_rate'] as num?)?.toDouble() ?? 0;

  final base = bookingSelection.shipment.totalWeightKg * bookingSelection.result.pricePerKgDzd;
  final platformFee = base * platformFeeRate;
  final carrierFee = base * carrierFeeRate;
  final insuranceFee = includeInsurance
      ? (base * insuranceRate) < insuranceMinFee
          ? insuranceMinFee
          : base * insuranceRate
      : 0.0;
  final taxFee = (base + platformFee + carrierFee + insuranceFee) * taxRate;
  final total = base + platformFee + carrierFee + insuranceFee + taxFee;
  final payout = base + carrierFee;

  return BookingPricingQuote(
    pricePerKgDzd: bookingSelection.result.pricePerKgDzd,
    basePriceDzd: base,
    platformFeeDzd: platformFee,
    carrierFeeDzd: carrierFee,
    insuranceRate: includeInsurance ? insuranceRate : null,
    insuranceFeeDzd: insuranceFee,
    taxFeeDzd: taxFee,
    shipperTotalDzd: total,
    carrierPayoutDzd: payout,
  );
}

String _money(S s, double amount) {
  return '${BidiFormatters.latinIdentifier(amount.toStringAsFixed(0))} ${s.priceCurrencyLabel}';
}

List<_PlatformPaymentAccountView> _paymentAccountsFromSettings(Map<String, dynamic>? settings) {
  final raw = (settings?['platform_payment_accounts'] as List<dynamic>?) ?? const <dynamic>[];
  return raw
      .cast<Map<String, dynamic>>()
      .map(
        (item) => _PlatformPaymentAccountView(
          displayName: (item['display_name'] as String?)?.trim() ?? '',
          accountIdentifier: (item['account_identifier'] as String?)?.trim() ?? '',
          accountHolderName: (item['account_holder_name'] as String?)?.trim() ?? '',
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

class _CommuneSelectorField extends StatelessWidget {
  const _CommuneSelectorField({
    required this.label,
    required this.communeId,
    required this.communes,
    required this.onSelect,
  });

  final String label;
  final int? communeId;
  final List<AlgeriaCommune> communes;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final selected = communeId == null
        ? null
        : communes.where((item) => item.id == communeId).firstOrNull;

    return _DateButtonField(
      label: label,
      value: selected?.displayName(locale),
      onPressed: () => unawaited(_showPicker(context)),
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final selection = await showModalBottomSheet<AlgeriaCommune>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        var query = '';
        final locale = Localizations.localeOf(context);
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = communes
                .where((commune) => commune.matchesQuery(query))
                .toList(growable: false);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => setModalState(() => query = value),
                      decoration: InputDecoration(
                        labelText: S.of(context).publicationSearchCommunesHint,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final commune = filtered[index];
                          return AppListCard(
                            title: commune.displayName(locale),
                            subtitle: BidiFormatters.latinIdentifier(commune.id.toString()),
                            onTap: () => Navigator.of(context).pop(commune),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (selection != null) {
      onSelect(selection.id);
    }
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
        child: Text('$label: ${value ?? S.of(context).publicationSelectValueAction}'),
      ),
    );
  }
}
