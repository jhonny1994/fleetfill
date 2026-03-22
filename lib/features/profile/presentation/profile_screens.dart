import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final locale = ref.watch(effectiveLocaleProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return AppPageScaffold(
      title: s.settingsTitle,
      child: ListView(
        key: const PageStorageKey<String>('settings-screen-list'),
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
              ProfileSummaryRow(
                label: s.settingsThemeModeTitle,
                value: _themeModeLabel(s, themeMode),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppListCard(
            title: s.languageSelectionTitle,
            subtitle: s.languageSelectionCurrentMessage(
              locale.languageCode.toUpperCase(),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.languageSelection),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.settingsThemeModeTitle,
            subtitle: _themeModeLabel(s, themeMode),
            trailing: const Icon(Icons.palette_outlined),
            onTap: () => unawaited(
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => const _ThemeSelectionSheet(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.notificationsPermissionTitle,
            subtitle: s.notificationsPermissionDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.notificationsHelp),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.notificationsCenterTitle,
            subtitle: s.notificationsCenterDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.sharedNotifications),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.supportTitle,
            subtitle: s.supportDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.sharedSupport),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppListCard(
            title: s.legalPoliciesTitle,
            subtitle: s.legalPoliciesDescription,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutePath.sharedPolicies),
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

class PayoutAccountsScreen extends ConsumerWidget {
  const PayoutAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final payoutAccountsAsync = ref.watch(myPayoutAccountsProvider);

    return AppPageScaffold(
      title: s.payoutAccountsTitle,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) => const _PayoutAccountEditorSheet(),
          ),
        ),
        icon: const Icon(Icons.add_rounded),
        label: Text(s.payoutAccountAddAction),
      ),
      child: AppAsyncStateView<List<CarrierPayoutAccount>>(
        value: payoutAccountsAsync,
        onRetry: () => ref.invalidate(myPayoutAccountsProvider),
        data: (accounts) {
          if (accounts.isEmpty) {
            return AppEmptyState(
              title: s.payoutAccountsTitle,
              message: s.payoutAccountsDescription,
              action: FilledButton(
                onPressed: () => unawaited(
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const _PayoutAccountEditorSheet(),
                  ),
                ),
                child: Text(s.payoutAccountAddAction),
              ),
            );
          }

          return ListView.separated(
            key: const PageStorageKey<String>('payout-accounts-list'),
            itemCount: accounts.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final account = accounts[index];
              return AppListCard(
                title: _payoutAccountTypeLabel(s, account.accountType),
                subtitle: _payoutAccountSubtitle(account),
                leading: AppStatusChip(
                  label: account.isActive
                      ? s.publicationActiveLabel
                      : s.publicationInactiveLabel,
                  tone: account.isActive
                      ? AppStatusTone.success
                      : AppStatusTone.warning,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => unawaited(
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _PayoutAccountEditorSheet(
                      account: account,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PayoutAccountEditorSheet extends ConsumerStatefulWidget {
  const _PayoutAccountEditorSheet({this.account});

  final CarrierPayoutAccount? account;

  @override
  ConsumerState<_PayoutAccountEditorSheet> createState() =>
      _PayoutAccountEditorSheetState();
}

class _PayoutAccountEditorSheetState
    extends ConsumerState<_PayoutAccountEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  final _holderController = TextEditingController();
  final _identifierController = TextEditingController();
  final _bankNameController = TextEditingController();
  PayoutAccountType _selectedType = PayoutAccountType.ccp;
  bool _isActive = true;
  bool _isSaving = false;
  bool _initialized = false;

  @override
  void dispose() {
    _holderController.dispose();
    _identifierController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (!_initialized) {
      _selectedType = widget.account?.accountType ?? PayoutAccountType.ccp;
      _holderController.text = widget.account?.accountHolderName ?? '';
      _identifierController.text = widget.account?.accountIdentifier ?? '';
      _bankNameController.text = widget.account?.bankOrCcpName ?? '';
      _isActive = widget.account?.isActive ?? true;
      _initialized = true;
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: AppFocusTraversal.sheet(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.account == null
                    ? s.payoutAccountAddAction
                    : s.payoutAccountEditAction,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<PayoutAccountType>(
                initialValue: _selectedType,
                decoration: InputDecoration(
                  labelText: s.payoutAccountTypeLabel,
                ),
                items: PayoutAccountType.values
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(_payoutAccountTypeLabel(s, type)),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: _holderController,
                label: s.payoutAccountHolderLabel,
                validator: _required,
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: _identifierController,
                label: s.payoutAccountIdentifierLabel,
                validator: _required,
              ),
              const SizedBox(height: AppSpacing.md),
              AuthTextField(
                controller: _bankNameController,
                label: s.payoutAccountInstitutionLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(s.routeStatusLabel),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthSubmitButton(
                label: widget.account == null
                    ? s.payoutAccountSaveAction
                    : s.payoutAccountSaveAction,
                isLoading: _isSaving,
                onPressed: () => unawaited(_save()),
              ),
              if (widget.account != null) ...[
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: _isSaving ? null : () => unawaited(_delete()),
                  child: Text(s.payoutAccountDeleteAction),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final s = S.of(context);
    setState(() => _isSaving = true);
    try {
      final repository = ref.read(payoutAccountRepositoryProvider);
      if (widget.account == null) {
        await repository.createPayoutAccount(
          accountType: _selectedType,
          accountHolderName: _holderController.text,
          accountIdentifier: _identifierController.text,
          bankOrCcpName: _bankNameController.text,
          isActive: _isActive,
        );
      } else {
        await repository.updatePayoutAccount(
          payoutAccountId: widget.account!.id,
          accountType: _selectedType,
          accountHolderName: _holderController.text,
          accountIdentifier: _identifierController.text,
          bankOrCcpName: _bankNameController.text,
          isActive: _isActive,
        );
      }

      ref.invalidate(myPayoutAccountsProvider);
      await ref.read(authSessionControllerProvider.notifier).refresh();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.payoutAccountSavedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _delete() async {
    final s = S.of(context);
    final account = widget.account;
    if (account == null) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppFocusTraversal.dialog(
        child: AlertDialog(
          title: Text(s.payoutAccountDeleteAction),
          content: Text(s.payoutAccountDeleteConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(s.cancelLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(s.confirmLabel),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref
          .read(payoutAccountRepositoryProvider)
          .deletePayoutAccount(account.id);
      ref.invalidate(myPayoutAccountsProvider);
      await ref.read(authSessionControllerProvider.notifier).refresh();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.payoutAccountDeletedMessage);
      Navigator.of(context).pop();
    } on PostgrestException catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  String? _required(String? value) {
    return (value ?? '').trim().isEmpty
        ? S.of(context).authRequiredFieldMessage
        : null;
  }
}

class _ThemeSelectionSheet extends ConsumerWidget {
  const _ThemeSelectionSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final themeMode = ref.watch(themeControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              s.settingsThemeModeTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final mode in ThemeMode.values) ...[
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                title: Text(_themeModeLabel(s, mode)),
                trailing: Icon(
                  themeMode == mode
                      ? Icons.check_circle_rounded
                      : Icons.chevron_right_rounded,
                ),
                onTap: () {
                  unawaited(
                    ref
                        .read(themeControllerProvider.notifier)
                        .setThemeMode(mode),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _payoutAccountTypeLabel(S s, PayoutAccountType type) {
  return switch (type) {
    PayoutAccountType.ccp => s.payoutAccountTypeCcpLabel,
    PayoutAccountType.dahabia => s.payoutAccountTypeDahabiaLabel,
    PayoutAccountType.bank => s.payoutAccountTypeBankLabel,
  };
}

String _payoutAccountSubtitle(CarrierPayoutAccount account) {
  final identifier = account.accountIdentifier;
  final masked = identifier.length <= 4
      ? identifier
      : '***${identifier.substring(identifier.length - 4)}';
  return [
    if ((account.bankOrCcpName ?? '').isNotEmpty) account.bankOrCcpName!,
    masked,
  ].join(' • ');
}

String _themeModeLabel(S s, ThemeMode mode) {
  return switch (mode) {
    ThemeMode.system => s.settingsThemeModeSystemLabel,
    ThemeMode.light => s.settingsThemeModeLightLabel,
    ThemeMode.dark => s.settingsThemeModeDarkLabel,
  };
}
