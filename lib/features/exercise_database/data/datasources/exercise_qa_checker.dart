import 'package:flutter/foundation.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_qa_checker.g.dart';

class QaReport {
  final int totalExercises;
  final int passingCount;
  final Map<String, List<String>> failedChecks; // checkName -> list of exercise names/IDs

  QaReport({
    required this.totalExercises,
    required this.passingCount,
    required this.failedChecks,
  });

  bool get isClean => failedChecks.isEmpty;

  void printSummary() {
    debugPrint('=== Exercise QA Report ===');
    debugPrint('Total Exercises: $totalExercises');
    debugPrint('Passing: $passingCount');
    debugPrint('Failing: ${totalExercises - passingCount}');
    
    if (failedChecks.isNotEmpty) {
      debugPrint('\n--- Failed Checks ---');
      failedChecks.forEach((check, ids) {
        debugPrint('$check: ${ids.length} exercises');
        if (ids.length < 10) {
          debugPrint('  IDs: ${ids.join(", ")}');
        }
      });
    }
    debugPrint('==========================');
  }
}

@riverpod
class ExerciseQaChecker extends _$ExerciseQaChecker {
  @override
  void build() {}

  Future<QaReport> runChecks(List<ExerciseEntity> exercises) async {
    final failedChecks = <String, List<String>>{};
    int passingCount = 0;

    final idSet = <String>{};
    final nameSet = <String>{};
    final duplicateIds = <String>[];
    final duplicateNames = <String>[];

    for (final ex in exercises) {
      bool passedAll = true;
      final exName = ex.name;
      final exId = ex.id.toString();

      // 1. Image Check
      if (ex.imageUrls.isEmpty) {
        _logFailure(failedChecks, 'No Image URL', exName);
        passedAll = false;
      }

      // 2. Primary Muscle Check
      if (ex.primaryMuscles.isEmpty) {
        _logFailure(failedChecks, 'No Primary Muscles', exName);
        passedAll = false;
      }

      // 3. Instructions Check (at least 3 steps)
      if (ex.instructions.length < 3) {
        _logFailure(failedChecks, 'Insufficient Instructions (<3 steps)', exName);
        passedAll = false;
      }

      // 4. Body Part Check
      if (ex.targetBodyParts.isEmpty) {
        _logFailure(failedChecks, 'No Body Part Category', exName);
        passedAll = false;
      }

      // 5. Duplicate ID Check
      if (idSet.contains(exId)) {
        duplicateIds.add(exId);
        passedAll = false;
      } else {
        idSet.add(exId);
      }

      // 6. Duplicate Name Check (Case-insensitive)
      if (nameSet.contains(exName.toLowerCase())) {
        duplicateNames.add(exName);
        passedAll = false;
      } else {
        nameSet.add(exName.toLowerCase());
      }

      // 7. GIF URL Check
      if (ex.gifUrl != null && !ex.gifUrl!.startsWith('https://')) {
        _logFailure(failedChecks, 'Invalid GIF URL (Non-HTTPS)', exName);
        passedAll = false;
      }

      if (passedAll) {
        passingCount++;
      }
    }

    if (duplicateIds.isNotEmpty) failedChecks['Duplicate IDs'] = duplicateIds;
    if (duplicateNames.isNotEmpty) failedChecks['Duplicate Names'] = duplicateNames;

    final report = QaReport(
      totalExercises: exercises.length,
      passingCount: passingCount,
      failedChecks: failedChecks,
    );

    if (kDebugMode) {
      report.printSummary();
    }

    return report;
  }

  void _logFailure(Map<String, List<String>> failedChecks, String checkName, String exId) {
    failedChecks.putIfAbsent(checkName, () => []).add(exId);
  }

  List<String> validateExercise(ExerciseEntity exercise) {
    final issues = <String>[];

    if (exercise.instructions.length < 3) {
      issues.add('Instruction steps are insufficient (need at least 3).');
    }
    if (exercise.imageUrls.isEmpty && exercise.gifUrl == null) {
      issues.add('Missing visual media (Image/GIF).');
    }
    if (!exercise.isEnriched) {
      issues.add('Not AI enriched (Missing safety tips/mistakes).');
    }
    if (exercise.primaryMuscles.isEmpty) {
      issues.add('No primary muscles assigned.');
    }
    
    return issues;
  }
}
