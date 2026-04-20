// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesocycles_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MesocyclesNotifier)
final mesocyclesProvider = MesocyclesNotifierProvider._();

final class MesocyclesNotifierProvider
    extends $AsyncNotifierProvider<MesocyclesNotifier, MesocyclesState> {
  MesocyclesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesocyclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesocyclesNotifierHash();

  @$internal
  @override
  MesocyclesNotifier create() => MesocyclesNotifier();
}

String _$mesocyclesNotifierHash() =>
    r'4d3eb276d118ce4797a94da06090ba549011b3fa';

abstract class _$MesocyclesNotifier extends $AsyncNotifier<MesocyclesState> {
  FutureOr<MesocyclesState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MesocyclesState>, MesocyclesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MesocyclesState>, MesocyclesState>,
              AsyncValue<MesocyclesState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
