import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

part 'programs_notifier.freezed.dart';
part 'programs_notifier.g.dart';

@freezed
abstract class ProgramsState with _$ProgramsState {
  const ProgramsState._();

  const factory ProgramsState({
    @Default([]) List<WorkoutProgram> templates,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ProgramsState;
}

@riverpod
class ProgramsNotifier extends _$ProgramsNotifier {
  @override
  FutureOr<ProgramsState> build() async {
    return _fetchPrograms();
  }

  Future<ProgramsState> _fetchPrograms() async {
    final repo = ref.read(workoutRepositoryProvider);
    final templates = await repo.getAllTemplates();
    return ProgramsState(templates: templates);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPrograms());
  }

  Future<void> deleteTemplate(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.deleteTemplate(id);
    await refresh();
  }

  Future<void> exportTemplate(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    final jsonStr = await repo.exportTemplateToJson(id);
    final template = state.value?.templates.firstWhere((t) => t.id == id);

    await Share.share(
      jsonStr,
      subject: 'GymLog Pro Program: ${template?.name ?? "Workout"}',
    );
  }

  Future<void> exportSampleJson() async {
    final repo = ref.read(workoutRepositoryProvider);
    final jsonStr = repo.getSampleJson();

    await Share.share(
      jsonStr,
      subject: 'GymLog Pro Sample Program Format',
    );
  }

  Future<void> importTemplate() async {
    print('DEBUG: importTemplate called');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.path != null) {
      print('DEBUG: File picked: ${result.files.single.path}');
      final file = File(result.files.single.path!);
      final jsonStr = await file.readAsString();

      final repo = ref.read(workoutRepositoryProvider);
      await repo.importTemplateFromJson(jsonStr);
      await refresh();
    } else {
      print('DEBUG: No file picked or result was null');
    }
  }

  Future<void> importTemplateFromString(String jsonStr) async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.importTemplateFromJson(jsonStr);
    await refresh();
  }

  Future<void> importPplEliteProgram() async {
    try {
      state = const AsyncValue.loading();
      final jsonStr = await rootBundle.loadString('assets/data/ppl_elite_program.json');
      final repo = ref.read(workoutRepositoryProvider);
      await repo.importTemplateFromJson(jsonStr);
      await refresh();
    } catch (e, st) {
      print('DEBUG: Failed to import PPL Elite program: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> makeDefault(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.setActiveTemplate(id);
    // Invalidate workout home to show the new template
    ref.invalidate(workoutHomeProvider);
    await refresh();
  }

  Future<void> resetPrograms() async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.clearAllTemplatesAndInsertSample();
    await refresh();
  }
}
