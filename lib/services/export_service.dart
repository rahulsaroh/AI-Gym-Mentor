import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

final exportServiceProvider = Provider((ref) => ExportService(ref));

class ExportService {
  final Ref ref;
  ExportService(this.ref);

  Future<void> exportToCsv() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await db.select(db.workouts).get();
    final allSets = await db.select(db.workoutSets).get();
    final exercises =
        await ref.read(exerciseRepositoryProvider).getAllExercises();

    List<List<dynamic>> rows = [
      [
        'Date',
        'Workout Name',
        'Exercise',
        'Set Type',
        'Weight',
        'Reps',
        'RPE',
        'RIR',
        'Notes'
      ]
    ];

    for (var w in workouts) {
      final workoutSets = allSets.where((s) => s.workoutId == w.id).toList();
      for (var s in workoutSets) {
        final ex = exercises.firstWhere((e) => e.id == s.exerciseId);
        rows.add([
          DateFormat('yyyy-MM-dd HH:mm').format(w.startTime!),
          w.name,
          ex.name,
          s.setType.name,
          s.weight,
          s.reps,
          s.rpe ?? '',
          s.rir ?? '',
          s.notes ?? '',
        ]);
      }
    }

    String csv = const ListToCsvConverter().convert(rows);
    final directory = await getTemporaryDirectory();
    final file = File(
        '${directory.path}/gym_log_export_${DateTime.now().millisecondsSinceEpoch}.csv');
    await file.writeAsString(csv);

    await Share.shareXFiles([XFile(file.path)],
        text: 'My Gym Log Export (CSV)');
  }

  Future<void> exportToPdf() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await (db.select(db.workouts)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)
          ]))
        .get();
    final allSets = await db.select(db.workoutSets).get();
    final exercises =
        await ref.read(exerciseRepositoryProvider).getAllExercises();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
                level: 0,
                child: pw.Text('GymLog Pro - Training Report',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 20),
            ...workouts.map((w) {
              final workoutSets =
                  allSets.where((s) => s.workoutId == w.id).toList();
              final workoutExercises =
                  workoutSets.map((s) => s.exerciseId).toSet().toList();

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                            '${w.name} - ${DateFormat('MMM d, yyyy').format(w.startTime!)}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('${w.duration} mins',
                            style:
                                const pw.TextStyle(color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  ...workoutExercises.map((exId) {
                    final ex = exercises.firstWhere((e) => e.id == exId);
                    final exSets =
                        workoutSets.where((s) => s.exerciseId == exId).toList();
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 12, bottom: 8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(ex.name,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                          pw.Text(
                            exSets
                                .map((s) => '${s.weight}kg x ${s.reps.toInt()}')
                                .join(' | '),
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
                  pw.Divider(),
                  pw.SizedBox(height: 12),
                ],
              );
            }),
          ];
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File(
        '${directory.path}/gym_report_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)],
        text: 'My Gym Training Report (PDF)');
  }

  Future<void> exportToJson() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await db.select(db.workouts).get();
    final sets = await db.select(db.workoutSets).get();

    final data = {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'workouts': workouts.map((w) => w.toJson()).toList(),
      'sets': sets.map((s) => s.toJson()).toList(),
    };

    final jsonString = jsonEncode(data);
    final directory = await getTemporaryDirectory();
    final file = File(
        '${directory.path}/gym_backup_${DateTime.now().millisecondsSinceEpoch}.json');
    await file.writeAsString(jsonString);

    await Share.shareXFiles([XFile(file.path)], text: 'Gym Backup (JSON)');
  }

  Future<bool> importFromJson() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) return false;

      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      if (data['version'] != 1) {
        throw Exception('Unsupported backup version');
      }

      final db = ref.read(appDatabaseProvider);

      // Perform import in a transaction
      await db.transaction(() async {
        // Clear existing data (DANGEROUS but typical for full restore)
        // Optionally, we could merge by ID
        await db.delete(db.workouts).go();
        await db.delete(db.workoutSets).go();

        final workoutsData = data['workouts'] as List<dynamic>;
        final setsData = data['sets'] as List<dynamic>;

        for (var wJson in workoutsData) {
          final workout = Workout.fromJson(wJson);
          await db.into(db.workouts).insert(workout.toCompanion(false));
        }

        for (var sJson in setsData) {
          final workoutSet = WorkoutSet.fromJson(sJson);
          await db
              .into(db.workoutSets)
              .insert(workoutSet.toCompanion(false));
        }
      });

      return true;
    } catch (e) {
      print('Import error: $e');
      return false;
    }
  }
}
