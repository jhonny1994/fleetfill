import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculateBookingQuote', () {
    test('calculates pricing with insurance and tax from client settings', () {
      const settings = ClientSettings(
        bookingPricing: BookingPricingSettings(
          platformFeeRate: 0.1,
          carrierFeeRate: 0.05,
          insuranceRate: 0.02,
          insuranceMinFeeDzd: 50,
          taxRate: 0.19,
          paymentResubmissionDeadlineHours: 24,
        ),
        deliveryReview: DeliveryReviewSettings(graceWindowHours: 24),
        appRuntime: AppRuntimeSettings(
          maintenanceMode: false,
          forceUpdateRequired: false,
          minimumSupportedAndroidVersion: 1,
          minimumSupportedIosVersion: 1,
        ),
        localization: LocalizationSettings(
          fallbackLocale: 'ar',
          enabledLocaleCodes: ['ar', 'fr', 'en'],
        ),
        paymentAccounts: <PlatformPaymentAccountSettings>[],
      );

      final quote = calculateBookingQuote(
        bookingSelection: BookingReviewSelection(
          shipment: ShipmentDraftRecord(
            id: 'shipment-1',
            shipperId: 'shipper-1',
            originCommuneId: 1,
            destinationCommuneId: 2,
            totalWeightKg: 100,
            totalVolumeM3: 4,
            details: 'Fragile cargo',
            status: ShipmentStatus.draft,
            createdAt: DateTime.utc(2026, 3, 19),
            updatedAt: DateTime.utc(2026, 3, 19),
          ),
          requestedDate: DateTime.utc(2026, 3, 21),
          result: ShipmentSearchResult(
            sourceId: 'route-1',
            sourceType: 'route',
            carrierId: 'carrier-1',
            carrierName: 'Atlas Freight',
            vehicleId: 'vehicle-1',
            originCommuneId: 1,
            destinationCommuneId: 2,
            departureAt: DateTime.utc(2026, 3, 21, 9),
            departureDate: DateTime.utc(2026, 3, 21),
            totalCapacityKg: 1000,
            totalCapacityVolumeM3: 10,
            remainingCapacityKg: 500,
            remainingVolumeM3: 5,
            pricePerKgDzd: 20,
            estimatedTotalDzd: 2000,
            ratingAverage: 4.7,
            ratingCount: 11,
            dayDistance: 0,
          ),
        ),
        includeInsurance: true,
        settings: settings,
      );

      expect(quote.basePriceDzd, 2000);
      expect(quote.platformFeeDzd, 200);
      expect(quote.carrierFeeDzd, 100);
      expect(quote.insuranceFeeDzd, 50);
      expect(quote.taxFeeDzd, 446.5);
      expect(quote.shipperTotalDzd, 2796.5);
      expect(quote.carrierPayoutDzd, 2100);
    });

    test('omits insurance when not requested', () {
      final quote = calculateBookingQuote(
        bookingSelection: BookingReviewSelection(
          shipment: const ShipmentDraftRecord(
            id: 'shipment-2',
            shipperId: 'shipper-1',
            originCommuneId: 1,
            destinationCommuneId: 2,
            totalWeightKg: 10,
            totalVolumeM3: null,
            details: null,
            status: ShipmentStatus.draft,
            createdAt: null,
            updatedAt: null,
          ),
          requestedDate: DateTime.utc(2026, 3, 21),
          result: ShipmentSearchResult(
            sourceId: 'route-2',
            sourceType: 'route',
            carrierId: 'carrier-1',
            carrierName: 'Atlas Freight',
            vehicleId: 'vehicle-1',
            originCommuneId: 1,
            destinationCommuneId: 2,
            departureAt: DateTime.utc(2026, 3, 21, 9),
            departureDate: DateTime.utc(2026, 3, 21),
            totalCapacityKg: 1000,
            totalCapacityVolumeM3: null,
            remainingCapacityKg: 500,
            remainingVolumeM3: null,
            pricePerKgDzd: 30,
            estimatedTotalDzd: 300,
            ratingAverage: 4,
            ratingCount: 5,
            dayDistance: 0,
          ),
        ),
        includeInsurance: false,
        settings: null,
      );

      expect(quote.insuranceRate, isNull);
      expect(quote.insuranceFeeDzd, 0);
    });
  });
}
