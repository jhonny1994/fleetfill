import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Automation auth contract', () {
    late String runtimeHelpers;
    late String automationTick;
    late String configToml;
    late String schedulerMigration;
    late String schedulerScript;
    late String envExample;

    setUpAll(() {
      runtimeHelpers = File(
        'supabase/functions/_shared/email-runtime.ts',
      ).readAsStringSync();
      automationTick = File(
        'supabase/functions/scheduled-automation-tick/index.ts',
      ).readAsStringSync();
      configToml = File('supabase/config.toml').readAsStringSync();
      schedulerMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      schedulerScript = File(
        'supabase/scripts/configure_scheduled_automation.sql',
      ).readAsStringSync();
      envExample = File('.env.example').readAsStringSync();
    });

    test('uses the internal automation token in shared runtime helpers', () {
      expect(
        runtimeHelpers.contains('requiredInternalAutomationToken'),
        isTrue,
      );
      expect(runtimeHelpers.contains('requiredSupabaseSecretKey'), isTrue);
      expect(runtimeHelpers.contains('hasInternalAutomationAccess'), isTrue);
      expect(runtimeHelpers.contains('INTERNAL_AUTOMATION_TOKEN'), isTrue);
      expect(runtimeHelpers.contains('SUPABASE_SECRET_KEY'), isTrue);
      expect(runtimeHelpers.contains('SUPABASE_SERVICE_ROLE_KEY'), isFalse);
    });

    test('uses the internal automation token for scheduler fanout', () {
      expect(
        automationTick.contains(
          r'Authorization: `Bearer ${internalAutomationToken}`',
        ),
        isTrue,
      );
      expect(
        automationTick.contains('requiredInternalAutomationToken'),
        isTrue,
      );
    });

    test('disables gateway jwt verification for internal worker endpoints', () {
      expect(
        configToml.contains(
          '[functions.scheduled-automation-tick]\nverify_jwt = false',
        ),
        isTrue,
      );
      expect(
        configToml.contains(
          '[functions.transactional-email-dispatch-worker]\nverify_jwt = false',
        ),
        isTrue,
      );
      expect(
        configToml.contains(
          '[functions.generated-document-worker]\nverify_jwt = false',
        ),
        isTrue,
      );
      expect(
        configToml.contains(
          '[functions.push-dispatch-worker]\nverify_jwt = false',
        ),
        isTrue,
      );
    });

    test('uses the new vault secret name for scheduler invocation', () {
      expect(
        schedulerMigration.contains('fleetfill_internal_automation_token'),
        isTrue,
      );
      expect(
        schedulerScript.contains('fleetfill_internal_automation_token'),
        isTrue,
      );
      expect(
        schedulerMigration.contains('fleetfill_service_role_key'),
        isFalse,
      );
      expect(
        schedulerScript.contains('fleetfill_service_role_key'),
        isFalse,
      );
    });

    test(
      'documents the internal automation token in the shared env example',
      () {
        expect(envExample.contains('INTERNAL_AUTOMATION_TOKEN='), isTrue);
        expect(envExample.contains('SUPABASE_SECRET_KEY='), isTrue);
        expect(envExample.contains('SUPABASE_SERVICE_ROLE_KEY='), isFalse);
      },
    );
  });
}
