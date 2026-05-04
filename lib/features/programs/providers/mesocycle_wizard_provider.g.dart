// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesocycle_wizard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MesocycleWizardNotifier)
final mesocycleWizardProvider = MesocycleWizardNotifierProvider._();

final class MesocycleWizardNotifierProvider
    extends $NotifierProvider<MesocycleWizardNotifier, MesocycleWizardState> {
  MesocycleWizardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesocycleWizardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesocycleWizardNotifierHash();

  @$internal
  @override
  MesocycleWizardNotifier create() => MesocycleWizardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MesocycleWizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MesocycleWizardState>(value),
    );
  }
}

String _$mesocycleWizardNotifierHash() =>
    r'fa06a2d3652d87524214d038ebd5d68ac1c92727';

abstract class _$MesocycleWizardNotifier
    extends $Notifier<MesocycleWizardState> {
  MesocycleWizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MesocycleWizardState, MesocycleWizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MesocycleWizardState, MesocycleWizardState>,
              MesocycleWizardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
