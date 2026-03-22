import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/onboarding/onboarding.dart';
import 'package:fleetfill/features/profile/presentation/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  static const _stepCount = 3;
  int _currentStep = 0;

  Future<void> _continueToAuth(
    BuildContext context,
    WidgetRef ref,
    String location,
  ) async {
    await ref.read(preAuthOnboardingControllerProvider.notifier).markSeen();
    if (!context.mounted) {
      return;
    }
    context.go(location);
  }

  void _goToStep(int index) {
    setState(() => _currentStep = index.clamp(0, _stepCount - 1));
  }

  Widget _buildStep(S s) {
    return switch (_currentStep) {
      0 => _WelcomeOverviewStep(
        key: const ValueKey('welcome-step-overview'),
        highlightsMessage: s.welcomeHighlightsMessage,
        shipperTitle: s.welcomeShipperTitle,
        shipperDescription: s.welcomeShipperDescription,
        carrierTitle: s.welcomeCarrierTitle,
        carrierDescription: s.welcomeCarrierDescription,
      ),
      1 => _WelcomeTrustStep(
        key: const ValueKey('welcome-step-trust'),
        title: s.welcomeTrustTitle,
        description: s.welcomeTrustDescription,
        exactMatchTitle: s.welcomeExactMatchTitle,
        exactMatchDescription: s.welcomeExactMatchDescription,
        paymentTitle: s.welcomePaymentTitle,
        paymentDescription: s.welcomePaymentDescription,
      ),
      _ => _WelcomeLanguageStep(
        key: const ValueKey('welcome-step-language'),
        title: s.welcomeLanguageTitle,
        description: s.welcomeLanguageDescription,
      ),
    };
  }

  Widget _buildProgressDots(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_stepCount, (index) {
        final isActive = index == _currentStep;
        return AnimatedContainer(
          duration: MotionPolicy.duration(context, AppMotion.fast),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isLastStep = _currentStep == _stepCount - 1;

    return AuthScaffold(
      title: s.welcomeTitle,
      subtitle: s.welcomeDescription,
      heroIcon: Icons.local_shipping_rounded,
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressDots(context),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (!isLastStep)
                TextButton(
                  onPressed: () => _goToStep(_stepCount - 1),
                  child: Text(s.welcomeSkipAction),
                ),
              TextButton(
                onPressed: () => context.go(AppRoutePath.sharedPolicies),
                child: Text(s.legalPoliciesTitle),
              ),
            ],
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSwitcher(
            duration: MotionPolicy.duration(context, AppMotion.medium),
            switchInCurve: AppMotion.emphasized,
            switchOutCurve: AppMotion.emphasized,
            child: _buildStep(s),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (isLastStep) ...[
            AuthSubmitButton(
              label: s.authCreateAccountAction,
              isLoading: false,
              onPressed: () => unawaited(
                _continueToAuth(context, ref, AppRoutePath.signUp),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => unawaited(
                _continueToAuth(context, ref, AppRoutePath.signIn),
              ),
              child: Text(s.authSignInAction),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _currentStep == 0
                        ? null
                        : () => _goToStep(_currentStep - 1),
                    child: Text(s.welcomeBackAction),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    onPressed: () => _goToStep(_currentStep + 1),
                    child: Text(s.welcomeNextAction),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _WelcomeOverviewStep extends StatelessWidget {
  const _WelcomeOverviewStep({
    required super.key,
    required this.highlightsMessage,
    required this.shipperTitle,
    required this.shipperDescription,
    required this.carrierTitle,
    required this.carrierDescription,
  });

  final String highlightsMessage;
  final String shipperTitle;
  final String shipperDescription;
  final String carrierTitle;
  final String carrierDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthInfoBanner(
          message: highlightsMessage,
          icon: Icons.verified_user_outlined,
        ),
        const SizedBox(height: AppSpacing.md),
        _WelcomeBenefitTile(
          icon: Icons.inventory_2_outlined,
          title: shipperTitle,
          description: shipperDescription,
        ),
        const SizedBox(height: AppSpacing.sm),
        _WelcomeBenefitTile(
          icon: Icons.local_shipping_outlined,
          title: carrierTitle,
          description: carrierDescription,
        ),
      ],
    );
  }
}

class _WelcomeTrustStep extends StatelessWidget {
  const _WelcomeTrustStep({
    required super.key,
    required this.title,
    required this.description,
    required this.exactMatchTitle,
    required this.exactMatchDescription,
    required this.paymentTitle,
    required this.paymentDescription,
  });

  final String title;
  final String description;
  final String exactMatchTitle;
  final String exactMatchDescription;
  final String paymentTitle;
  final String paymentDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: title, subtitle: description),
        const SizedBox(height: AppSpacing.md),
        _WelcomeBenefitTile(
          icon: Icons.route_outlined,
          title: exactMatchTitle,
          description: exactMatchDescription,
        ),
        const SizedBox(height: AppSpacing.sm),
        _WelcomeBenefitTile(
          icon: Icons.receipt_long_outlined,
          title: paymentTitle,
          description: paymentDescription,
        ),
      ],
    );
  }
}

class _WelcomeLanguageStep extends ConsumerWidget {
  const _WelcomeLanguageStep({
    required super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final currentLocale = ref.watch(effectiveLocaleProvider);
    final currentLanguageName = localizedLanguageName(
      context,
      currentLocale,
      s,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: title, subtitle: description),
        const SizedBox(height: AppSpacing.md),
        ...const [Locale('en'), Locale('fr'), Locale('ar')].map(
          (locale) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _LanguageChoiceTile(locale: locale),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AuthInfoBanner(
          message: s.languageSelectionCurrentMessage(currentLanguageName),
        ),
      ],
    );
  }
}

class _WelcomeBenefitTile extends StatelessWidget {
  const _WelcomeBenefitTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final selectedRole = auth?.role;
    final canSelectRole = selectedRole == null;

    return AppPageScaffold(
      title: s.roleSelectionTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.roleSelectionTitle,
            subtitle: s.roleSelectionDescription,
            showTitle: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          _RoleChoiceCard(
            title: s.roleSelectionShipperTitle,
            description: s.roleSelectionShipperDescription,
            icon: Icons.inventory_2_outlined,
            selected: selectedRole == AppUserRole.shipper,
            onTap: canSelectRole
                ? () => unawaited(
                    _saveRole(
                      context: context,
                      ref: ref,
                      role: AppUserRole.shipper,
                      existingProfile: auth?.profile,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          _RoleChoiceCard(
            title: s.roleSelectionCarrierTitle,
            description: s.roleSelectionCarrierDescription,
            icon: Icons.local_shipping_outlined,
            selected: selectedRole == AppUserRole.carrier,
            onTap: canSelectRole
                ? () => unawaited(
                    _saveRole(
                      context: context,
                      ref: ref,
                      role: AppUserRole.carrier,
                      existingProfile: auth?.profile,
                    ),
                  )
                : null,
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
            showTitle: false,
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
              localizedLanguageName(context, currentLocale, s),
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
            showTitle: false,
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
                  onSubmit: role == null
                      ? null
                      : () => unawaited(_submit(role)),
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
            showTitle: false,
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
  final VoidCallback? onTap;

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

    final title = nativeLanguageName(locale);
    final subtitle = localizedLanguageName(context, locale, s);

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      tileColor: isSelected
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
      title: Text(title),
      subtitle: title == subtitle ? null : Text(subtitle),
      trailing: Icon(
        isSelected ? Icons.check_circle_rounded : Icons.language_rounded,
      ),
      onTap: () async {
        await ref.read(localeControllerProvider.notifier).updateLocale(locale);
      },
    );
  }
}
