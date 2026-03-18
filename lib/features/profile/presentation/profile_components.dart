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
    final s = S.of(context);
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
          AppSectionHeader(title: widget.title, subtitle: widget.description),
          const SizedBox(height: AppSpacing.lg),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTextField(
                    controller: _nameController,
                    label: s.profileFullNameLabel,
                    textInputAction: TextInputAction.next,
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? s.authRequiredFieldMessage
                        : null,
                  ),
                  if (widget.role == AppUserRole.carrier) ...[
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _companyController,
                      label: s.profileCompanyNameLabel,
                      textInputAction: TextInputAction.next,
                      validator: (value) => (value ?? '').trim().isEmpty
                          ? s.authRequiredFieldMessage
                          : null,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _phoneController,
                    label: s.profilePhoneLabel,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? s.authRequiredFieldMessage
                        : null,
                    onFieldSubmitted: (_) => unawaited(_save()),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AuthSubmitButton(
                    label: s.profileSetupSaveAction,
                    isLoading: _isSaving,
                    onPressed: () => unawaited(_save()),
                  ),
                ],
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
      AppFeedback.showSnackBar(context, mapAuthErrorMessage(s, error.message));
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
