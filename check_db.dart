import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('gym_log_local.sqlite');
  
  print('Checking body_measurements table...');
  try {
    final ResultSet results = db.select('SELECT date, weight, body_fat, chest FROM body_measurements ORDER BY date DESC LIMIT 20');
    for (final row in results) {
      final dateTs = row['date'] as int;
      final date = DateTime.fromMillisecondsSinceEpoch(dateTs * 1000);
      print('Date: ${date.toIso8601String()}, Weight: ${row['weight']}, BodyFat: ${row['body_fat']}, Chest: ${row['chest']}');
    }
    
    if (results.isEmpty) {
      print('No measurements found.');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    db.dispose();
  }
}
