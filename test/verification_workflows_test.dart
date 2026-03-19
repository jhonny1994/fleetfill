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
    const environment = AppEnvironmentConfig(environment: AppEnvironment.local);

    AppBootstrapState bootstrap(AuthSnapshot auth) {
      return AppBootstrapState(
        status: BootstrapStateStatus.ready,
        environment: environment,
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

    test('keeps carriers without payout accounts out of booking worklists', () {
      final auth = carrierAuth(isCarrierVerified: true);

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.carrierBookings,
      );

      expect(decision.target, AppRedirectTarget.payoutAccountGate);
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.carrierProfile,
      );
    });
  });

  group('Verification migration contracts', () {
    late String verificationMigration;
    late String signedFileUrlFunction;

    setUpAll(() {
      verificationMigration = File(
        'supabase/migrations/20260318170000_phase_4_verification_review_functions.sql',
      ).readAsStringSync();
      signedFileUrlFunction = File(
        'supabase/functions/signed-file-url/index.ts',
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
        signedFileUrlFunction.contains('SUPABASE_SERVICE_ROLE_KEY'),
        isTrue,
      );
      expect(
        signedFileUrlFunction.contains('const signedUrlExpirySeconds = 60'),
        isTrue,
      );
    });

    test('protects sensitive columns on insert as well as update', () {
      final securityMigration = File(
        'supabase/migrations/20260317150000_phase_2_security_and_runtime_foundation.sql',
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

    test('keeps payment proof access restricted and validates uploaded objects', () {
      final securityMigration = File(
        'supabase/migrations/20260317150000_phase_2_security_and_runtime_foundation.sql',
      ).readAsStringSync();

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
          'Uploaded verification file is missing or metadata does not match the authorized session',
        ),
        isTrue,
      );
      expect(
        securityMigration.contains(
          'Uploaded proof file is missing or metadata does not match the authorized session',
        ),
        isTrue,
      );
    });
  });
}
