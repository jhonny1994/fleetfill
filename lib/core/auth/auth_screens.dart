import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    ref.watch(appEnvironmentConfigProvider);

    return AuthScaffold(
      title: s.authSignInTitle,
      subtitle: s.authSignInDescription,
      heroIcon: Icons.waving_hand_rounded,
      footer: TextButton(
        onPressed: () => context.go(AppRoutePath.signUp),
        child: Text(s.authCreateAccountCta),
      ),
      child: AppFocusTraversal.form(
        child: AuthCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (auth?.isSessionExpired == true) ...[
                  AuthInfoBanner(
                    message: s.authSessionExpiredMessage,
                    icon: Icons.lock_clock_outlined,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (auth?.isSuspended == true) ...[
                  AuthInfoBanner(
                    message: s.suspendedMessage,
                    icon: Icons.block_rounded,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                AuthTextField(
                  controller: _emailController,
                  label: s.authEmailLabel,
                  hintText: s.authEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.mail_outline_rounded,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _passwordController,
                  label: s.authPasswordLabel,
                  hintText: s.authPasswordHint,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.key_rounded,
                  autofillHints: const [AutofillHints.password],
                  validator: _validatePassword,
                  onFieldSubmitted: (_) => unawaited(_submit()),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.go(AppRoutePath.forgotPassword),
                      child: Text(s.authForgotPasswordCta),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthSubmitButton(
                  label: s.authSignInAction,
                  isLoading: _isSubmitting,
                  onPressed: () => unawaited(_submit()),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: _isSubmitting
                      ? null
                      : () => unawaited(_signInWithGoogle()),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(s.authGoogleAction),
                ),
              ],
            ),
          ),
        ),
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
      await ref
          .read(authRepositoryProvider)
          .signInWithPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      await ref.read(authSessionControllerProvider.notifier).refresh();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.authSignInSuccess);
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

  Future<void> _signInWithGoogle() async {
    setState(() => _isSubmitting = true);
    final s = S.of(context);

    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.authGoogleStartedMessage);
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

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    ref.watch(appEnvironmentConfigProvider);

    return AuthScaffold(
      title: s.authSignUpTitle,
      subtitle: s.authSignUpDescription,
      heroIcon: Icons.person_add_alt_rounded,
      footer: TextButton(
        onPressed: () => context.go(AppRoutePath.signIn),
        child: Text(s.authHaveAccountCta),
      ),
      child: AppFocusTraversal.form(
        child: AuthCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthTextField(
                  controller: _emailController,
                  label: s.authEmailLabel,
                  hintText: s.authEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.mail_outline_rounded,
                  autofillHints: const [
                    AutofillHints.newUsername,
                    AutofillHints.email,
                  ],
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _passwordController,
                  label: s.authPasswordLabel,
                  hintText: s.authCreatePasswordHint,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.key_rounded,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: _validatePassword,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _confirmPasswordController,
                  label: s.authConfirmPasswordLabel,
                  hintText: s.authConfirmPasswordHint,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.key_rounded,
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return s.authRequiredFieldMessage;
                    }
                    if (value != _passwordController.text) {
                      return s.authPasswordMismatchMessage;
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => unawaited(_submit()),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthSubmitButton(
                  label: s.authCreateAccountAction,
                  isLoading: _isSubmitting,
                  onPressed: () => unawaited(_submit()),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthDivider(label: s.authContinueWithLabel),
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton.icon(
                  onPressed: _isSubmitting
                      ? null
                      : () => unawaited(_signInWithGoogle()),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(s.authGoogleAction),
                ),
              ],
            ),
          ),
        ),
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
      final needsConfirmation = await ref
          .read(authRepositoryProvider)
          .signUpWithPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(
        context,
        needsConfirmation
            ? s.authVerificationEmailSentMessage
            : s.authAccountCreatedMessage,
      );
      context.go(AppRoutePath.signIn);
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

  Future<void> _signInWithGoogle() async {
    setState(() => _isSubmitting = true);
    final s = S.of(context);

    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.authGoogleStartedMessage);
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

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AuthScaffold(
      title: s.authForgotPasswordTitle,
      subtitle: s.authForgotPasswordDescription,
      heroIcon: Icons.mark_email_unread_rounded,
      child: AppFocusTraversal.form(
        child: AuthCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInfoBanner(message: s.authPasswordResetInfoMessage),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _emailController,
                  label: s.authEmailLabel,
                  hintText: s.authEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.mail_outline_rounded,
                  validator: _validateEmail,
                  onFieldSubmitted: (_) => unawaited(_submit()),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthSubmitButton(
                  label: s.authSendResetAction,
                  isLoading: _isSubmitting,
                  onPressed: () => unawaited(_submit()),
                ),
              ],
            ),
          ),
        ),
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
      await ref
          .read(authRepositoryProvider)
          .sendPasswordResetEmail(_emailController.text.trim());
      if (!mounted) {
        return;
      }
      AppFeedback.showSnackBar(context, s.authResetEmailSentMessage);
      context.go(AppRoutePath.signIn);
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

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final authState = ref.watch(authSessionControllerProvider).asData?.value;
    final canReset = authState?.isPasswordRecovery ?? false;

    return AuthScaffold(
      title: s.authResetPasswordTitle,
      subtitle: s.authResetPasswordDescription,
      heroIcon: Icons.key_rounded,
      child: AppFocusTraversal.form(
        child: AuthCard(
          child: canReset
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        controller: _passwordController,
                        label: s.authNewPasswordLabel,
                        hintText: s.authCreatePasswordHint,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icons.lock_outline_rounded,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AuthTextField(
                        controller: _confirmPasswordController,
                        label: s.authConfirmPasswordLabel,
                        hintText: s.authConfirmPasswordHint,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.lock_outline_rounded,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return s.authRequiredFieldMessage;
                          }
                          if (value != _passwordController.text) {
                            return s.authPasswordMismatchMessage;
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => unawaited(_submit()),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthSubmitButton(
                        label: s.authUpdatePasswordAction,
                        isLoading: _isSubmitting,
                        onPressed: () => unawaited(_submit()),
                      ),
                    ],
                  ),
                )
              : AuthInfoBanner(
                  message: s.authResetPasswordUnavailableMessage,
                  icon: Icons.lock_reset_rounded,
                ),
        ),
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
      await ref
          .read(authRepositoryProvider)
          .updatePassword(_passwordController.text);
      final controller = ref.read(authSessionControllerProvider.notifier)
        ..clearPasswordRecovery();
      await controller.refresh();
      if (!mounted) {
        return;
      }
      final auth = ref.read(authSessionControllerProvider).asData?.value;
      AppFeedback.showSnackBar(context, s.authPasswordUpdatedMessage);
      context.go(
        auth == null
            ? AppRoutePath.signIn
            : AppRouteGuards.authenticatedEntryLocation(auth),
      );
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

String? _validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) {
    return S.current.authRequiredFieldMessage;
  }

  final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!emailPattern.hasMatch(email)) {
    return S.current.authInvalidEmailMessage;
  }

  return null;
}

String? _validatePassword(String? value) {
  final password = value ?? '';
  if (password.isEmpty) {
    return S.current.authRequiredFieldMessage;
  }
  if (password.length < 8) {
    return S.current.authPasswordMinLengthMessage;
  }
  return null;
}
