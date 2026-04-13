import 'dart:convert';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';

class ExerciseEnrichmentService {
  final AppDatabase _db;
  final ExerciseRepository _repository;

  ExerciseEnrichmentService(this._db, this._repository);

  List<String> getExercisesNeedingEnrichment(List<dynamic> all) {
    final needsEnrichment = <String>[];
    for (final ex in all) {
      if (ex.instructions == null || ex.instructions.length < 3) {
        needsEnrichment.add(ex.id);
      } else if (ex.safetyTips == null || ex.safetyTips.isEmpty) {
        needsEnrichment.add(ex.id);
      } else if (ex.commonMistakes == null || ex.commonMistakes.isEmpty) {
        needsEnrichment.add(ex.id);
      } else if (ex.description == null || ex.description.length < 50) {
        needsEnrichment.add(ex.id);
      }
    }
    return needsEnrichment;
  }

  Future<void> saveEnrichedContent(int exerciseId, {
    List<String>? safetyTips,
    List<String>? commonMistakes,
    List<String>? variations,
    String? enrichedOverview,
    String enrichmentSource = 'llm',
  }) async {
    await _repository.saveEnrichedContent(
      exerciseId,
      safetyTips: safetyTips,
      commonMistakes: commonMistakes,
      variations: variations,
      enrichedOverview: enrichedOverview,
      enrichmentSource: enrichmentSource,
    );
  }
}

class QaReport {
  final int total;
  final int passing;
  final int failing;
  final Map<String, List<String>> failingIds;

  QaReport({
    required this.total,
    required this.passing,
    required this.failing,
    required this.failingIds,
  });
}

class ExerciseQaChecker {
  final AppDatabase _db;

  ExerciseQaChecker(this._db);

  Future<QaReport> runChecks() async {
    final exercises = await _db.select(_db.exercises).get();
    final failingIds = <String, List<String>>{
      'no_image': [],
      'no_primary_muscle': [],
      'few_instructions': [],
      'duplicate_ids': [],
      'duplicate_names': [],
      'no_body_part': [],
    };

    final ids = exercises.map((e) => e.id).toSet();
    final names = exercises.map((e) => e.name.toLowerCase()).toSet();
    final duplicateIds = <int>{};
    final duplicateNames = <String>{};

    for (var i = 0; i < exercises.length; i++) {
      for (var j = i + 1; j < exercises.length; j++) {
        if (exercises[i].id == exercises[j].id) {
          duplicateIds.add(exercises[i].id);
        }
        if (exercises[i].name.toLowerCase() == exercises[j].name.toLowerCase()) {
          duplicateNames.add(exercises[i].name);
        }
      }
    }

    for (final ex in exercises) {
      if (ex.imageUrl == null || ex.imageUrl!.isEmpty) {
        failingIds['no_image']!.add(ex.id.toString());
      }
      if (ex.primaryMuscles.isEmpty) {
        failingIds['no_primary_muscle']!.add(ex.id.toString());
      }
      if (ex.instructions == null || ex.instructions!.split('|').length < 3) {
        failingIds['few_instructions']!.add(ex.id.toString());
      }
    }

    final bodyParts = await _db.select(_db.exerciseBodyParts).get();
    final exerciseBodyPartMap = <int, Set<String>>{};
    for (final bp in bodyParts) {
      exerciseBodyPartMap.putIfAbsent(bp.exerciseId, () => {}).add(bp.bodyPart);
    }

    for (final ex in exercises) {
      final bps = exerciseBodyPartMap[ex.id] ?? {};
      if (bps.isEmpty) {
        failingIds['no_body_part']!.add(ex.id.toString());
      }
    }

    if (duplicateIds.isNotEmpty) {
      failingIds['duplicate_ids']!.addAll(duplicateIds.map((i) => i.toString()));
    }
    if (duplicateNames.isNotEmpty) {
      failingIds['duplicate_names']!.addAll(duplicateNames);
    }

    final total = exercises.length;
    final failing = failingIds.values.where((l) => l.isNotEmpty).length;
    final passing = total - failing;

    return QaReport(
      total: total,
      passing: passing,
      failing: failing,
      failingIds: failingIds,
    );
  }

  Future<void> printReport() async {
    final report = await runChecks();
    print('=== Exercise QA Report ===');
    print('Total exercises: ${report.total}');
    print('Passing: ${report.passing}');
    print('Failing: ${report.failing}');
    print('');
    print('Issues found:');
    for (final entry in report.failingIds.entries) {
      if (entry.value.isNotEmpty) {
        print('  ${entry.key}: ${entry.value.length} exercises');
      }
    }
  }
}
