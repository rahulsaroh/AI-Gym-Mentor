import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

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

    final exerciseById = {for (final e in exercises) e.id: e};

    for (var w in workouts) {
      final workoutSets = allSets.where((s) => s.workoutId == w.id).toList();
      final when = w.startTime ?? w.date;
      for (var s in workoutSets) {
        final ex = exerciseById[s.exerciseId];
        rows.add([
          DateFormat('yyyy-MM-dd HH:mm').format(when),
          w.name,
          ex?.name ?? 'Unknown',
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
    final exerciseById = {for (final e in exercises) e.id: e};

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
                            '${w.name} - ${DateFormat('MMM d, yyyy').format(w.startTime ?? w.date)}',
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
                    final ex = exerciseById[exId];
                    final exSets =
                        workoutSets.where((s) => s.exerciseId == exId).toList();
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 12, bottom: 8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(ex?.name ?? 'Unknown',
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

  Future<Map<String, dynamic>?> exportToXlsx() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await db.select(db.workouts).get();
    final allSets = await db.select(db.workoutSets).get();
    final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();
    final measurements = await db.select(db.bodyMeasurements).get();

    final excel = Excel.createExcel();
    excel.delete('Sheet1'); // Remove default

    final exerciseById = {for (final e in exercises) e.id: e};

    // ─── 1. RAW LOG SHEET ───
    final rawSheet = excel['Raw Log'];
    // prSheet.setTabColor(...) not supported in 4.0.6
    
    final rawHeaderStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.white,
      backgroundColorHex: ExcelColor.fromHexString('#1E3A5F'),
    );

    final rawHeaders = [
      'Date', 'Day', 'Workout Name', 'Exercise', 'Exercise ID', 'Set#', 'Set Type',
      'Weight(kg)', 'Reps', 'RPE', 'Volume(kg)', 'Is PR', 'Notes'
    ];

    for (var i = 0; i < rawHeaders.length; i++) {
      var cell = rawSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(rawHeaders[i]);
      cell.cellStyle = rawHeaderStyle;
    }

    // Process sets for Raw Log and collections for other sheets
    List<Map<String, dynamic>> processedSets = [];
    for (var w in workouts) {
      final wSets = allSets.where((s) => s.workoutId == w.id).toList()
                   ..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder) == 0 
                                    ? a.setNumber.compareTo(b.setNumber) 
                                    : a.exerciseOrder.compareTo(b.exerciseOrder));
      final dateStr = DateFormat('yyyy-MM-dd').format(w.startTime ?? w.date);
      final dayName = DateFormat('EEEE').format(w.startTime ?? w.date);

      for (var s in wSets) {
        final ex = exerciseById[s.exerciseId];
        final vol = s.weight * s.reps;
        
        rawSheet.appendRow([
          TextCellValue(dateStr),
          TextCellValue(dayName),
          TextCellValue(w.name),
          TextCellValue(ex?.name ?? 'Unknown'),
          IntCellValue(s.exerciseId),
          IntCellValue(s.setNumber),
          TextCellValue(s.setType.name),
          DoubleCellValue(s.weight),
          DoubleCellValue(s.reps),
          TextCellValue(s.rpe?.toString() ?? ''),
          DoubleCellValue(vol),
          TextCellValue(s.isPr ? 'YES' : ''),
          TextCellValue(s.notes ?? ''),
        ]);

        processedSets.add({
          'date': w.startTime ?? w.date,
          'dateStr': dateStr,
          'dayName': dayName,
          'workoutName': w.name,
          'exercise': ex?.name ?? 'Unknown',
          'weight': s.weight,
          'reps': s.reps,
          'volume': vol,
          'isPr': s.isPr,
          'notes': s.notes ?? '',
        });
      }
    }

    // ─── 2. WORKOUT SUMMARY SHEET ───
    final summarySheet = excel['Workout Summary'];
    // setTabColor not supported in 4.0.6
    final summaryHeaderStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.white,
      backgroundColorHex: ExcelColor.fromHexString('#1B4332'),
    );
    final prRowStyle = CellStyle(backgroundColorHex: ExcelColor.fromHexString('#FFD700')); // Gold for PR

    final summaryHeaders = [
      'Date', 'Day', 'Workout Name', 'Total Exercises', 'Total Sets', 
      'Total Volume (kg)', 'Top Exercise', 'Is PR Session', 'Notes'
    ];
    for (var i = 0; i < summaryHeaders.length; i++) {
      var cell = summarySheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(summaryHeaders[i]);
      cell.cellStyle = summaryHeaderStyle;
    }

    final workoutGroups = _groupBy(processedSets, (s) => '${s['dateStr']}_${s['workoutName']}');
    for (var entry in workoutGroups.entries) {
      final sets = entry.value;
      final uniqueExCount = sets.map((s) => s['exercise']).toSet().length;
      final totalVol = sets.fold(0.0, (sum, s) => sum + (s['volume'] as double));
      final hasPR = sets.any((s) => s['isPr'] == true);
      
      // Calculate Top Exercise by Volume
      final exVolMap = <String, double>{};
      for (var s in sets) {
        exVolMap[s['exercise']] = (exVolMap[s['exercise']] ?? 0.0) + (s['volume'] as double);
      }
      final topEx = exVolMap.entries.reduce((a, b) => a.value >= b.value ? a : b).key;

      summarySheet.appendRow([
        TextCellValue(sets.first['dateStr']),
        TextCellValue(sets.first['dayName']),
        TextCellValue(sets.first['workoutName']),
        IntCellValue(uniqueExCount),
        IntCellValue(sets.length),
        DoubleCellValue(totalVol),
        TextCellValue(topEx),
        TextCellValue(hasPR ? 'YES' : ''),
        TextCellValue(''),
      ]);

      if (hasPR) {
        // Highlighting PR rows - apply to specific cells in the last row
        final lastRowIdx = summarySheet.maxRows - 1;
        summarySheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: lastRowIdx)).cellStyle = prRowStyle;
      }
    }

    // ─── 3. EXERCISE PRS SHEET ───
    final prSheet = excel['Exercise PRs'];
    // setTabColor not supported in 4.0.6
    final prHeaderStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.white,
      backgroundColorHex: ExcelColor.fromHexString('#7B2D00'),
    );
    final boldStyle = CellStyle(bold: true);

    final prHeaders = [
      'Exercise', 'Best Weight (kg)', 'Best Reps at Best Weight', 
      'Best Single Set Volume (kg)', 'Date Achieved', 'Workout Name'
    ];
    for (var i = 0; i < prHeaders.length; i++) {
      var cell = prSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(prHeaders[i]);
      cell.cellStyle = prHeaderStyle;
    }

    final exGroups = _groupBy(processedSets, (s) => (s['exercise'] as String).toLowerCase());
    final sortedExKeys = exGroups.keys.toList()..sort();
    
    for (var key in sortedExKeys) {
      final sets = exGroups[key]!;
      final bestWeightSet = sets.reduce((a, b) => (a['weight'] as double) >= (b['weight'] as double) ? a : b);
      final bestVolSet = sets.reduce((a, b) => (a['volume'] as double) >= (b['volume'] as double) ? a : b);

      prSheet.appendRow([
        TextCellValue(sets.first['exercise']),
        DoubleCellValue(bestWeightSet['weight']),
        DoubleCellValue(bestWeightSet['reps']),
        DoubleCellValue(bestVolSet['volume']),
        TextCellValue(bestVolSet['dateStr']),
        TextCellValue(bestVolSet['workoutName']),
      ]);
      
      final lastRowIdx = prSheet.maxRows - 1;
      prSheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: lastRowIdx)).cellStyle = boldStyle;
    }

    // ─── 4. WEEKLY VOLUME SHEET ───
    final weekSheet = excel['Weekly Volume'];
    // setTabColor not supported in 4.0.6
    final weekHeaderStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.white,
      backgroundColorHex: ExcelColor.fromHexString('#1A237E'),
    );

    final weekHeaders = ['Week (Mon–Sun)', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Total Volume', 'Sessions', 'Avg Volume'];
    for (var i = 0; i < weekHeaders.length; i++) {
      var cell = weekSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(weekHeaders[i]);
      cell.cellStyle = weekHeaderStyle;
    }

    final setsByWeek = _groupBy(processedSets, (s) => _getWeekLabel(s['date']));
    final sortedWeeks = setsByWeek.keys.toList()..sort((a, b) => b.compareTo(a)); // Newest first

    for (var weekLabel in sortedWeeks) {
      final weekSets = setsByWeek[weekLabel]!;
      final dayVols = List.generate(7, (i) => 0.0);
      final sessionDates = <String>{};
      
      for (var s in weekSets) {
        // Monday = 1, Sunday = 7 in ISO
        final weekday = (s['date'] as DateTime).weekday;
        dayVols[weekday - 1] += (s['volume'] as double);
        sessionDates.add(s['dateStr']);
      }

      final totalWeekVol = dayVols.reduce((a, b) => a + b);
      final avgVol = sessionDates.isEmpty ? 0.0 : totalWeekVol / sessionDates.length;

      List<CellValue> rowData = [TextCellValue(weekLabel)];
      for (var v in dayVols) {
        rowData.add(v > 0 ? DoubleCellValue(v) : TextCellValue(''));
      }
      rowData.addAll([
        DoubleCellValue(totalWeekVol),
        IntCellValue(sessionDates.length),
        DoubleCellValue(avgVol),
      ]);
      weekSheet.appendRow(rowData);

      // Apply heatmap styling
      final rowIdx = weekSheet.maxRows - 1;
      for (var i = 0; i < 7; i++) {
        final vol = dayVols[i];
        if (vol > 0) {
          String color = '#C8E6C9'; // Light
          if (vol >= 5000) color = '#2E7D32'; // High
          else if (vol >= 2000) color = '#66BB6A'; // Medium
          weekSheet.cell(CellIndex.indexByColumnRow(columnIndex: i + 1, rowIndex: rowIdx)).cellStyle = 
            CellStyle(backgroundColorHex: ExcelColor.fromHexString(color));
        }
      }
    }

    // ─── 5. BODY MEASUREMENTS SHEET ───
    final measureSheet = excel['Body Measurements'];
    // setTabColor not supported in 4.0.6
    final measureHeaderStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.white,
      backgroundColorHex: ExcelColor.fromHexString('#4A148C'),
    );

    final measureHeaders = [
      'Date', 'Weight (kg)', 'Δ Weight', 'Body Fat (%)', 'Subcutaneous Fat (%)', 'Visceral Fat', 
      'Neck', 'Chest', 'Shoulders', 'Left Bicep', 'Right Bicep', 'Left Forearm', 'Right Forearm',
      'Waist', 'Naval Waist', 'Hips', 'Left Thigh', 'Right Thigh', 
      'Left Calf', 'Right Calf', 'Notes'
    ];
    for (var i = 0; i < measureHeaders.length; i++) {
      var cell = measureSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(measureHeaders[i]);
      cell.cellStyle = measureHeaderStyle;
    }

    measurements.sort((a, b) => a.date.compareTo(b.date));
    double? prevWeight;

    for (var m in measurements) {
      final delta = (m.weight != null && prevWeight != null) ? m.weight! - prevWeight : null;
      final deltaStr = delta != null ? (delta >= 0 ? '+${delta.toStringAsFixed(1)}' : delta.toStringAsFixed(1)) : '';
      
      measureSheet.appendRow([
        TextCellValue(DateFormat('yyyy-MM-dd').format(m.date)),
        m.weight != null ? DoubleCellValue(m.weight!) : null,
        TextCellValue(deltaStr),
        m.bodyFat != null ? DoubleCellValue(m.bodyFat!) : null,
        m.subcutaneousFat != null ? DoubleCellValue(m.subcutaneousFat!) : null,
        m.visceralFat != null ? DoubleCellValue(m.visceralFat!) : null,
        m.neck != null ? DoubleCellValue(m.neck!) : null,
        m.chest != null ? DoubleCellValue(m.chest!) : null,
        m.shoulders != null ? DoubleCellValue(m.shoulders!) : null,
        m.armLeft != null ? DoubleCellValue(m.armLeft!) : null,
        m.armRight != null ? DoubleCellValue(m.armRight!) : null,
        m.forearmLeft != null ? DoubleCellValue(m.forearmLeft!) : null,
        m.forearmRight != null ? DoubleCellValue(m.forearmRight!) : null,
        m.waist != null ? DoubleCellValue(m.waist!) : null,
        m.waistNaval != null ? DoubleCellValue(m.waistNaval!) : null,
        m.hips != null ? DoubleCellValue(m.hips!) : null,
        m.thighLeft != null ? DoubleCellValue(m.thighLeft!) : null,
        m.thighRight != null ? DoubleCellValue(m.thighRight!) : null,
        m.calfLeft != null ? DoubleCellValue(m.calfLeft!) : null,
        m.calfRight != null ? DoubleCellValue(m.calfRight!) : null,
        TextCellValue(m.notes ?? ''),
      ]);
      prevWeight = m.weight;
    }

    // ─── GLOBAL FORMATTING ───
    // Note: setSheetOrder and setDefaultSheet are not supported in excel: 4.0.6
    // Sheets follow creation order: Raw Log, Workout Summary, Exercise PRs, Weekly Volume, Body Measurements

    // Column Widths
    for (var sheet in excel.tables.values) {
       sheet.setColumnWidth(0, 15); // Date / Exercise
       if (sheet.sheetName == 'Raw Log') {
         sheet.setColumnWidth(3, 25); // Exercise
         sheet.setColumnWidth(2, 20); // Workout Name
       }
    }

    // Save
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/gym_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final fileBytes = excel.save();
    if (fileBytes != null) {
      final file = File(filePath)..writeAsBytesSync(fileBytes);
      return {
        'path': file.path,
        'exerciseRows': rawSheet.maxRows - 1,
        'measurementRows': measureSheet.maxRows - 1,
        'fileSize': file.lengthSync(),
      };
    }
    return null;
  }

  Map<K, List<V>> _groupBy<V, K>(Iterable<V> values, K Function(V) key) {
    var map = <K, List<V>>{};
    for (var value in values) {
      (map[key(value)] ??= []).add(value);
    }
    return map;
  }

  String _getWeekLabel(DateTime date) {
    // Mon–Sun label
    final diff = date.weekday - 1;
    final monday = date.subtract(Duration(days: diff));
    final sunday = monday.add(const Duration(days: 6));
    final monthFormat = DateFormat('MMM d');
    final yearFormat = DateFormat('yyyy');
    return '${monthFormat.format(monday)}–${DateFormat('d').format(sunday)}, ${yearFormat.format(sunday)}';
  }
}
