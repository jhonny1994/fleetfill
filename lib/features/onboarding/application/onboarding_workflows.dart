import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/onboarding/application/onboarding_persistence.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingWorkflowControllerProvider =
    Provider<OnboardingWorkflowController>(
      OnboardingWorkflowController.new,
    );

enum OnboardingNextStep {
  phoneCompletion,
  notificationSetup,
  shipperHome,
  carrierHome,
  adminDashboard
  ;

  String get route {
    return switch (this) {
      OnboardingNextStep.phoneCompletion => AppRoutePath.phoneCompletion,
      OnboardingNextStep.notificationSetup => AppRoutePath.notificationSetup,
      OnboardingNextStep.shipperHome => AppRoutePath.shipperHome,
      OnboardingNextStep.carrierHome => AppRoutePath.carrierHome,
      OnboardingNextStep.adminDashboard => AppRoutePath.adminDashboard,
    };
  }
}

class OnboardingWorkflowController {
  const OnboardingWorkflowController(this.ref);

  final Ref ref;

  Future<OnboardingNextStep> submitProfileSetup({
    required AppUserRole role,
    required String fullName,
    required String phoneNumber,
    String? companyName,
  }) async {
    final trimmedPhone = phoneNumber.trim();
    final preferredLocale = ref.read(effectiveLocaleProvider).languageCode;
    await ref
        .read(authRepositoryProvider)
        .upsertProfile(
          role: role,
          fullName: fullName,
          companyName: companyName,
          phoneNumber: phoneNumber,
          preferredLocale: preferredLocale,
        );
    await ref.read(authSessionControllerProvider.notifier).refresh();
    if (role != AppUserRole.admin && trimmedPhone.isEmpty) {
      return OnboardingNextStep.phoneCompletion;
    }

    return switch (role) {
      AppUserRole.admin => OnboardingNextStep.adminDashboard,
      _ => OnboardingNextStep.notificationSetup,
    };
  }

  Future<OnboardingNextStep> submitPhoneCompletion(String phoneNumber) async {
    await ref.read(authRepositoryProvider).updatePhoneNumber(phoneNumber);
    await ref.read(authSessionControllerProvider.notifier).refresh();
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    if (auth == null) {
      return OnboardingNextStep.notificationSetup;
    }

    if (auth.role == AppUserRole.admin) {
      return OnboardingNextStep.adminDashboard;
    }

    return OnboardingNextStep.notificationSetup;
  }

  Future<OnboardingNextStep> completeNotificationSetup() async {
    await ref
        .read(notificationOnboardingControllerProvider.notifier)
        .markSeen();
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    return switch (auth?.role) {
      AppUserRole.carrier => OnboardingNextStep.carrierHome,
      AppUserRole.admin => OnboardingNextStep.adminDashboard,
      _ => OnboardingNextStep.shipperHome,
    };
  }
}
