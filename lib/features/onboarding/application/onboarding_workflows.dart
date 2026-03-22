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
    final trimmedPhone = phoneNumber.trim();
    await ref
        .read(authRepositoryProvider)
        .upsertProfile(
          role: role,
          fullName: fullName,
          companyName: companyName,
          phoneNumber: phoneNumber,
        );
    await ref.read(authSessionControllerProvider.notifier).refresh();
    if (role != AppUserRole.admin && trimmedPhone.isEmpty) {
      return AppRoutePath.phoneCompletion;
    }

    final nextRoute = switch (role) {
      AppUserRole.carrier => AppRoutePath.carrierHome,
      AppUserRole.admin => AppRoutePath.adminDashboard,
      AppUserRole.shipper => AppRoutePath.shipperHome,
    };
    return nextRoute;
  }

  Future<String> submitPhoneCompletion(String phoneNumber) async {
    await ref.read(authRepositoryProvider).updatePhoneNumber(phoneNumber);
    await ref.read(authSessionControllerProvider.notifier).refresh();
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    if (auth == null) {
      return AppRoutePath.signIn;
    }

    return AppRouteGuards.homeLocation(auth);
  }
}
