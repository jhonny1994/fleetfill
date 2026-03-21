import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportHomeScreen extends ConsumerStatefulWidget {
  const SupportHomeScreen({super.key});

  @override
  ConsumerState<SupportHomeScreen> createState() => _SupportHomeScreenState();
}

class _SupportHomeScreenState extends ConsumerState<SupportHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final supportEmail = configuredSupportEmailFromEnvironment();

    return AppPageScaffold(
      title: s.supportTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.supportTitle,
            subtitle: s.supportDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (supportEmail != null) ...[
            AuthInfoBanner(
              message: s.supportConfiguredEmailMessage(supportEmail),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          AuthInfoBanner(message: s.supportReferenceHintMessage),
          const SizedBox(height: AppSpacing.md),
          AuthCard(
            child: Form(
              key: _formKey,
              child: AppFocusTraversal.form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthTextField(
                      controller: _subjectController,
                      label: s.supportSubjectLabel,
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _messageController,
                      label: s.supportMessageLabel,
                      maxLines: 6,
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AuthSubmitButton(
                      label: s.supportSendAction,
                      isLoading: _isSubmitting,
                      onPressed: () => unawaited(_send(context)),
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

  Future<void> _send(BuildContext context) async {
    final s = S.of(context);
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(supportRepositoryProvider)
          .sendSupportMessage(
            locale: Localizations.localeOf(context).languageCode,
            subject: _subjectController.text,
            message: _messageController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(this.context, s.supportMessageSentMessage);
      _subjectController.clear();
      _messageController.clear();
    } on Exception catch (error) {
      if (mounted) {
        AppFeedback.showSnackBar(this.context, mapAppErrorMessage(s, error));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String? _requiredValidator(String? value) {
    return validateRequiredField(S.of(context), value);
  }
}

class LegalPoliciesScreen extends StatelessWidget {
  const LegalPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final supportEmail = configuredSupportEmailFromEnvironment();

    return AppPageScaffold(
      title: s.legalPoliciesTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.legalPoliciesTitle,
            subtitle: s.legalPoliciesDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (supportEmail != null) ...[
            AuthInfoBanner(
              message: s.supportConfiguredEmailMessage(supportEmail),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          AuthInfoBanner(message: s.legalPoliciesSupportHint),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalTermsTitle,
            body: s.legalTermsBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalPrivacyTitle,
            body: s.legalPrivacyBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalPaymentDisclosureTitle,
            body: s.legalPaymentDisclosureBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _PolicySectionCard(
            title: s.legalDisputePolicyTitle,
            body: s.legalDisputePolicyBody,
          ),
        ],
      ),
    );
  }
}

class _PolicySectionCard extends StatelessWidget {
  const _PolicySectionCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

String? configuredSupportEmailFromEnvironment() {
  const direct = String.fromEnvironment('SUPPORT_EMAIL');
  final value = direct.trim();
  return value.isEmpty ? null : value;
}
