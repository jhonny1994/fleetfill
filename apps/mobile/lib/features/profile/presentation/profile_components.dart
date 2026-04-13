import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    required this.title,
    required this.rows,
    super.key,
  });

  final String title;
  final List<ProfileSummaryRow> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            ...rows.indexed.expand((entry) {
              final index = entry.$1;
              final row = entry.$2;
              return <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        row.label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      flex: 2,
                      child: Text(
                        row.value,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                if (index != rows.length - 1)
                  const Divider(height: AppSpacing.lg),
              ];
            }),
          ],
        ),
      ),
    );
  }
}

class ProfileSummaryRow {
  const ProfileSummaryRow({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileDetailsFormFields extends StatelessWidget {
  const ProfileDetailsFormFields({
    required this.role,
    required this.nameController,
    required this.companyController,
    required this.phoneController,
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final AppUserRole? role;
  final TextEditingController nameController;
  final TextEditingController companyController;
  final TextEditingController phoneController;
  final bool isSubmitting;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final requiresPhone = role != AppUserRole.admin;
    final isCarrier = role == AppUserRole.carrier;

    String? nameValidator(String? value) {
      final normalized = InputSanitizers.normalizePersonName(value);
      if (normalized == null) {
        return s.authRequiredFieldMessage;
      }
      if (!InputSanitizers.isValidPersonName(normalized)) {
        return s.profileInvalidNameMessage;
      }
      return null;
    }

    String? companyValidator(String? value) {
      final normalized = InputSanitizers.normalizeCompanyName(value);
      if (normalized == null) {
        return s.authRequiredFieldMessage;
      }
      if (!InputSanitizers.isValidCompanyName(normalized)) {
        return s.profileInvalidCompanyNameMessage;
      }
      return null;
    }

    String? algerianPhoneValidator(String? value) {
      final normalized = InputSanitizers.normalizeAlgerianPhoneNumber(value);
      if (normalized == null && requiresPhone) {
        return s.profileInvalidAlgerianPhoneMessage;
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          controller: nameController,
          label: s.profileFullNameLabel,
          textInputAction: isCarrier
              ? TextInputAction.next
              : TextInputAction.done,
          validator: nameValidator,
        ),
        if (isCarrier) ...[
          const SizedBox(height: AppSpacing.md),
          AuthTextField(
            controller: companyController,
            label: s.profileCompanyNameLabel,
            textInputAction: TextInputAction.next,
            validator: companyValidator,
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        AuthTextField(
          controller: phoneController,
          label: s.profilePhoneLabel,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          hintText: '0550123456',
          validator: algerianPhoneValidator,
          onFieldSubmitted: (_) => onSubmit?.call(),
        ),
        const SizedBox(height: AppSpacing.lg),
        AuthSubmitButton(
          label: s.profileSetupSaveAction,
          isLoading: isSubmitting,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}

class ProfileEditForm extends ConsumerStatefulWidget {
  const ProfileEditForm({
    required this.role,
    required this.title,
    required this.description,
    required this.successMessage,
    super.key,
  });

  final AppUserRole role;
  final String title;
  final String description;
  final String successMessage;

  @override
  ConsumerState<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends ConsumerState<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _phoneController;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final profile = auth?.profile;

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
      title: widget.title,
      child: ListView(
        children: [
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppFocusTraversal.form(
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: ProfileDetailsFormFields(
                  role: widget.role,
                  nameController: _nameController,
                  companyController: _companyController,
                  phoneController: _phoneController,
                  isSubmitting: _isSaving,
                  onSubmit: () => unawaited(_save()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final s = S.of(context);
    final preferredLocale = ref.read(effectiveLocaleProvider).languageCode;

    try {
      await ref
          .read(authRepositoryProvider)
          .upsertProfile(
            role: widget.role,
            fullName: _nameController.text,
            companyName: widget.role == AppUserRole.carrier
                ? _companyController.text
                : null,
            phoneNumber: _phoneController.text,
            preferredLocale: preferredLocale,
          );
      await ref.read(authSessionControllerProvider.notifier).refresh();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, widget.successMessage);
      context.pop();
    } on AuthException catch (error) {
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, mapAuthExceptionMessage(s, error));
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);

    return OutlinedButton.icon(
      onPressed: () => unawaited(_signOut(context, ref)),
      icon: const Icon(Icons.logout_rounded),
      label: Text(s.settingsSignOutAction),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    await ref.read(authSessionControllerProvider.notifier).signOut();
    if (!context.mounted) {
      return;
    }
    AppFeedback.showSnackBar(context, S.of(context).settingsSignedOutMessage);
    context.go(AppRoutePath.signIn);
  }
}

String verificationStatusLabel(S s, AppVerificationState? state) {
  return switch (state) {
    AppVerificationState.verified => s.carrierProfileVerificationVerified,
    AppVerificationState.rejected => s.carrierProfileVerificationRejected,
    _ => s.carrierProfileVerificationPending,
  };
}
