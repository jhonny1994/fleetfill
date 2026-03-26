import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppAsyncStateView<T> extends StatelessWidget {
  const AppAsyncStateView({
    required this.value,
    required this.data,
    super.key,
    this.onRetry,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const AppLoadingState(),
      error: (error, stackTrace) => AppErrorState(
        error: AppError(
          code: 'async_error',
          message: mapAppErrorMessage(S.of(context), error),
          technicalDetails: stackTrace.toString(),
        ),
        onRetry: onRetry,
      ),
    );
  }
}

class AppSliverAsyncStateView<T> extends StatelessWidget {
  const AppSliverAsyncStateView({
    required this.value,
    required this.data,
    super.key,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppAsyncStateView<T>(value: value, data: data, onRetry: onRetry),
    );
  }
}

class AppStateMessage extends StatelessWidget {
  const AppStateMessage({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        container: true,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 42),
                const SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(message, textAlign: TextAlign.center),
                if (action != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  action!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.hourglass_top_rounded,
      title: S.of(context).loadingTitle,
      message: S.of(context).loadingMessage,
      action: const Padding(
        padding: EdgeInsets.only(top: AppSpacing.sm),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    required this.message,
    super.key,
    this.action,
  });

  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.inbox_outlined,
      title: title,
      message: message,
      action: action,
    );
  }
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({required this.error, super.key, this.onRetry});

  final AppError error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: error.icon,
      title: S.of(context).errorTitle,
      message: error.message,
      action: onRetry == null
          ? null
          : FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(S.of(context).retryLabel),
            ),
    );
  }
}

class AppRetryCard extends StatelessWidget {
  const AppRetryCard({
    required this.title,
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(message),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(S.of(context).retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class AppOfflineBanner extends StatelessWidget {
  const AppOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            const Icon(Icons.wifi_off_rounded),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(S.of(context).offlineMessage)),
          ],
        ),
      ),
    );
  }
}

class AppNoExactResultsState extends StatelessWidget {
  const AppNoExactResultsState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: S.of(context).noExactResultsTitle,
      message: S.of(context).noExactResultsMessage,
    );
  }
}

class AppPermissionHelpCard extends StatelessWidget {
  const AppPermissionHelpCard({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(message),
          ],
        ),
      ),
    );
  }
}

class AppNotFoundState extends StatelessWidget {
  const AppNotFoundState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.search_off_rounded,
      title: S.of(context).notFoundTitle,
      message: S.of(context).notFoundMessage,
    );
  }
}

class AppForbiddenState extends StatelessWidget {
  const AppForbiddenState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.lock_outline_rounded,
      title: S.of(context).forbiddenTitle,
      message: message ?? S.of(context).forbiddenMessage,
    );
  }
}

class AppSuspendedAccountState extends StatelessWidget {
  const AppSuspendedAccountState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.block_rounded,
      title: S.of(context).suspendedTitle,
      message: S.of(context).suspendedMessage,
    );
  }
}

class AppVerificationGateState extends StatelessWidget {
  const AppVerificationGateState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateMessage(
      icon: Icons.verified_user_outlined,
      title: S.of(context).verificationRequiredTitle,
      message: S.of(context).verificationRequiredMessage,
    );
  }
}
