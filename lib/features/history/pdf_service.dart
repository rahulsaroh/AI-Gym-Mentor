import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_service.g.dart';

@riverpod
class PdfService extends _$PdfService {
  @override
  void build() {}

  Future<File> generateWorkoutPdf({
    required Workout workout,
    required List<WorkoutSet> sets,
    required Map<int, String> exerciseNames,
  }) async {
    final pdf = pw.Document();

    final dateStr = DateFormat('EEEE, MMM d, yyyy').format(workout.date);
    final totalVolume = sets.fold(0.0, (sum, s) => sum + (s.weight * s.reps));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _buildHeader(workout.name, dateStr),
          pw.SizedBox(height: 10),
          _buildSummary(sets.length, totalVolume),
          pw.SizedBox(height: 20),
          _buildExerciseList(sets, exerciseNames),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/workout_${workout.id}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  pw.Widget _buildHeader(String title, String date) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
        pw.Text(date, style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
        pw.Divider(thickness: 1, color: PdfColors.blue100),
      ],
    );
  }

  pw.Widget _buildSummary(int setCount, double volume) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("TOTAL VOLUME", style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
            pw.Text("${volume.toStringAsFixed(0)} kg", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("TOTAL SETS", style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
            pw.Text("$setCount", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildExerciseList(List<WorkoutSet> sets, Map<int, String> exerciseNames) {
    final Map<int, List<WorkoutSet>> grouped = {};
    for (var s in sets) {
      grouped.putIfAbsent(s.exerciseId, () => []).add(s);
    }

    return pw.Column(
      children: grouped.entries.map((entry) {
        final exName = exerciseNames[entry.key] ?? "Unknown Exercise";
        final exSets = entry.value;

        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(exName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey200, width: 0.5),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                    children: [
                      _tableCell("Set", isHeader: true),
                      _tableCell("Weight", isHeader: true),
                      _tableCell("Reps", isHeader: true),
                      _tableCell("1RM", isHeader: true),
                    ],
                  ),
                  ...exSets.asMap().entries.map((e) {
                    final s = e.value;
                    final index = e.key + 1;
                    final oneRM = s.weight * (1 + s.reps / 30);
                    return pw.TableRow(
                      children: [
                        _tableCell("$index"),
                        _tableCell("${s.weight}kg"),
                        _tableCell("${s.reps.toInt()}"),
                        _tableCell("${oneRM.toStringAsFixed(1)}kg"),
                      ],
                    );
                  }),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  pw.Widget _tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
