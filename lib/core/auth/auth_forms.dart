import 'dart:math' as math;

import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef AuthSubmitCallback = Future<void> Function();

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
    this.footer,
    this.heroIcon = Icons.verified_user_rounded,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;
  final IconData heroIcon;

  @override
  Widget build(BuildContext context) {
    final layout = AppBreakpoints.resolve(context);
    final canPop = GoRouter.of(context).canPop();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F1EB),
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    math.max(
                          AppSpacing.lg,
                          MediaQuery.paddingOf(context).bottom,
                        ) +
                        bottomInset,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1080),
                        child: layout == AppLayoutSize.compact
                            ? ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 460,
                                ),
                                child: _AuthPanel(
                                  title: title,
                                  subtitle: subtitle,
                                  heroIcon: heroIcon,
                                  canPop: canPop,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      child,
                                      if (footer != null) ...[
                                        const SizedBox(height: AppSpacing.xl),
                                        DefaultTextStyle.merge(
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ) ??
                                              TextStyle(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                          textAlign: TextAlign.center,
                                          child: footer!,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 11,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 460,
                                      ),
                                      child: _AuthPanel(
                                        title: title,
                                        subtitle: subtitle,
                                        heroIcon: heroIcon,
                                        canPop: canPop,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            child,
                                            if (footer != null) ...[
                                              const SizedBox(
                                                height: AppSpacing.xl,
                                              ),
                                              DefaultTextStyle.merge(
                                                style:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: colorScheme
                                                              .onSurfaceVariant,
                                                        ) ??
                                                    TextStyle(
                                                      color: colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                                textAlign: TextAlign.center,
                                                child: footer!,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.xl),
                                  const Expanded(
                                    flex: 10,
                                    child: _AuthPreviewDeck(),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatelessWidget {
  const AuthCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final animationDuration = MotionPolicy.duration(context, AppMotion.medium);

    return AnimatedContainer(
      duration: animationDuration,
      curve: AppMotion.emphasized,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 30,
            offset: Offset(0, 18),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: child,
    );
  }
}

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final animationDuration = MotionPolicy.duration(context, AppMotion.fast);

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: AnimatedSwitcher(
          duration: animationDuration,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(label),
        ),
      ),
    );
  }
}

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.prefixIcon,
    this.hintText,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final IconData? prefixIcon;
  final String? hintText;
  final bool enabled;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final s = S.of(context);

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      enabled: widget.enabled,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFFDFDFC),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, color: colorScheme.primary),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                tooltip: _obscureText
                    ? s.authShowPasswordAction
                    : s.authHidePasswordAction,
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.7),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}

class AuthInfoBanner extends StatelessWidget {
  const AuthInfoBanner({
    required this.message,
    super.key,
    this.icon = Icons.info_outline_rounded,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: Divider(color: colorScheme.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: colorScheme.outlineVariant)),
      ],
    );
  }
}

class _AuthPanel extends StatelessWidget {
  const _AuthPanel({
    required this.title,
    required this.subtitle,
    required this.heroIcon,
    required this.canPop,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData heroIcon;
  final bool canPop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(36),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 40,
            offset: Offset(0, 24),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: canPop
                  ? IconButton.filledTonal(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  : const SizedBox(height: 48),
            ),
            const SizedBox(height: AppSpacing.sm),
            _AuthHeroBadge(icon: heroIcon),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.05,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            child,
          ],
        ),
      ),
    );
  }
}

class _AuthHeroBadge extends StatelessWidget {
  const _AuthHeroBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE2F3EE), Color(0xFFF7F4D8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Icon(icon, size: 28, color: const Color(0xFF0B6E69)),
        ),
      ),
    );
  }
}

class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -80,
          left: -40,
          child: _GlowOrb(size: 220, color: Color(0x33CFE9E2)),
        ),
        Positioned(
          top: 120,
          right: -50,
          child: _GlowOrb(size: 180, color: Color(0x33F1E6AE)),
        ),
        Positioned(
          bottom: -80,
          left: 40,
          child: _GlowOrb(size: 260, color: Color(0x22BFE1DA)),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.02)],
          ),
        ),
      ),
    );
  }
}

class _AuthPreviewDeck extends StatelessWidget {
  const _AuthPreviewDeck();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 620,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 52,
              child: _PreviewPhone(angle: -0.14, variant: _PreviewVariant.code),
            ),
            Positioned(
              left: 26,
              top: 58,
              child: _PreviewPhone(angle: 0.09, variant: _PreviewVariant.form),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PreviewVariant { form, code }

class _PreviewPhone extends StatelessWidget {
  const _PreviewPhone({required this.angle, required this.variant});

  final double angle;
  final _PreviewVariant variant;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(42),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 36,
              offset: Offset(0, 24),
            ),
          ],
        ),
        child: SizedBox(
          width: 330,
          height: 560,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30, height: 10),
                    Icon(Icons.signal_cellular_alt_rounded, size: 18),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                if (variant == _PreviewVariant.form) ...const [
                  _PreviewHeader(icon: Icons.lock_person_rounded),
                  SizedBox(height: AppSpacing.xl),
                  _PreviewInput(),
                  SizedBox(height: AppSpacing.md),
                  _PreviewInput(isPassword: true),
                  SizedBox(height: AppSpacing.lg),
                  _PreviewButton(),
                  SizedBox(height: AppSpacing.lg),
                  _PreviewProviderRow(),
                ] else ...const [
                  _PreviewHeader(icon: Icons.key_rounded),
                  SizedBox(height: AppSpacing.xl),
                  _PreviewCodeStrip(),
                  SizedBox(height: AppSpacing.xl),
                  _PreviewKeypad(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF4E89A), Color(0xFFD7F1E8)],
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Icon(icon, color: const Color(0xFF0B6E69), size: 26),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(width: 180, height: 18, color: const Color(0x14000000)),
        const SizedBox(height: AppSpacing.sm),
        Container(width: 210, height: 12, color: const Color(0x0F000000)),
        const SizedBox(height: AppSpacing.xs),
        Container(width: 150, height: 12, color: const Color(0x0F000000)),
      ],
    );
  }
}

class _PreviewInput extends StatelessWidget {
  const _PreviewInput({this.isPassword = false});

  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 86, height: 11, color: const Color(0x12000000)),
        const SizedBox(height: AppSpacing.sm),
        Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0x18000000)),
          ),
          child: Row(
            children: [
              const SizedBox(width: AppSpacing.md),
              Icon(
                isPassword ? Icons.key_rounded : Icons.mail_outline_rounded,
                color: const Color(0xFF0B6E69),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Container(height: 12, color: const Color(0x10000000)),
              ),
              const SizedBox(width: AppSpacing.md),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewButton extends StatelessWidget {
  const _PreviewButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF0B6E69),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _PreviewProviderRow extends StatelessWidget {
  const _PreviewProviderRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _PreviewProviderPill()),
        SizedBox(width: AppSpacing.md),
        Expanded(child: _PreviewProviderPill(isDark: true)),
      ],
    );
  }
}

class _PreviewProviderPill extends StatelessWidget {
  const _PreviewProviderPill({this.isDark = false});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x14000000)),
      ),
    );
  }
}

class _PreviewCodeStrip extends StatelessWidget {
  const _PreviewCodeStrip();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _PreviewCodeBox()),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _PreviewCodeBox()),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _PreviewCodeBox()),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _PreviewCodeBox()),
      ],
    );
  }
}

class _PreviewCodeBox extends StatelessWidget {
  const _PreviewCodeBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFE4F0EC),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _PreviewKeypad extends StatelessWidget {
  const _PreviewKeypad();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: index == 11 ? const Color(0xFFF5F3EE) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
