import 'package:fleetfill/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingWorkflowControllerProvider =
    Provider<OnboardingWorkflowController>(
      OnboardingWorkflowController.new,
    );

class OnboardingWorkflowController {
  const OnboardingWorkflowController(this.ref);

  final Ref ref;

  Future<String> submitProfileSetup({
    required AppUserRole role,
    required String fullName,
    required String phoneNumber,
    String? companyName,
  }) async {
    await ref
        .read(authRepositoryProvider)
        .upsertProfile(
          role: role,
          fullName: fullName,
          companyName: companyName,
          phoneNumber: phoneNumber,
        );
    await ref.read(authSessionControllerProvider.notifier).refresh();
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    return auth == null
        ? AppRoutePath.signIn
        : AppRouteGuards.authenticatedEntryLocation(auth);
  }

  Future<String> submitPhoneCompletion(String phoneNumber) async {
    await ref.read(authRepositoryProvider).updatePhoneNumber(phoneNumber);
    await ref.read(authSessionControllerProvider.notifier).refresh();
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    return auth == null
        ? AppRoutePath.signIn
        : AppRouteGuards.authenticatedEntryLocation(auth);
  }
}
