import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shared repository mappings', () {
    const environment = AppEnvironmentConfig(environment: AppEnvironment.local);
    const logger = DebugAppLogger();

    test('booking repository maps typed client settings payload', () {
      const repository = BookingRepository(
        environment: environment,
        logger: logger,
      );

      final settings = ClientSettings.fromJson({
        'booking_pricing': {
          'platform_fee_rate': 0.05,
          'carrier_fee_rate': 0.01,
          'insurance_rate': 0.02,
          'insurance_min_fee_dzd': 100,
          'tax_rate': 0.19,
          'payment_resubmission_deadline_hours': 24,
        },
        'delivery_review': {'grace_window_hours': 48},
        'app_runtime': {
          'maintenance_mode': false,
          'force_update_required': false,
          'minimum_supported_android_version': 2,
          'minimum_supported_ios_version': 3,
        },
        'platform_payment_accounts': [
          {
            'id': 'pay-1',
            'payment_rail': 'ccp',
            'display_name': 'CCP',
            'account_identifier': '12345',
            'account_holder_name': 'FleetFill',
            'instructions_text': 'Use your payment reference.',
          },
        ],
      });

      expect(repository.environment.environment, AppEnvironment.local);
      expect(settings.bookingPricing.taxRate, 0.19);
      expect(
        settings.paymentAccounts.single.instructionsText,
        'Use your payment reference.',
      );
    });

    test('generated documents expose ready and failed states', () {
      final ready = GeneratedDocumentRecord.fromJson({
        'id': 'doc-ready',
        'booking_id': 'booking-1',
        'document_type': 'payment_receipt',
        'storage_path': 'generated/receipt.pdf',
        'status': 'ready',
      });
      final failed = GeneratedDocumentRecord.fromJson({
        'id': 'doc-failed',
        'booking_id': 'booking-1',
        'document_type': 'payment_receipt',
        'storage_path': 'generated/receipt.pdf',
        'status': 'failed',
      });

      expect(ready.isReady, isTrue);
      expect(failed.isFailed, isTrue);
    });
  });
}
