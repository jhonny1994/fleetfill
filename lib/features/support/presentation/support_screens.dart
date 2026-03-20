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

    return AppPageScaffold(
      title: s.supportTitle,
      child: ListView(
        children: [
          AppSectionHeader(
            title: s.supportTitle,
            subtitle: s.supportDescription,
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthCard(
            child: AppFocusTraversal.form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTextField(
                    controller: _subjectController,
                    label: s.supportSubjectLabel,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthTextField(
                    controller: _messageController,
                    label: s.supportMessageLabel,
                    maxLines: 6,
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
        ],
      ),
    );
  }

  Future<void> _send(BuildContext context) async {
    final s = S.of(context);
    if (_subjectController.text.trim().isEmpty || _messageController.text.trim().isEmpty) {
      AppFeedback.showSnackBar(context, s.authRequiredFieldMessage);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await ref.read(supportRepositoryProvider).sendSupportMessage(
            locale: Localizations.localeOf(context).languageCode,
            subject: _subjectController.text,
            message: _messageController.text,
          );
      if (!mounted) return;
      AppFeedback.showSnackBar(this.context, s.supportMessageSentMessage);
      _subjectController.clear();
      _messageController.clear();
    } on Exception catch (error) {
      if (mounted) AppFeedback.showSnackBar(this.context, mapAppErrorMessage(s, error));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
