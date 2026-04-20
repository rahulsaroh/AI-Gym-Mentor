import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart';
import 'package:ai_gym_mentor/features/programs/repositories/mesocycle_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mesocycles_notifier.freezed.dart';
part 'mesocycles_notifier.g.dart';

@freezed
abstract class MesocyclesState with _$MesocyclesState {
  const factory MesocyclesState({
    @Default([]) List<MesocycleEntity> mesocycles,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _MesocyclesState;
}

@riverpod
class MesocyclesNotifier extends _$MesocyclesNotifier {
  @override
  FutureOr<MesocyclesState> build() async {
    return _fetchMesocycles();
  }

  Future<MesocyclesState> _fetchMesocycles() async {
    final repo = ref.read(mesocycleRepositoryProvider);
    final mesocycles = await repo.getAllMesocycles(includeArchived: true);
    return MesocyclesState(mesocycles: mesocycles);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchMesocycles());
  }

  Future<void> deleteMesocycle(int id) async {
    final repo = ref.read(mesocycleRepositoryProvider);
    await repo.deleteMesocycle(id);
    await refresh();
  }

  Future<void> archiveMesocycle(int id, bool archive) async {
    final repo = ref.read(mesocycleRepositoryProvider);
    await repo.archiveMesocycle(id, archive);
    await refresh();
  }
}
