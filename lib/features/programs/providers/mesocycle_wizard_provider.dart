import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart';
import 'package:ai_gym_mentor/features/programs/repositories/mesocycle_repository.dart';
import 'package:ai_gym_mentor/features/programs/services/mesocycle_generator_service.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/programs/providers/mesocycles_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mesocycle_wizard_provider.freezed.dart';
part 'mesocycle_wizard_provider.g.dart';

@freezed
abstract class MesocycleWizardState with _$MesocycleWizardState {
  const factory MesocycleWizardState({
    @Default(0) int currentStep,
    @Default('') String name,
    @Default(MesocycleGoal.hypertrophy) MesocycleGoal goal,
    @Default('Intermediate') String experienceLevel,
    @Default('PPL (Push/Pull/Legs)') String splitType,
    @Default(4) int weeksCount,
    @Default(3) int daysPerWeek,
    @Default([]) List<List<ExerciseEntity>> exercisesPerDay,
    @Default(false) bool isGenerating,
    MesocycleEntity? previewedMesocycle,
  }) = _MesocycleWizardState;
}

@riverpod
class MesocycleWizardNotifier extends _$MesocycleWizardNotifier {
  final _generator = MesocycleGeneratorService();

  @override
  MesocycleWizardState build() {
    return const MesocycleWizardState();
  }

  void updateBasics({required String name, required MesocycleGoal goal, required String experienceLevel}) {
    state = state.copyWith(name: name, goal: goal, experienceLevel: experienceLevel);
  }

  void updateStructure({required String splitType, required int weeksCount, required int daysPerWeek}) {
    // If daysPerWeek changed, re-initialize exercisesPerDay
    final existing = List<List<ExerciseEntity>>.from(state.exercisesPerDay);
    if (existing.length != daysPerWeek) {
      if (existing.length < daysPerWeek) {
        existing.addAll(List.generate(daysPerWeek - existing.length, (_) => []));
      } else {
        existing.removeRange(daysPerWeek, existing.length);
      }
    }
    state = state.copyWith(splitType: splitType, weeksCount: weeksCount, daysPerWeek: daysPerWeek, exercisesPerDay: existing);
  }

  void updateExercisesForDay(int dayIndex, List<ExerciseEntity> exercises) {
    final updated = List<List<ExerciseEntity>>.from(state.exercisesPerDay);
    updated[dayIndex] = exercises;
    state = state.copyWith(exercisesPerDay: updated);
  }

  void nextStep() {
    if (state.currentStep == 2) {
      // Transitioning to Review, generate the structure
      generatePreview();
    }
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void prevStep() {
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  void generatePreview() {
    final mesocycle = _generator.generateStructure(
      name: state.name,
      goal: state.goal,
      splitType: state.splitType,
      experienceLevel: state.experienceLevel,
      weeksCount: state.weeksCount,
      daysPerWeek: state.daysPerWeek,
      exercisesPerDay: state.exercisesPerDay,
    );
    state = state.copyWith(previewedMesocycle: mesocycle);
  }

  Future<void> completeWizard() async {
    if (state.previewedMesocycle == null) return;
    
    final repo = ref.read(mesocycleRepositoryProvider);
    await repo.createMesocycle(state.previewedMesocycle!);
    
    // Refresh the list
    ref.read(mesocyclesProvider.notifier).refresh();
  }
}
