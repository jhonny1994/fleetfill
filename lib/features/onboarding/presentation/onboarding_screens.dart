import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/onboarding/onboarding.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final selectedRole = auth?.role;

    return AppPageScaffold(
      title: s.roleSelectionTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.roleSelectionTitle,
            subtitle: s.roleSelectionDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          _RoleChoiceCard(
            title: s.roleSelectionShipperTitle,
            description: s.roleSelectionShipperDescription,
            icon: Icons.inventory_2_outlined,
            selected: selectedRole == AppUserRole.shipper,
            onTap: () => unawaited(
              _saveRole(
                context: context,
                ref: ref,
                role: AppUserRole.shipper,
                existingProfile: auth?.profile,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _RoleChoiceCard(
            title: s.roleSelectionCarrierTitle,
            description: s.roleSelectionCarrierDescription,
            icon: Icons.local_shipping_outlined,
            selected: selectedRole == AppUserRole.carrier,
            onTap: () => unawaited(
              _saveRole(
                context: context,
                ref: ref,
                role: AppUserRole.carrier,
                existingProfile: auth?.profile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveRole({
    required BuildContext context,
    required WidgetRef ref,
    required AppUserRole role,
    required AppProfile? existingProfile,
  }) async {
    final repository = ref.read(authRepositoryProvider);
    final s = S.of(context);

    try {
      await repository.upsertProfile(
        role: role,
        fullName: existingProfile?.fullName,
        companyName: role == AppUserRole.carrier
            ? existingProfile?.companyName
            : null,
        phoneNumber: existingProfile?.phoneNumber,
      );
      await ref.read(authSessionControllerProvider.notifier).refresh();
      if (!context.mounted) {
        return;
      }
      context.go(AppRoutePath.profileSetup);
    } on AuthException catch (error) {
      if (!context.mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAuthErrorMessage(s, error.message));
    }
  }
}

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final currentLocale = ref.watch(effectiveLocaleProvider);

    return AppPageScaffold(
      title: s.languageSelectionTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.languageSelectionTitle,
            subtitle: s.languageSelectionDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          ...const [
            Locale('en'),
            Locale('fr'),
            Locale('ar'),
          ].map(
            (locale) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _LanguageChoiceTile(locale: locale),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AuthInfoBanner(
            message: s.languageSelectionCurrentMessage(
              currentLocale.languageCode,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _phoneController;
  bool _initialized = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final profile = auth?.profile;
    final role = auth?.role;

    if (!_initialized) {
      _nameController = TextEditingController(text: profile?.fullName ?? '');
      _companyController = TextEditingController(
        text: profile?.companyName ?? '',
      );
      _phoneController = TextEditingController(
        text: profile?.phoneNumber ?? '',
      );
      _initialized = true;
    }

    return AppPageScaffold(
      title: s.profileSetupTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.profileSetupTitle,
            subtitle: s.profileSetupDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppFocusTraversal.form(
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: ProfileDetailsFormFields(
                  role: role,
                  nameController: _nameController,
                  companyController: _companyController,
                  phoneController: _phoneController,
                  isSubmitting: _isSubmitting,
                  onSubmit: role == null ? null : () => unawaited(_submit(role)),
                ),
              ),
            ),
          ),
          if (role == AppUserRole.carrier) ...[
            const SizedBox(height: AppSpacing.md),
            AuthInfoBanner(message: s.profileCarrierVerificationHint),
          ],
        ],
      ),
    );
  }

  Future<void> _submit(AppUserRole? role) async {
    if (role == null || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    final s = S.of(context);

    try {
      final nextLocation = await ref
          .read(onboardingWorkflowControllerProvider)
          .submitProfileSetup(
            role: role,
            fullName: _nameController.text,
            companyName: role == AppUserRole.carrier
                ? _companyController.text
                : null,
            phoneNumber: _phoneController.text,
          );
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.profileSetupSavedMessage);
      context.go(nextLocation);
    } on AuthException catch (error) {
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAuthErrorMessage(s, error.message));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class PhoneCompletionScreen extends ConsumerStatefulWidget {
  const PhoneCompletionScreen({super.key});

  @override
  ConsumerState<PhoneCompletionScreen> createState() =>
      _PhoneCompletionScreenState();
}

class _PhoneCompletionScreenState extends ConsumerState<PhoneCompletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _initialized = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;

    if (!_initialized) {
      _phoneController.text = auth?.profile?.phoneNumber ?? '';
      _initialized = true;
    }

    return AppPageScaffold(
      title: s.phoneCompletionTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.phoneCompletionTitle,
            subtitle: s.phoneCompletionDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppFocusTraversal.form(
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthTextField(
                      controller: _phoneController,
                      label: s.profilePhoneLabel,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      validator: (value) => (value ?? '').trim().isEmpty
                          ? s.authRequiredFieldMessage
                          : null,
                      onFieldSubmitted: (_) => unawaited(_submit()),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AuthSubmitButton(
                      label: s.phoneCompletionSaveAction,
                      isLoading: _isSubmitting,
                      onPressed: () => unawaited(_submit()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    final s = S.of(context);

    try {
      final nextLocation = await ref
          .read(onboardingWorkflowControllerProvider)
          .submitPhoneCompletion(_phoneController.text);
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.phoneCompletionSavedMessage);
      context.go(nextLocation);
    } on AuthException catch (error) {
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAuthErrorMessage(s, error.message));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class _RoleChoiceCard extends StatelessWidget {
  const _RoleChoiceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: selected ? colorScheme.secondaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(description),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.chevron_right_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageChoiceTile extends ConsumerWidget {
  const _LanguageChoiceTile({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final currentLocale = ref.watch(effectiveLocaleProvider);
    final isSelected = currentLocale.languageCode == locale.languageCode;

    final title = switch (locale.languageCode) {
      'ar' => s.languageOptionArabic,
      'fr' => s.languageOptionFrench,
      _ => s.languageOptionEnglish,
    };

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      tileColor: isSelected
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
      title: Text(title),
      trailing: Icon(
        isSelected ? Icons.check_circle_rounded : Icons.language_rounded,
      ),
      onTap: () async {
        await ref.read(localeControllerProvider.notifier).updateLocale(locale);
      },
    );
  }
}
