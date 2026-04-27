import 'package:csv/csv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'csv_import_service.g.dart';

@riverpod
class CsvImportService extends _$CsvImportService {
  @override
  void build() {}

  Future<List<Map<String, dynamic>>> parseCsv(String csvContent) async {
    const converter = CsvToListConverter();
    final List<List<dynamic>> rows = converter.convert(csvContent);
    if (rows.isEmpty) return [];

    final List<String> headers = rows.first.map((e) => e.toString().trim().toLowerCase()).toList();
    final List<Map<String, dynamic>> data = [];

    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty || (row.length == 1 && row[0].toString().isEmpty)) continue;
      
      final Map<String, dynamic> mappedRow = {};
      for (var j = 0; j < headers.length; j++) {
        if (j < row.length) {
          mappedRow[headers[j]] = row[j];
        }
      }
      data.add(mappedRow);
    }
    return data;
  }

  /// Maps CSV field names to our internal model keys
  Map<String, String> identifyHeaders(List<String> headers) {
    final Map<String, String> mapping = {};
    final lowerHeaders = headers.map((h) => h.toLowerCase()).toList();

    for (var h in headers) {
      final l = h.toLowerCase();
      if (l.contains('date')) {
        mapping[h] = 'date';
      } else if (l.contains('exercise')) mapping[h] = 'exercise';
      else if (l.contains('weight')) mapping[h] = 'weight';
      else if (l.contains('reps')) mapping[h] = 'reps';
      else if (l.contains('set') && !l.contains('type')) mapping[h] = 'set_number';
      else if (l.contains('type')) mapping[h] = 'set_type';
      else if (l.contains('note')) mapping[h] = 'notes';
      else if (l.contains('unit')) mapping[h] = 'unit';
      else if (l.contains('rpe')) mapping[h] = 'rpe';
      else if (l.contains('distance')) mapping[h] = 'distance';
      else if (l.contains('time') || l.contains('duration')) mapping[h] = 'time';
      // Body Metrics
      else if (l.contains('body fat')) mapping[h] = 'body_fat';
      else if (l.contains('subcutaneous')) mapping[h] = 'subcutaneous_fat';
      else if (l.contains('visceral')) mapping[h] = 'visceral_fat';
      else if (l.contains('neck')) mapping[h] = 'neck';
      else if (l.contains('chest')) mapping[h] = 'chest';
      else if (l.contains('shoulder')) mapping[h] = 'shoulders';
      else if (l.contains('left bicep') || l.contains('arm left')) mapping[h] = 'arm_left';
      else if (l.contains('right bicep') || l.contains('arm right')) mapping[h] = 'arm_right';
      else if (l.contains('left forearm')) mapping[h] = 'forearm_left';
      else if (l.contains('right forearm')) mapping[h] = 'forearm_right';
      else if (l.contains('waist') && !l.contains('naval')) mapping[h] = 'waist';
      else if (l.contains('naval')) mapping[h] = 'waist_naval';
      else if (l.contains('hips')) mapping[h] = 'hips';
      else if (l.contains('left thigh')) mapping[h] = 'thigh_left';
      else if (l.contains('right thigh')) mapping[h] = 'thigh_right';
      else if (l.contains('left calf')) mapping[h] = 'calf_left';
      else if (l.contains('right calf')) mapping[h] = 'calf_right';
    }
    return mapping;
  }

  DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    if (str.isEmpty) return null;

    final formats = [
      'yyyy-MM-dd',
      'yyyy-MM-dd HH:mm:ss',
      'yyyy/MM/dd',
      'dd-MM-yyyy',
      'dd/MM/yyyy',
      'MM/dd/yyyy',
    ];

    for (var format in formats) {
      try {
        return DateFormat(format).parse(str);
      } catch (_) {}
    }

    try {
      return DateTime.parse(str);
    } catch (_) {}

    return null;
  }
}
