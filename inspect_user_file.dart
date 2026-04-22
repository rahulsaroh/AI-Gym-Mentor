import 'dart:io';
import 'package:excel/excel.dart';

void main() async {
  final file = File('e:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/Copy of gym_report_22042026.xlsx');
  if (!file.existsSync()) {
    print('File not found at ${file.path}');
    return;
  }
  
  final bytes = file.readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);
  
  print('Sheets: ${excel.tables.keys.toList()}');
  
  final table = excel.tables['Body Measurements'];
  if (table != null) {
    print('\nSheet: Body Measurements');
    final rows = table.rows;
    if (rows.isNotEmpty) {
      final headers = rows.first.map((c) => c?.value?.toString() ?? 'null').toList();
      print('Headers: $headers');
      
      for (var i = 1; i < rows.length; i++) {
        final dataRow = rows[i].map((c) => c?.value?.toString() ?? 'null').toList();
        print('Row $i: $dataRow');
      }
      print('Total rows: ${rows.length}');
    }
  } else {
    print('Sheet "Body Measurements" not found');
  }
}
