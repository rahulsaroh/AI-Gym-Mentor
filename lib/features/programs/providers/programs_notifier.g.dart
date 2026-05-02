// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programs_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProgramsNotifier)
final programsProvider = ProgramsNotifierProvider._();

final class ProgramsNotifierProvider
    extends $AsyncNotifierProvider<ProgramsNotifier, ProgramsState> {
  ProgramsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programsNotifierHash();

  @$internal
  @override
  ProgramsNotifier create() => ProgramsNotifier();
}

String _$programsNotifierHash() => r'30d55d258dd0732f695318a9679789db251a61f9';

abstract class _$ProgramsNotifier extends $AsyncNotifier<ProgramsState> {
  FutureOr<ProgramsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProgramsState>, ProgramsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProgramsState>, ProgramsState>,
              AsyncValue<ProgramsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
