import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final locale = ref.watch(effectiveLocaleProvider);

    return AppPageScaffold(
      title: s.settingsTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.settingsTitle,
            subtitle: s.settingsDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSummaryCard(
            title: s.settingsAccountSectionTitle,
            rows: [
              ProfileSummaryRow(
                label: s.authEmailLabel,
                value: auth?.email ?? '-',
              ),
              ProfileSummaryRow(
                label: s.languageSelectionTitle,
                value: locale.languageCode.toUpperCase(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const SignOutButton(),
        ],
      ),
    );
  }
}

class ShipperProfileScreen extends ConsumerWidget {
  const ShipperProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final profile = ref
        .watch(authSessionControllerProvider)
        .asData
        ?.value
        .profile;

    return AppPageScaffold(
      title: s.shipperProfileTitle,
      actions: [
        IconButton(
          onPressed: () => context.go(AppRoutePath.shipperProfileEdit()),
          icon: const Icon(Icons.edit_outlined),
          tooltip: s.editShipperProfileTitle,
        ),
      ],
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.shipperProfileTitle,
            subtitle: s.shipperProfileDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSummaryCard(
            title: s.shipperProfileSectionTitle,
            rows: [
              ProfileSummaryRow(
                label: s.profileFullNameLabel,
                value: profile?.fullName ?? '-',
              ),
              ProfileSummaryRow(
                label: s.profilePhoneLabel,
                value: profile?.phoneNumber ?? '-',
              ),
              ProfileSummaryRow(
                label: s.authEmailLabel,
                value: profile?.email ?? '-',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppListCard(
            title: s.settingsTitle,
            subtitle: s.settingsDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.sharedSettings),
          ),
        ],
      ),
    );
  }
}

class EditShipperProfileScreen extends StatelessWidget {
  const EditShipperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return ProfileEditForm(
      role: AppUserRole.shipper,
      title: s.editShipperProfileTitle,
      description: s.editShipperProfileDescription,
      successMessage: s.editShipperProfileSavedMessage,
    );
  }
}

class CarrierProfileScreen extends ConsumerWidget {
  const CarrierProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final profile = ref
        .watch(authSessionControllerProvider)
        .asData
        ?.value
        .profile;

    return AppPageScaffold(
      title: s.carrierProfileTitle,
      actions: [
        IconButton(
          onPressed: () => context.go(AppRoutePath.carrierProfileEdit()),
          icon: const Icon(Icons.edit_outlined),
          tooltip: s.editCarrierProfileTitle,
        ),
      ],
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.carrierProfileTitle,
            subtitle: s.carrierProfileDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSummaryCard(
            title: s.carrierProfileSectionTitle,
            rows: [
              ProfileSummaryRow(
                label: s.profileFullNameLabel,
                value: profile?.fullName ?? '-',
              ),
              ProfileSummaryRow(
                label: s.profileCompanyNameLabel,
                value: profile?.companyName ?? '-',
              ),
              ProfileSummaryRow(
                label: s.profilePhoneLabel,
                value: profile?.phoneNumber ?? '-',
              ),
              ProfileSummaryRow(
                label: s.carrierProfileVerificationLabel,
                value: verificationStatusLabel(s, profile?.verificationStatus),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppListCard(
            title: s.vehiclesTitle,
            subtitle: s.vehiclesDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.carrierVehicles()),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.carrierVerificationCenterTitle,
            subtitle: s.carrierVerificationCenterDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.carrierVerification),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.payoutAccountsTitle,
            subtitle: s.payoutAccountsDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.carrierPayoutAccounts()),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.settingsTitle,
            subtitle: s.settingsDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.sharedSettings),
          ),
          const SizedBox(height: AppSpacing.md),
          AuthInfoBanner(message: s.profileCarrierVerificationHint),
        ],
      ),
    );
  }

}

class EditCarrierProfileScreen extends StatelessWidget {
  const EditCarrierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return ProfileEditForm(
      role: AppUserRole.carrier,
      title: s.editCarrierProfileTitle,
      description: s.editCarrierProfileDescription,
      successMessage: s.editCarrierProfileSavedMessage,
    );
  }
}

class PayoutAccountsScreen extends StatelessWidget {
  const PayoutAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPageScaffold(
      title: s.payoutAccountsTitle,
      child: AppEmptyState(
        title: s.payoutAccountsTitle,
        message: s.payoutAccountsDescription,
      ),
    );
  }
}
