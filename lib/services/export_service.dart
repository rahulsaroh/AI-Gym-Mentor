import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/exercises/repositories/exercise_repository.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

final exportServiceProvider = Provider((ref) => ExportService(ref));

class ExportService {
  final Ref ref;
  ExportService(this.ref);

  Future<void> exportToCsv() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await db.select(db.workouts).get();
    final allSets = await db.select(db.workoutSets).get();
    final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();

    List<List<dynamic>> rows = [
      ['Date', 'Workout Name', 'Exercise', 'Set Type', 'Weight', 'Reps', 'RPE', 'RIR', 'Notes']
    ];

    for (var w in workouts) {
      final workoutSets = allSets.where((s) => s.workoutId == w.id).toList();
      for (var s in workoutSets) {
        final ex = exercises.firstWhere((e) => e.id == s.exerciseId);
        rows.add([
          DateFormat('yyyy-MM-dd HH:mm').format(w.startTime),
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
    final file = File('${directory.path}/gym_log_export_${DateTime.now().millisecondsSinceEpoch}.csv');
    await file.writeAsString(csv);

    await Share.shareXFiles([XFile(file.path)], text: 'My Gym Log Export (CSV)');
  }

  Future<void> exportToPdf() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await (db.select(db.workouts)
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .get();
    final allSets = await db.select(db.workoutSets).get();
    final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(level: 0, child: pw.Text('GymLog Pro - Training Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 20),
            ...workouts.map((w) {
              final workoutSets = allSets.where((s) => s.workoutId == w.id).toList();
              final workoutExercises = workoutSets.map((s) => s.exerciseId).toSet().toList();
              
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('${w.name} - ${DateFormat('MMM d, yyyy').format(w.startTime)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('${w.duration} mins', style: const pw.TextStyle(color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  ...workoutExercises.map((exId) {
                    final ex = exercises.firstWhere((e) => e.id == exId);
                    final exSets = workoutSets.where((s) => s.exerciseId == exId).toList();
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 12, bottom: 8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(ex.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                          pw.Text(
                            exSets.map((s) => '${s.weight}kg x ${s.reps.toInt()}').join(' | '),
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
    final file = File('${directory.path}/gym_report_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: 'My Gym Training Report (PDF)');
  }
}
