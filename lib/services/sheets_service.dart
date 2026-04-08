import 'package:http/http.dart' as http;
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/services/sheets_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class SheetsService {
  final http.Client client;
  final SheetsApiClient _api;
  
  static const String spreadSheetIdKey = 'google_spreadsheet_id';

  SheetsService(this.client) : _api = SheetsApiClient(client);

  Future<String?> getSpreadsheetId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(spreadSheetIdKey);
  }

  Future<String?> createSpreadsheet() async {
    // First, try to find an existing "GYM Kilo" spreadsheet
    try {
      final existingId = await _api.findSpreadsheetId('GYM Kilo');
      if (existingId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(spreadSheetIdKey, existingId);
        return existingId;
      }
    } catch (e) {
      debugPrint('SheetsService: Error searching for existing spreadsheet: $e');
    }

    final titles = ['Workout Log', 'Exercises', 'Body Stats'];
    final result = await _api.createSpreadsheet('GYM Kilo', titles);
    
    if (result != null) {
      final id = result['spreadsheetId'] as String?;
      if (id != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(spreadSheetIdKey, id);
        
        final sheets = result['sheets'] as List?;
        if (sheets != null) {
          await _applyFormatting(id, sheets);
          // Initial headers are actually set during create if we used data, 
          // but since we created empty sheets, we'll append headers now.
          await _initializeHeaders(id);
        }
        return id;
      }
    }
    
    return null;
  }

  Future<void> _initializeHeaders(String id) async {
    await _api.appendValues(id, 'Workout Log!A1', [[
      'Date', 'Day', 'Workout Name', 'Exercise', 'Set#', 'Set Type', 
      'Weight(kg)', 'Reps', 'RPE', 'Est 1RM', 'Volume(kg)', 'Is PR', 
      'Exercise Notes', 'Workout Notes'
    ]]);
    await _api.appendValues(id, 'Exercises!A1', [['Name', 'Muscle Group', 'Equipment', 'Notes']]);
    await _api.appendValues(id, 'Body Stats!A1', [[
      'Date', 'Weight', 'Chest', 'Waist', 'Hips', 'Left Arm', 'Right Arm', 
      'Left Thigh', 'Right Thigh', 'Calves', 'Body Fat'
    ]]);
  }

  Future<void> _applyFormatting(String spreadsheetId, List<dynamic> sheetList) async {
    final requests = <Map<String, dynamic>>[];
    
    for (var sheet in sheetList) {
      final properties = sheet['properties'] as Map<String, dynamic>;
      final sheetId = properties['sheetId'];
      
      // Freeze header row
      requests.add({
        'updateSheetProperties': {
          'properties': {
            'sheetId': sheetId,
            'gridProperties': {'frozenRowCount': 1},
          },
          'fields': 'gridProperties.frozenRowCount',
        },
      });

      // Alternating colors (Zebras)
      requests.add({
        'addConditionalFormatRule': {
          'rule': {
            'ranges': [{'sheetId': sheetId, 'startRowIndex': 1}],
            'booleanRule': {
              'condition': {
                'type': 'CUSTOM_FORMULA', 
                'values': [{'userEnteredValue': '=ISEVEN(ROW())'}]
              },
              'format': {
                'backgroundColor': {'red': 0.95, 'green': 0.97, 'blue': 1.0}
              },
            },
          },
          'index': 0,
        },
      });
      
      // Bold Headers
      requests.add({
        'repeatCell': {
          'range': {
            'sheetId': sheetId,
            'startRowIndex': 0,
            'endRowIndex': 1,
          },
          'cell': {
            'userEnteredFormat': {
              'textFormat': {'bold': true},
              'backgroundColor': {'red': 0.9, 'green': 0.9, 'blue': 0.9},
            }
          },
          'fields': 'userEnteredFormat(textFormat,backgroundColor)',
        }
      });
    }

    await _api.batchUpdate(spreadsheetId, requests);
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

    await _withRetry(() => _api.appendValues(
      spreadsheetId,
      'Workout Log!A1',
      allRows,
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

    await _withRetry(() => _api.appendValues(
      spreadsheetId,
      'Body Stats!A1',
      rows,
    ));
  }

  Future<T> _withRetry<T>(Future<T> Function() action) async {
    int attempts = 0;
    while (true) {
      try {
        return await action();
      } catch (e) {
        attempts++;
        if (e.toString().contains('RATE_LIMIT_EXCEEDED') && attempts < 3) {
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
