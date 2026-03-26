import 'dart:io';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verification workflow helpers', () {
    VerificationDocumentRecord record({
      required String id,
      required VerificationDocumentType type,
      required int version,
      required String status,
      DateTime? createdAt,
      String entityId = 'vehicle-1',
    }) {
      return VerificationDocumentRecord.fromJson({
        'id': id,
        'owner_profile_id': 'carrier-1',
        'entity_type': 'vehicle',
        'entity_id': entityId,
        'document_type': type.databaseValue,
        'storage_path': 'vehicle/$entityId/${type.databaseValue}/$version',
        'status': status,
        'version': version,
        'created_at': (createdAt ?? DateTime(2026, 3, version))
            .toIso8601String(),
        'updated_at': (createdAt ?? DateTime(2026, 3, version))
            .toIso8601String(),
      });
    }

    test('keeps the latest document per type by version', () {
      final documents = [
        record(
          id: 'older-registration',
          type: VerificationDocumentType.truckRegistration,
          version: 1,
          status: 'rejected',
        ),
        record(
          id: 'latest-registration',
          type: VerificationDocumentType.truckRegistration,
          version: 2,
          status: 'pending',
        ),
        record(
          id: 'insurance',
          type: VerificationDocumentType.truckInsurance,
          version: 1,
          status: 'verified',
        ),
      ];

      final latest = latestVerificationDocumentsByType(documents);

      expect(latest, hasLength(2));
      expect(
        latest[0].documentType,
        VerificationDocumentType.truckRegistration,
      );
      expect(latest[0].id, 'latest-registration');
      expect(latest[1].documentType, VerificationDocumentType.truckInsurance);
    });

    test('falls back to created_at when versions match', () {
      final earlier = record(
        id: 'doc-a',
        type: VerificationDocumentType.transportLicense,
        version: 3,
        status: 'pending',
        createdAt: DateTime(2026, 3, 10),
      );
      final later = record(
        id: 'doc-b',
        type: VerificationDocumentType.transportLicense,
        version: 3,
        status: 'verified',
        createdAt: DateTime(2026, 3, 11),
      );

      final latest = latestVerificationDocumentsByType([earlier, later]);

      expect(latest.single.id, 'doc-b');
    });
  });

  group('Carrier operational gates', () {
    const environment = AppEnvironmentConfig(
      supabaseUrl: 'http://127.0.0.1:54321',
    );

    AppBootstrapState bootstrap(AuthSnapshot auth) {
      return AppBootstrapState(
        status: BootstrapStateStatus.ready,
        environment: environment,
        clientSettings: const ClientSettings(
          bookingPricing: BookingPricingSettings(
            platformFeeRate: 0.05,
            carrierFeeRate: 0,
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
          localization: LocalizationSettings(
            fallbackLocale: 'ar',
            enabledLocaleCodes: ['ar', 'fr', 'en'],
          ),
          paymentAccounts: <PlatformPaymentAccountSettings>[],
        ),
        auth: auth,
      );
    }

    AuthSnapshot carrierAuth({
      bool isCarrierVerified = false,
      bool hasPayoutAccount = false,
    }) {
      return AuthSnapshot(
        status: AuthStatus.authenticated,
        userId: 'carrier-1',
        email: 'carrier@example.com',
        role: AppUserRole.carrier,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isCarrierVerified: isCarrierVerified,
        hasPayoutAccount: hasPayoutAccount,
      );
    }

    test('allows verified carriers into route management', () {
      final auth = carrierAuth(isCarrierVerified: true);

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.carrierRoutes,
      );

      expect(decision.target, AppRedirectTarget.none);
    });

    test('keeps unverified carriers out of route management', () {
      final auth = carrierAuth();

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.carrierRoutes,
      );

      expect(decision.target, AppRedirectTarget.verificationGate);
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.carrierProfile,
      );
    });

    test(
      'allows verified carriers without payout accounts into booking worklists',
      () {
        final auth = carrierAuth(isCarrierVerified: true);

        final decision = AppRouteGuards.evaluate(
          bootstrap: bootstrap(auth),
          auth: auth,
          location: AppRoutePath.carrierBookings,
        );

        expect(decision.target, AppRedirectTarget.none);
      },
    );
  });

  group('Verification migration contracts', () {
    late String verificationMigration;
    late String signedFileUrlFunction;

    setUpAll(() {
      verificationMigration = [
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
        '../../backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql',
      ].map((path) => File(path).readAsStringSync()).join('\n');
      signedFileUrlFunction = File(
        '../../backend/supabase/functions/signed-file-url/index.ts',
      ).readAsStringSync();
    });

    test('keeps trusted-operation usage for append-only review writes', () {
      expect(
        verificationMigration.contains(
          "set_config('app.trusted_operation', 'true', true)",
        ),
        isTrue,
      );
      expect(
        verificationMigration.contains('write_admin_audit_log'),
        isTrue,
      );
    });

    test('requires rejection reasons for admin document rejection', () {
      expect(
        verificationMigration.contains(
          'Verification rejection requires a reason',
        ),
        isTrue,
      );
    });

    test(
      'uses current effective documents for packet approval and status refresh',
      () {
        expect(
          verificationMigration.contains(
            'current_effective_verification_documents',
          ),
          isTrue,
        );
        expect(
          verificationMigration.contains(
            'required_verification_documents_complete',
          ),
          isTrue,
        );
        expect(
          verificationMigration.contains('Verification packet is incomplete'),
          isTrue,
        );
      },
    );

    test('keeps signed URL helper authorization and short expiry rules', () {
      expect(
        signedFileUrlFunction.contains('authorize_private_file_access'),
        isTrue,
      );
      expect(
        signedFileUrlFunction.contains('SUPABASE_SECRET_KEY'),
        isTrue,
      );
      expect(
        signedFileUrlFunction.contains('const signedUrlExpirySeconds = 60'),
        isTrue,
      );
    });

    test('protects sensitive columns on insert as well as update', () {
      final securityMigration =
          File(
            '../../backend/supabase/migrations/20260317010000_create_foundation_layer.sql',
          ).readAsStringSync() +
          File(
            '../../backend/supabase/migrations/20260317010000_create_foundation_layer.sql',
          ).readAsStringSync();

      expect(
        securityMigration.contains(
          'before insert or update on public.profiles',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'before insert or update on public.vehicles',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'before insert or update on public.payout_accounts',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'Creating admin profiles directly is not allowed',
        ),
        isTrue,
      );
    });

    test(
      'keeps payment proof access restricted and validates uploaded objects',
      () {
        final securityMigration =
            File(
              '../../backend/supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
            ).readAsStringSync().replaceAll('\r\n', '\n') +
            File(
              '../../backend/supabase/migrations/20260317010000_create_foundation_layer.sql',
            ).readAsStringSync().replaceAll('\r\n', '\n');

        expect(
          securityMigration.contains('payment_proofs_select_shipper_or_admin'),
          isTrue,
        );
        expect(
          securityMigration.contains('b.shipper_id = (select auth.uid())'),
          isTrue,
        );
        expect(
          securityMigration.contains('storage.objects as so'),
          isTrue,
        );
        expect(
          securityMigration.contains(
            'Uploaded verification file is missing for the authorized session',
          ),
          isTrue,
        );
        expect(
          securityMigration.contains(
            'Uploaded proof file is missing for the authorized session',
          ),
          isTrue,
        );
      },
    );
  });
}
