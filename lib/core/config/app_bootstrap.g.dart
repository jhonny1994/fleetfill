// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bootstrap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppBootstrapController)
final appBootstrapControllerProvider = AppBootstrapControllerProvider._();

final class AppBootstrapControllerProvider
    extends $AsyncNotifierProvider<AppBootstrapController, AppBootstrapState> {
  AppBootstrapControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBootstrapControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBootstrapControllerHash();

  @$internal
  @override
  AppBootstrapController create() => AppBootstrapController();
}

String _$appBootstrapControllerHash() =>
    r'8de03a3d142fac848998a46552b7a22134f92095';

abstract class _$AppBootstrapController
    extends $AsyncNotifier<AppBootstrapState> {
  FutureOr<AppBootstrapState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AppBootstrapState>, AppBootstrapState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppBootstrapState>, AppBootstrapState>,
              AsyncValue<AppBootstrapState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
