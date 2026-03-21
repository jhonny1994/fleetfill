import 'dart:typed_data';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app startup restores configured locale and theme', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(const <String, Object>{});
    final sharedPreferences = await SharedPreferences.getInstance();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const _ThemeLocaleProbe(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          secureStorageProvider.overrideWithValue(const FlutterSecureStorage()),
          appEnvironmentConfigProvider.overrideWithValue(
            const AppEnvironmentConfig(environment: AppEnvironment.local),
          ),
          initialThemeModeProvider.overrideWithValue(ThemeMode.dark),
          initialLocaleProvider.overrideWithValue(const Locale('fr')),
          appRouterProvider.overrideWithValue(router),
          authSessionControllerProvider.overrideWith(
            _FakeAuthSessionController.new,
          ),
          appBootstrapControllerProvider.overrideWith(
            _ReadyBootstrapController.new,
          ),
        ],
        child: const FleetFillApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('fr|dark'), findsOneWidget);
  });

  testWidgets(
    'shipper journey keeps shipment, search, booking, and proof states aligned',
    (
      tester,
    ) async {
      final store = _FakeFlowStore();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            shipmentRepositoryProvider.overrideWithValue(
              _FakeShipmentRepository(store),
            ),
            bookingRepositoryProvider.overrideWithValue(
              _FakeBookingRepository(store),
            ),
            paymentProofRepositoryProvider.overrideWithValue(
              _FakePaymentProofRepository(store),
            ),
            disputeRepositoryProvider.overrideWithValue(
              _FakeDisputeRepository(store),
            ),
            verificationAdminRepositoryProvider.overrideWithValue(
              _FakeVerificationAdminRepository(store),
            ),
            notificationRepositoryProvider.overrideWithValue(
              _FakeNotificationRepository(),
            ),
          ],
          child: const MaterialApp(home: _ShipperJourneyHarness()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('shipments:0'), findsOneWidget);
      expect(find.text('search:0'), findsOneWidget);

      await tester.tap(find.byKey(const Key('create-shipment')));
      await tester.pumpAndSettle();
      expect(find.text('shipments:1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('search-capacity')));
      await tester.pumpAndSettle();
      expect(find.text('search:1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('create-booking')));
      await tester.pumpAndSettle();
      expect(find.text('booking:pendingPayment/unpaid'), findsOneWidget);

      await tester.tap(find.byKey(const Key('upload-proof')));
      await tester.pumpAndSettle();
      expect(
        find.text('booking:paymentUnderReview/underVerification'),
        findsOneWidget,
      );
      expect(find.text('proofs:1'), findsOneWidget);
    },
  );

  testWidgets(
    'carrier milestone updates keep booking detail and tracking timeline in sync',
    (
      tester,
    ) async {
      final store = _FakeFlowStore()..seedCarrierBooking();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            shipmentRepositoryProvider.overrideWithValue(
              _FakeShipmentRepository(store),
            ),
            bookingRepositoryProvider.overrideWithValue(
              _FakeBookingRepository(store),
            ),
            paymentProofRepositoryProvider.overrideWithValue(
              _FakePaymentProofRepository(store),
            ),
            disputeRepositoryProvider.overrideWithValue(
              _FakeDisputeRepository(store),
            ),
            verificationAdminRepositoryProvider.overrideWithValue(
              _FakeVerificationAdminRepository(store),
            ),
            notificationRepositoryProvider.overrideWithValue(
              _FakeNotificationRepository(),
            ),
          ],
          child: const MaterialApp(home: _CarrierProgressHarness()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('status:confirmed'), findsOneWidget);
      expect(find.text('events:1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('carrier-picked-up')));
      await tester.pumpAndSettle();
      expect(find.text('status:pickedUp'), findsOneWidget);
      expect(find.text('events:2'), findsOneWidget);

      await tester.tap(find.byKey(const Key('carrier-delivered')));
      await tester.pumpAndSettle();
      expect(find.text('status:deliveredPendingReview'), findsOneWidget);
      expect(find.text('events:3'), findsOneWidget);

      await tester.tap(find.byKey(const Key('shipper-confirm-delivery')));
      await tester.pumpAndSettle();
      expect(find.text('status:completed'), findsOneWidget);
      expect(find.text('events:4'), findsOneWidget);
    },
  );

  testWidgets(
    'admin workflows refresh verification and dispute queues after action',
    (
      tester,
    ) async {
      final store = _FakeFlowStore();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            shipmentRepositoryProvider.overrideWithValue(
              _FakeShipmentRepository(store),
            ),
            bookingRepositoryProvider.overrideWithValue(
              _FakeBookingRepository(store),
            ),
            paymentProofRepositoryProvider.overrideWithValue(
              _FakePaymentProofRepository(store),
            ),
            disputeRepositoryProvider.overrideWithValue(
              _FakeDisputeRepository(store),
            ),
            verificationAdminRepositoryProvider.overrideWithValue(
              _FakeVerificationAdminRepository(store),
            ),
            notificationRepositoryProvider.overrideWithValue(
              _FakeNotificationRepository(),
            ),
          ],
          child: const MaterialApp(home: _AdminOpsHarness()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('verification:1'), findsOneWidget);
      expect(find.text('disputes:1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('approve-verification')));
      await tester.pumpAndSettle();
      expect(find.text('verification:0'), findsOneWidget);

      await tester.tap(find.byKey(const Key('resolve-dispute')));
      await tester.pumpAndSettle();
      expect(find.text('disputes:0'), findsOneWidget);
    },
  );
}

class _ThemeLocaleProbe extends StatelessWidget {
  const _ThemeLocaleProbe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${Localizations.localeOf(context).languageCode}|${Theme.of(context).brightness.name}',
        ),
      ),
    );
  }
}

class _ShipperJourneyHarness extends ConsumerStatefulWidget {
  const _ShipperJourneyHarness();

  @override
  ConsumerState<_ShipperJourneyHarness> createState() =>
      _ShipperJourneyHarnessState();
}

class _ShipperJourneyHarnessState
    extends ConsumerState<_ShipperJourneyHarness> {
  ShipmentSearchResponse? _searchResponse;
  String? _bookingId;
  String? _shipmentId;

  @override
  Widget build(BuildContext context) {
    final shipments =
        ref.watch(myShipperShipmentsProvider).asData?.value ?? const [];
    final booking = _bookingId == null
        ? null
        : ref.watch(bookingDetailProvider(_bookingId!)).asData?.value;
    final proofs = _bookingId == null
        ? const <PaymentProofRecord>[]
        : ref
                  .watch(paymentProofsForBookingProvider(_bookingId!))
                  .asData
                  ?.value ??
              const <PaymentProofRecord>[];

    return Scaffold(
      body: Column(
        children: [
          Text('shipments:${shipments.length}'),
          Text('search:${_searchResponse?.results.length ?? 0}'),
          Text(
            booking == null
                ? 'booking:none'
                : 'booking:${booking.bookingStatus.name}/${booking.paymentStatus.name}',
          ),
          Text('proofs:${proofs.length}'),
          TextButton(
            key: const Key('create-shipment'),
            onPressed: () async {
              final shipment = await ref
                  .read(shipmentWorkflowControllerProvider)
                  .createShipmentDraft(_shipmentInput());
              setState(() => _shipmentId = shipment.id);
            },
            child: const Text('Create shipment'),
          ),
          TextButton(
            key: const Key('search-capacity'),
            onPressed: _shipmentId == null
                ? null
                : () async {
                    final shipment = shipments.first;
                    final response = await ref
                        .read(shipmentRepositoryProvider)
                        .searchExactLaneCapacity(
                          ShipmentSearchQuery(
                            shipmentId: shipment.id,
                            originCommuneId: shipment.originCommuneId,
                            destinationCommuneId: shipment.destinationCommuneId,
                            requestedDate: shipment.pickupWindowStart,
                            totalWeightKg: shipment.totalWeightKg,
                            totalVolumeM3: shipment.totalVolumeM3,
                          ),
                        );
                    setState(() => _searchResponse = response);
                  },
            child: const Text('Search capacity'),
          ),
          TextButton(
            key: const Key('create-booking'),
            onPressed: _searchResponse == null
                ? null
                : () async {
                    final booking = await ref
                        .read(bookingWorkflowControllerProvider)
                        .createBooking(
                          shipment: shipments.first,
                          result: _searchResponse!.results.first,
                          includeInsurance: false,
                        );
                    setState(() => _bookingId = booking.id);
                  },
            child: const Text('Create booking'),
          ),
          TextButton(
            key: const Key('upload-proof'),
            onPressed: _bookingId == null
                ? null
                : () async {
                    await ref
                        .read(paymentProofRepositoryProvider)
                        .uploadPaymentProof(
                          bookingId: _bookingId!,
                          paymentRail: 'ccp',
                          draft: VerificationUploadDraft(
                            path: 'proof.png',
                            filename: 'proof.png',
                            extension: 'png',
                            contentType: 'image/png',
                            byteSize: 4,
                            bytes: Uint8List.fromList(const [1, 2, 3, 4]),
                          ),
                          submittedAmountDzd: 1250,
                          submittedReference: 'PAY-1',
                        );
                    ref
                      ..invalidate(myShipperBookingsProvider)
                      ..invalidate(bookingDetailProvider(_bookingId!))
                      ..invalidate(
                        paymentProofsForBookingProvider(_bookingId!),
                      );
                  },
            child: const Text('Upload proof'),
          ),
        ],
      ),
    );
  }
}

class _CarrierProgressHarness extends ConsumerWidget {
  const _CarrierProgressHarness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bookingId = _FakeFlowStore.seededCarrierBookingId;
    final booking = ref.watch(bookingDetailProvider(bookingId)).asData?.value;
    final tracking =
        ref.watch(trackingEventsProvider(bookingId)).asData?.value ??
        const <TrackingEventRecord>[];

    return Scaffold(
      body: Column(
        children: [
          Text('status:${booking?.bookingStatus.name ?? 'none'}'),
          Text('events:${tracking.length}'),
          TextButton(
            key: const Key('carrier-picked-up'),
            onPressed: () async {
              await ref
                  .read(bookingWorkflowControllerProvider)
                  .carrierRecordMilestone(
                    bookingId: bookingId,
                    milestone: 'picked_up',
                  );
            },
            child: const Text('Picked up'),
          ),
          TextButton(
            key: const Key('carrier-delivered'),
            onPressed: () async {
              await ref
                  .read(bookingWorkflowControllerProvider)
                  .carrierRecordMilestone(
                    bookingId: bookingId,
                    milestone: 'delivered_pending_review',
                  );
            },
            child: const Text('Delivered'),
          ),
          TextButton(
            key: const Key('shipper-confirm-delivery'),
            onPressed: () async {
              await ref
                  .read(bookingWorkflowControllerProvider)
                  .shipperConfirmDelivery(
                    bookingId: bookingId,
                    shipmentId: _FakeFlowStore.seededCarrierShipmentId,
                  );
            },
            child: const Text('Confirm delivery'),
          ),
        ],
      ),
    );
  }
}

class _AdminOpsHarness extends ConsumerWidget {
  const _AdminOpsHarness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationPackets =
        ref.watch(pendingVerificationPacketsProvider).asData?.value ?? const [];
    final disputes = ref.watch(openDisputesProvider).asData?.value ?? const [];

    return Scaffold(
      body: Column(
        children: [
          Text('verification:${verificationPackets.length}'),
          Text('disputes:${disputes.length}'),
          TextButton(
            key: const Key('approve-verification'),
            onPressed: verificationPackets.isEmpty
                ? null
                : () async {
                    await ref
                        .read(adminVerificationWorkflowControllerProvider)
                        .approveAll(verificationPackets.first);
                  },
            child: const Text('Approve verification'),
          ),
          TextButton(
            key: const Key('resolve-dispute'),
            onPressed: disputes.isEmpty
                ? null
                : () async {
                    await ref
                        .read(adminDisputePayoutWorkflowControllerProvider)
                        .resolveDisputeComplete(disputeId: disputes.first.id);
                  },
            child: const Text('Resolve dispute'),
          ),
        ],
      ),
    );
  }
}

class _ReadyBootstrapController extends AppBootstrapController {
  @override
  Future<AppBootstrapState> build() async {
    return const AppBootstrapState(
      status: BootstrapStateStatus.ready,
      environment: AppEnvironmentConfig(environment: AppEnvironment.local),
      auth: AuthSnapshot(
        status: AuthStatus.authenticated,
        userId: 'user-1',
        email: 'shipper@example.com',
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
      ),
    );
  }
}

class _FakeAuthSessionController extends AuthSessionController {
  @override
  Future<AuthSnapshot> build() async {
    return const AuthSnapshot(
      status: AuthStatus.authenticated,
      userId: 'user-1',
      email: 'shipper@example.com',
      role: AppUserRole.shipper,
      hasCompletedOnboarding: true,
      hasPhoneNumber: true,
    );
  }
}

class _FakeFlowStore {
  static const seededCarrierBookingId = 'booking-carrier';
  static const seededCarrierShipmentId = 'shipment-carrier';

  final List<ShipmentDraftRecord> shipments = [];
  final List<BookingRecord> bookings = [];
  final Map<String, List<TrackingEventRecord>> trackingEvents = {};
  final Map<String, List<PaymentProofRecord>> paymentProofs = {};
  final List<VerificationReviewPacket> verificationPackets = [
    const VerificationReviewPacket(
      carrierId: 'carrier-1',
      displayName: 'Carrier One',
      companyName: 'Carrier One',
      profileStatus: AppVerificationState.pending,
      profileRejectionReason: null,
      profileDocuments: <VerificationDocumentRecord>[],
      vehicles: <VehicleVerificationOverview>[],
    ),
  ];
  final List<DisputeRecord> disputes = [
    const DisputeRecord(
      id: 'dispute-1',
      bookingId: 'booking-dispute',
      openedBy: 'shipper-1',
      reason: 'Damaged goods',
      description: 'Box damaged',
      status: 'open',
      resolution: null,
      resolutionNote: null,
      resolvedBy: null,
      resolvedAt: null,
      createdAt: null,
      updatedAt: null,
    ),
  ];

  final ClientSettings clientSettings = const ClientSettings(
    bookingPricing: BookingPricingSettings(
      platformFeeRate: 0.05,
      carrierFeeRate: 0.02,
      insuranceRate: 0.01,
      insuranceMinFeeDzd: 100,
      taxRate: 0,
      paymentResubmissionDeadlineHours: 24,
    ),
    deliveryReview: DeliveryReviewSettings(graceWindowHours: 24),
    appRuntime: AppRuntimeSettings(
      maintenanceMode: false,
      forceUpdateRequired: false,
      minimumSupportedAndroidVersion: 1,
      minimumSupportedIosVersion: 1,
    ),
    paymentAccounts: <PlatformPaymentAccountSettings>[],
  );

  ShipmentSearchResponse searchResponseFor(String shipmentId) {
    return ShipmentSearchResponse(
      mode: SearchResultMode.exact,
      results: [
        ShipmentSearchResult(
          sourceId: 'route-1',
          sourceType: 'route',
          carrierId: 'carrier-1',
          carrierName: 'Carrier One',
          vehicleId: 'vehicle-1',
          originCommuneId: 1601,
          destinationCommuneId: 3101,
          departureAt: DateTime.utc(2026, 3, 22, 8),
          departureDate: DateTime.utc(2026, 3, 22),
          totalCapacityKg: 1000,
          totalCapacityVolumeM3: 10,
          remainingCapacityKg: 900,
          remainingVolumeM3: 9,
          pricePerKgDzd: 25,
          estimatedTotalDzd: 1250,
          ratingAverage: 4.8,
          ratingCount: 12,
          dayDistance: 0,
        ),
      ],
      nearestDates: const [],
      nextOffset: null,
      totalCount: 1,
    );
  }

  void seedCarrierBooking() {
    shipments.add(
      ShipmentDraftRecord(
        id: seededCarrierShipmentId,
        shipperId: 'shipper-1',
        originCommuneId: 1601,
        destinationCommuneId: 3101,
        pickupWindowStart: DateTime.utc(2026, 3, 21, 8),
        pickupWindowEnd: DateTime.utc(2026, 3, 21, 12),
        totalWeightKg: 50,
        totalVolumeM3: 1,
        category: 'electronics',
        description: 'Fragile boxes',
        status: ShipmentStatus.booked,
        createdAt: DateTime.utc(2026, 3, 20),
        updatedAt: DateTime.utc(2026, 3, 20),
        items: const <ShipmentItemDraft>[],
      ),
    );
    bookings.add(
      BookingRecord(
        id: seededCarrierBookingId,
        shipmentId: seededCarrierShipmentId,
        routeId: 'route-1',
        routeDepartureDate: DateTime.utc(2026, 3, 22),
        oneoffTripId: null,
        shipperId: 'shipper-1',
        carrierId: 'carrier-1',
        vehicleId: 'vehicle-1',
        weightKg: 50,
        volumeM3: 1,
        pricePerKgDzd: 25,
        basePriceDzd: 1250,
        platformFeeDzd: 62.5,
        carrierFeeDzd: 0,
        insuranceRate: null,
        insuranceFeeDzd: 0,
        taxFeeDzd: 0,
        shipperTotalDzd: 1312.5,
        carrierPayoutDzd: 1187.5,
        bookingStatus: BookingStatus.confirmed,
        paymentStatus: PaymentStatus.secured,
        trackingNumber: 'BK-1',
        paymentReference: 'PAY-1',
        createdAt: DateTime.utc(2026, 3, 20),
        updatedAt: DateTime.utc(2026, 3, 20),
      ),
    );
    trackingEvents[seededCarrierBookingId] = [
      TrackingEventRecord(
        id: 'event-1',
        bookingId: seededCarrierBookingId,
        eventType: 'confirmed',
        visibility: 'participant',
        note: null,
        createdBy: 'system',
        recordedAt: DateTime.utc(2026, 3, 20),
        createdAt: DateTime.utc(2026, 3, 20),
      ),
    ];
  }
}

class _FakeShipmentRepository extends ShipmentRepository {
  _FakeShipmentRepository(this.store)
    : super(
        environment: const AppEnvironmentConfig(
          environment: AppEnvironment.local,
        ),
        logger: const DebugAppLogger(),
      );

  final _FakeFlowStore store;

  @override
  Future<List<ShipmentDraftRecord>> fetchMyShipments({
    int limit = ShipmentRepository.defaultPageSize,
    int offset = 0,
  }) async {
    return store.shipments.skip(offset).take(limit).toList(growable: false);
  }

  @override
  Future<ShipmentDraftRecord?> fetchShipmentById(String shipmentId) async {
    return store.shipments
        .where((shipment) => shipment.id == shipmentId)
        .firstOrNull;
  }

  @override
  Future<ShipmentDraftRecord> createShipmentDraft(
    ShipmentDraftInput input,
  ) async {
    final shipment = ShipmentDraftRecord(
      id: 'shipment-${store.shipments.length + 1}',
      shipperId: 'shipper-1',
      originCommuneId: input.originCommuneId,
      destinationCommuneId: input.destinationCommuneId,
      pickupWindowStart: input.pickupWindowStart,
      pickupWindowEnd: input.pickupWindowEnd,
      totalWeightKg: input.totalWeightKg,
      totalVolumeM3: input.totalVolumeM3,
      category: input.category,
      description: input.description,
      status: ShipmentStatus.draft,
      createdAt: DateTime.utc(2026, 3, 21),
      updatedAt: DateTime.utc(2026, 3, 21),
      items: input.items,
    );
    store.shipments.insert(0, shipment);
    return shipment;
  }

  @override
  Future<ShipmentSearchResponse> searchExactLaneCapacity(
    ShipmentSearchQuery query,
  ) async {
    return store.searchResponseFor(query.shipmentId);
  }
}

class _FakeBookingRepository extends BookingRepository {
  _FakeBookingRepository(this.store)
    : super(
        environment: const AppEnvironmentConfig(
          environment: AppEnvironment.local,
        ),
        logger: const DebugAppLogger(),
      );

  final _FakeFlowStore store;

  @override
  Future<List<BookingRecord>> fetchMyShipperBookings({
    int limit = 20,
    int offset = 0,
  }) async {
    return store.bookings.skip(offset).take(limit).toList(growable: false);
  }

  @override
  Future<BookingRecord?> fetchBookingById(String bookingId) async {
    return store.bookings
        .where((booking) => booking.id == bookingId)
        .firstOrNull;
  }

  @override
  Future<List<TrackingEventRecord>> fetchTrackingEvents(
    String bookingId,
  ) async {
    return store.trackingEvents[bookingId] ?? const <TrackingEventRecord>[];
  }

  @override
  Future<ClientSettings> fetchClientSettings() async => store.clientSettings;

  @override
  Future<BookingRecord> createBooking({
    required String shipmentId,
    required String sourceType,
    required String sourceId,
    required bool includeInsurance,
    DateTime? departureDate,
    String? idempotencyKey,
  }) async {
    final booking = BookingRecord(
      id: 'booking-${store.bookings.length + 1}',
      shipmentId: shipmentId,
      routeId: sourceType == 'route' ? sourceId : null,
      routeDepartureDate: departureDate,
      oneoffTripId: sourceType == 'oneoff_trip' ? sourceId : null,
      shipperId: 'shipper-1',
      carrierId: 'carrier-1',
      vehicleId: 'vehicle-1',
      weightKg: 50,
      volumeM3: 1,
      pricePerKgDzd: 25,
      basePriceDzd: 1250,
      platformFeeDzd: 62.5,
      carrierFeeDzd: 0,
      insuranceRate: includeInsurance ? 0.01 : null,
      insuranceFeeDzd: includeInsurance ? 100 : 0,
      taxFeeDzd: 0,
      shipperTotalDzd: includeInsurance ? 1412.5 : 1312.5,
      carrierPayoutDzd: 1187.5,
      bookingStatus: BookingStatus.pendingPayment,
      paymentStatus: PaymentStatus.unpaid,
      trackingNumber: 'BK-${store.bookings.length + 1}',
      paymentReference: 'PAY-${store.bookings.length + 1}',
      createdAt: DateTime.utc(2026, 3, 21),
      updatedAt: DateTime.utc(2026, 3, 21),
    );
    store.bookings.insert(0, booking);
    store.trackingEvents[booking.id] = const <TrackingEventRecord>[];
    return booking;
  }

  @override
  Future<BookingRecord> carrierRecordMilestone({
    required String bookingId,
    required String milestone,
    String? note,
  }) async {
    final booking = store.bookings.firstWhere((item) => item.id == bookingId);
    final updated = BookingRecord(
      id: booking.id,
      shipmentId: booking.shipmentId,
      routeId: booking.routeId,
      routeDepartureDate: booking.routeDepartureDate,
      oneoffTripId: booking.oneoffTripId,
      shipperId: booking.shipperId,
      carrierId: booking.carrierId,
      vehicleId: booking.vehicleId,
      weightKg: booking.weightKg,
      volumeM3: booking.volumeM3,
      pricePerKgDzd: booking.pricePerKgDzd,
      basePriceDzd: booking.basePriceDzd,
      platformFeeDzd: booking.platformFeeDzd,
      carrierFeeDzd: booking.carrierFeeDzd,
      insuranceRate: booking.insuranceRate,
      insuranceFeeDzd: booking.insuranceFeeDzd,
      taxFeeDzd: booking.taxFeeDzd,
      shipperTotalDzd: booking.shipperTotalDzd,
      carrierPayoutDzd: booking.carrierPayoutDzd,
      bookingStatus: switch (milestone) {
        'picked_up' => BookingStatus.pickedUp,
        'in_transit' => BookingStatus.inTransit,
        'delivered_pending_review' => BookingStatus.deliveredPendingReview,
        _ => booking.bookingStatus,
      },
      paymentStatus: booking.paymentStatus,
      trackingNumber: booking.trackingNumber,
      paymentReference: booking.paymentReference,
      createdAt: booking.createdAt,
      updatedAt: DateTime.utc(2026, 3, 21, 1),
    );
    _replaceBooking(updated);
    _appendTracking(bookingId, milestone, note);
    return updated;
  }

  @override
  Future<BookingRecord> shipperConfirmDelivery({
    required String bookingId,
    String? note,
  }) async {
    final booking = store.bookings.firstWhere((item) => item.id == bookingId);
    final updated = BookingRecord(
      id: booking.id,
      shipmentId: booking.shipmentId,
      routeId: booking.routeId,
      routeDepartureDate: booking.routeDepartureDate,
      oneoffTripId: booking.oneoffTripId,
      shipperId: booking.shipperId,
      carrierId: booking.carrierId,
      vehicleId: booking.vehicleId,
      weightKg: booking.weightKg,
      volumeM3: booking.volumeM3,
      pricePerKgDzd: booking.pricePerKgDzd,
      basePriceDzd: booking.basePriceDzd,
      platformFeeDzd: booking.platformFeeDzd,
      carrierFeeDzd: booking.carrierFeeDzd,
      insuranceRate: booking.insuranceRate,
      insuranceFeeDzd: booking.insuranceFeeDzd,
      taxFeeDzd: booking.taxFeeDzd,
      shipperTotalDzd: booking.shipperTotalDzd,
      carrierPayoutDzd: booking.carrierPayoutDzd,
      bookingStatus: BookingStatus.completed,
      paymentStatus: booking.paymentStatus,
      trackingNumber: booking.trackingNumber,
      paymentReference: booking.paymentReference,
      createdAt: booking.createdAt,
      updatedAt: DateTime.utc(2026, 3, 21, 2),
    );
    _replaceBooking(updated);
    _appendTracking(bookingId, 'completed', note);
    return updated;
  }

  void _replaceBooking(BookingRecord updated) {
    final index = store.bookings.indexWhere((item) => item.id == updated.id);
    store.bookings[index] = updated;
  }

  void _appendTracking(String bookingId, String eventType, String? note) {
    final events = store.trackingEvents.putIfAbsent(
      bookingId,
      () => <TrackingEventRecord>[],
    );
    events.insert(
      0,
      TrackingEventRecord(
        id: 'event-${events.length + 1}',
        bookingId: bookingId,
        eventType: eventType,
        visibility: 'participant',
        note: note,
        createdBy: 'user-1',
        recordedAt: DateTime.utc(2026, 3, 21, 3),
        createdAt: DateTime.utc(2026, 3, 21, 3),
      ),
    );
  }
}

class _FakePaymentProofRepository extends PaymentProofRepository {
  _FakePaymentProofRepository(this.store)
    : super(
        environment: const AppEnvironmentConfig(
          environment: AppEnvironment.local,
        ),
        logger: const DebugAppLogger(),
      );

  final _FakeFlowStore store;

  @override
  Future<List<PaymentProofRecord>> fetchPaymentProofsForBooking(
    String bookingId,
  ) async {
    return store.paymentProofs[bookingId] ?? const <PaymentProofRecord>[];
  }

  @override
  Future<PaymentProofRecord> uploadPaymentProof({
    required String bookingId,
    required String paymentRail,
    required VerificationUploadDraft draft,
    required double submittedAmountDzd,
    String? submittedReference,
  }) async {
    final proofs = store.paymentProofs.putIfAbsent(
      bookingId,
      () => <PaymentProofRecord>[],
    );
    final proof = PaymentProofRecord(
      id: 'proof-${proofs.length + 1}',
      bookingId: bookingId,
      storagePath: 'payment-proofs/$bookingId/proof-${proofs.length + 1}.png',
      paymentRail: paymentRail,
      submittedReference: submittedReference,
      submittedAmountDzd: submittedAmountDzd,
      verifiedAmountDzd: null,
      verifiedReference: null,
      status: 'submitted',
      rejectionReason: null,
      reviewedBy: null,
      submittedAt: DateTime.utc(2026, 3, 21, 4),
      reviewedAt: null,
      decisionNote: null,
      version: proofs.length + 1,
    );
    proofs.insert(0, proof);

    final bookingIndex = store.bookings.indexWhere(
      (item) => item.id == bookingId,
    );
    final booking = store.bookings[bookingIndex];
    store.bookings[bookingIndex] = BookingRecord(
      id: booking.id,
      shipmentId: booking.shipmentId,
      routeId: booking.routeId,
      routeDepartureDate: booking.routeDepartureDate,
      oneoffTripId: booking.oneoffTripId,
      shipperId: booking.shipperId,
      carrierId: booking.carrierId,
      vehicleId: booking.vehicleId,
      weightKg: booking.weightKg,
      volumeM3: booking.volumeM3,
      pricePerKgDzd: booking.pricePerKgDzd,
      basePriceDzd: booking.basePriceDzd,
      platformFeeDzd: booking.platformFeeDzd,
      carrierFeeDzd: booking.carrierFeeDzd,
      insuranceRate: booking.insuranceRate,
      insuranceFeeDzd: booking.insuranceFeeDzd,
      taxFeeDzd: booking.taxFeeDzd,
      shipperTotalDzd: booking.shipperTotalDzd,
      carrierPayoutDzd: booking.carrierPayoutDzd,
      bookingStatus: BookingStatus.paymentUnderReview,
      paymentStatus: PaymentStatus.underVerification,
      trackingNumber: booking.trackingNumber,
      paymentReference: booking.paymentReference,
      createdAt: booking.createdAt,
      updatedAt: DateTime.utc(2026, 3, 21, 4),
    );

    return proof;
  }
}

class _FakeDisputeRepository extends DisputeRepository {
  _FakeDisputeRepository(this.store)
    : super(
        environment: const AppEnvironmentConfig(
          environment: AppEnvironment.local,
        ),
        logger: const DebugAppLogger(),
      );

  final _FakeFlowStore store;

  @override
  Future<List<DisputeRecord>> fetchOpenDisputes() async {
    return store.disputes
        .where((dispute) => dispute.status == 'open')
        .toList(growable: false);
  }

  @override
  Future<DisputeRecord> resolveComplete({
    required String disputeId,
    String? resolutionNote,
  }) async {
    final index = store.disputes.indexWhere((item) => item.id == disputeId);
    final dispute = store.disputes[index];
    final updated = DisputeRecord(
      id: dispute.id,
      bookingId: dispute.bookingId,
      openedBy: dispute.openedBy,
      reason: dispute.reason,
      description: dispute.description,
      status: 'resolved',
      resolution: 'complete',
      resolutionNote: resolutionNote,
      resolvedBy: 'admin-1',
      resolvedAt: DateTime.utc(2026, 3, 21, 5),
      createdAt: dispute.createdAt,
      updatedAt: DateTime.utc(2026, 3, 21, 5),
    );
    store.disputes[index] = updated;
    return updated;
  }
}

class _FakeVerificationAdminRepository extends VerificationAdminRepository {
  _FakeVerificationAdminRepository(this.store)
    : super(logger: const DebugAppLogger());

  final _FakeFlowStore store;

  @override
  Future<List<VerificationReviewPacket>> fetchPendingReviewPackets({
    int limit = 20,
  }) async {
    return store.verificationPackets.take(limit).toList(growable: false);
  }

  @override
  Future<VerificationReviewPacket?> fetchPendingReviewPacketByCarrierId(
    String carrierId,
  ) async {
    return store.verificationPackets
        .where((packet) => packet.carrierId == carrierId)
        .firstOrNull;
  }

  @override
  Future<void> approveAllVerificationPacket({
    required VerificationReviewPacket packet,
  }) async {
    store.verificationPackets.removeWhere(
      (candidate) => candidate.carrierId == packet.carrierId,
    );
  }

  @override
  Future<List<AdminAuditLogRecord>> fetchLatestVerificationAudit() async {
    return const <AdminAuditLogRecord>[];
  }
}

class _FakeNotificationRepository extends NotificationRepository {
  _FakeNotificationRepository()
    : super(
        environment: const AppEnvironmentConfig(
          environment: AppEnvironment.local,
        ),
        logger: const DebugAppLogger(),
      );

  @override
  Future<NotificationPage> fetchMyNotificationsPage({
    int offset = 0,
    int limit = NotificationRepository.notificationsPageSize,
  }) async {
    return const NotificationPage(
      items: <AppNotificationRecord>[],
      offset: 0,
      limit: NotificationRepository.notificationsPageSize,
      hasMore: false,
    );
  }
}

ShipmentDraftInput _shipmentInput() {
  return ShipmentDraftInput(
    originCommuneId: 1601,
    destinationCommuneId: 3101,
    pickupWindowStart: DateTime.utc(2026, 3, 21, 8),
    pickupWindowEnd: DateTime.utc(2026, 3, 21, 12),
    totalWeightKg: 50,
    totalVolumeM3: 1,
    category: 'electronics',
    description: 'Fragile boxes',
    items: const [
      ShipmentItemDraft(label: 'Box', quantity: 1, weightKg: 50, volumeM3: 1),
    ],
  );
}

extension FirstOrNullIterable<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
