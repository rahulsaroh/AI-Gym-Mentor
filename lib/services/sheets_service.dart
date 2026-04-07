import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class SheetsService {
  final http.Client client;
  final sheets.SheetsApi api;
  final drive.DriveApi _driveApi;
  
  static const String spreadSheetIdKey = 'google_spreadsheet_id';

  SheetsService(this.client) 
    : api = sheets.SheetsApi(client),
      _driveApi = drive.DriveApi(client);

  Future<String?> getSpreadsheetId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(spreadSheetIdKey);
  }

  Future<String?> createSpreadsheet() async {
    // First, try to find an existing "GYM Kilo" spreadsheet
    try {
      final query = "name = 'GYM Kilo' and mimeType = 'application/vnd.google-apps.spreadsheet' and trashed = false";
      final files = await _driveApi.files.list(q: query, spaces: 'drive', $fields: 'files(id, name)');
      
      if (files.files != null && files.files!.isNotEmpty) {
        final existingId = files.files!.first.id;
        if (existingId != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(spreadSheetIdKey, existingId);
          return existingId;
        }
      }
    } catch (e) {
      debugPrint('SheetsService: Error searching for existing spreadsheet: $e');
    }

    final spreadsheet = sheets.Spreadsheet(
      properties: sheets.SpreadsheetProperties(title: 'GYM Kilo'),
      sheets: [
        _buildSheet('Workout Log', [
          'Date', 'Day', 'Workout Name', 'Exercise', 'Set#', 'Set Type', 
          'Weight(kg)', 'Reps', 'RPE', 'Est 1RM', 'Volume(kg)', 'Is PR', 
          'Exercise Notes', 'Workout Notes'
        ]),
        _buildSheet('Exercises', ['Name', 'Muscle Group', 'Equipment', 'Notes']),
        _buildSheet('Body Stats', [
          'Date', 'Weight', 'Chest', 'Waist', 'Hips', 'Left Arm', 'Right Arm', 
          'Left Thigh', 'Right Thigh', 'Calves', 'Body Fat'
        ]),
      ],
    );

    final result = await api.spreadsheets.create(spreadsheet);
    final id = result.spreadsheetId;
    
    if (id != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(spreadSheetIdKey, id);
      
      // Apply initial formatting
      await _applyFormatting(id, result.sheets!);
    }
    
    return id;
  }

  sheets.Sheet _buildSheet(String title, List<String> headers) {
    return sheets.Sheet(
      properties: sheets.SheetProperties(title: title),
      data: [
        sheets.GridData(
          rowData: [
            sheets.RowData(
              values: headers.map((h) => sheets.CellData(
                userEnteredValue: sheets.ExtendedValue(stringValue: h),
                userEnteredFormat: sheets.CellFormat(
                  textFormat: sheets.TextFormat(bold: true),
                  backgroundColor: sheets.Color(red: 0.9, green: 0.9, blue: 0.9),
                ),
              )).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _applyFormatting(String spreadsheetId, List<sheets.Sheet> sheetList) async {
    final requests = <sheets.Request>[];
    
    for (var sheet in sheetList) {
      final sheetId = sheet.properties!.sheetId!;
      
      // Freeze header row
      requests.add(sheets.Request(
        updateSheetProperties: sheets.UpdateSheetPropertiesRequest(
          properties: sheets.SheetProperties(
            sheetId: sheetId,
            gridProperties: sheets.GridProperties(frozenRowCount: 1),
          ),
          fields: 'gridProperties.frozenRowCount',
        ),
      ));

      // Alternating colors
      requests.add(sheets.Request(
        addConditionalFormatRule: sheets.AddConditionalFormatRuleRequest(
          rule: sheets.ConditionalFormatRule(
            ranges: [sheets.GridRange(sheetId: sheetId, startRowIndex: 1)],
            booleanRule: sheets.BooleanRule(
              condition: sheets.BooleanCondition(type: 'CUSTOM_FORMULA', values: [sheets.ConditionValue(userEnteredValue: '=ISEVEN(ROW())')]),
              format: sheets.CellFormat(backgroundColor: sheets.Color(red: 0.95, green: 0.97, blue: 1.0)),
            ),
          ),
          index: 0,
        ),
      ));
    }

    await api.spreadsheets.batchUpdate(
      sheets.BatchUpdateSpreadsheetRequest(requests: requests),
      spreadsheetId,
    );
  }

  Future<void> appendWorkoutsBatch(List<Map<String, dynamic>> workoutDataList) async {
    final spreadsheetId = await getSpreadsheetId();
    if (spreadsheetId == null) return;

    final allRows = <List<dynamic>>[];
    for (var data in workoutDataList) {
      final workout = data['workout'] as Workout;
      final sets = data['sets'] as List<WorkoutSet>;
      final exerciseNames = data['exerciseNames'] as Map<int, String>;

      final dateStr = DateFormat('yyyy-MM-dd').format(workout.date);
      final dayStr = DateFormat('EEEE').format(workout.date);

      for (var s in sets) {
        final volume = s.weight * s.reps;
        final est1rm = s.reps > 1 ? s.weight / (1.0278 - (0.0278 * s.reps)) : s.weight;
        
        allRows.add([
          dateStr, dayStr, workout.name, exerciseNames[s.exerciseId] ?? 'Unknown',
          s.setNumber, s.setType.name, s.weight, s.reps, s.rpe ?? '',
          est1rm.toStringAsFixed(1), volume.toStringAsFixed(1),
          s.isPr, s.notes ?? '', workout.notes ?? '',
        ]);
      }
    }

    if (allRows.isEmpty) return;

    await _withRetry(() => api.spreadsheets.values.append(
      sheets.ValueRange(values: allRows),
      spreadsheetId,
      'Workout Log!A1',
      valueInputOption: 'USER_ENTERED',
    ));
  }

  Future<void> appendMeasurementsBatch(List<BodyMeasurement> measurements) async {
    final spreadsheetId = await getSpreadsheetId();
    if (spreadsheetId == null) return;

    final rows = measurements.map((m) {
      final dateStr = DateFormat('yyyy-MM-dd').format(m.date);
      return [
        dateStr, m.weight, m.chest, m.waist, m.hips, 
        m.leftArm, m.rightArm, m.leftThigh, m.rightThigh, 
        m.calves, m.bodyFat
      ];
    }).toList();

    await _withRetry(() => api.spreadsheets.values.append(
      sheets.ValueRange(values: rows),
      spreadsheetId,
      'Body Stats!A1',
      valueInputOption: 'USER_ENTERED',
    ));
  }

  Future<T> _withRetry<T>(Future<T> Function() action) async {
    int attempts = 0;
    while (true) {
      try {
        return await action();
      } catch (e) {
        attempts++;
        if (e.toString().contains('429') && attempts < 3) {
          await Future.delayed(Duration(seconds: attempts * 2));
          continue;
        }
        rethrow;
      }
    }
  }

  Future<void> appendWorkout(Workout workout, List<WorkoutSet> sets, Map<int, String> exerciseNames) async {
    await appendWorkoutsBatch([{'workout': workout, 'sets': sets, 'exerciseNames': exerciseNames}]);
  }

  Future<void> appendMeasurement(BodyMeasurement m) async {
    await appendMeasurementsBatch([m]);
  }
}
