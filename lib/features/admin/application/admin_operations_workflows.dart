import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminOperationsWorkflowControllerProvider =
    Provider<AdminOperationsWorkflowController>(
      AdminOperationsWorkflowController.new,
    );

class AdminOperationsWorkflowController {
  const AdminOperationsWorkflowController(this.ref);

  final Ref ref;

  Future<void> updatePlatformSetting({
    required String key,
    required Map<String, dynamic> value,
    required bool isPublic,
    String? description,
  }) async {
    await ref
        .read(adminOperationsRepositoryProvider)
        .upsertPlatformSetting(
          key: key,
          value: value,
          isPublic: isPublic,
          description: description,
        );

    ref
      ..invalidate(appBootstrapControllerProvider)
      ..invalidate(clientSettingsProvider)
      ..invalidate(adminPlatformSettingsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminAuditLogsProvider);
  }

  Future<void> resendEmail(String deliveryLogId) async {
    await ref
        .read(adminOperationsRepositoryProvider)
        .resendEmailDelivery(
          deliveryLogId,
        );
    ref
      ..invalidate(adminEmailLogsProvider)
      ..invalidate(
        adminFilteredEmailLogsProvider((status: null, query: null)),
      )
      ..invalidate(adminDeadLetterEmailJobsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminAuditLogsProvider);
  }

  Future<void> resendDeadLetterEmail(String jobId) async {
    await ref
        .read(adminOperationsRepositoryProvider)
        .resendDeadLetterEmailJob(
          jobId,
        );
    ref
      ..invalidate(adminEmailLogsProvider)
      ..invalidate(
        adminFilteredEmailLogsProvider((status: null, query: null)),
      )
      ..invalidate(adminDeadLetterEmailJobsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminAuditLogsProvider);
  }

  Future<void> setUserActive({
    required String profileId,
    required bool isActive,
    String? reason,
  }) async {
    await ref
        .read(adminOperationsRepositoryProvider)
        .setProfileActive(
          profileId: profileId,
          isActive: isActive,
          reason: reason,
        );
    ref
      ..invalidate(adminUsersProvider)
      ..invalidate(adminUserSearchResultsProvider(''))
      ..invalidate(adminUserDetailProvider(profileId))
      ..invalidate(adminAuditLogsProvider);
  }
}
