import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/workout/workout_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

part 'programs_notifier.freezed.dart';
part 'programs_notifier.g.dart';

@freezed
class ProgramsState with _$ProgramsState {
  const factory ProgramsState({
    @Default([]) List<WorkoutTemplate> templates,
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

  Future<void> importTemplate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final jsonStr = await file.readAsString();
      
      final repo = ref.read(workoutRepositoryProvider);
      await repo.importTemplateFromJson(jsonStr);
      await refresh();
    }
  }
}
