import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/dao_providers.dart';
import '../../../core/domain/models/muscle_heat_data.dart';
import '../../../core/services/heatmap_color_service.dart';
import '../../../core/services/doms_service.dart';

part 'bodymap_provider.g.dart';

enum BodyMapMode { volume, doms }

// Raw volume map from DB
final muscleVolumeProvider = FutureProvider<Map<String, double>>((ref) async {
  final dao = ref.watch(bodyMapDaoProvider);
  return dao.getMuscleVolumeLastSevenDays();
});

// Last workout time per muscle (for DOMS)
final lastWorkoutTimeProvider =
    FutureProvider<Map<String, DateTime>>((ref) async {
  final dao = ref.watch(bodyMapDaoProvider);
  return dao.getLastWorkoutTimePerMuscle();
});

// Combined: produces a list of MuscleHeatData for the painter
final muscleHeatDataProvider = Provider<AsyncValue<List<MuscleHeatData>>>((ref) {
  final volumeAsync = ref.watch(muscleVolumeProvider);
  final lastTimeAsync = ref.watch(lastWorkoutTimeProvider);
  final colorService = HeatmapColorService();
  final domsService = DomsService();

  return volumeAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, s) => AsyncValue.error(e, s),
    data: (volumeMap) => lastTimeAsync.when(
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
      data: (lastTimeMap) {
        // We want to combine all unique muscles from both maps
        final muscles = {...volumeMap.keys, ...lastTimeMap.keys};

        final result = muscles.map((muscle) {
          final volume = volumeMap[muscle] ?? 0.0;
          final normalized = colorService.normalize(muscle, volume);
          final lastTrained = lastTimeMap[muscle];
          final doms = lastTrained != null
              ? domsService.calculateDomsScore(lastTrained)
              : 0.0;

          return MuscleHeatData(
            muscleName: muscle,
            volumeKg: volume,
            normalizedLoad: normalized,
            domsScore: doms,
          );
        }).toList();

        return AsyncValue.data(result);
      },
    ),
  );
});

// Toggle state: volume view vs DOMS view
@riverpod
class BodymapMode extends _$BodymapMode {
  @override
  BodyMapMode build() => BodyMapMode.volume;

  void setMode(BodyMapMode mode) => state = mode;
}
