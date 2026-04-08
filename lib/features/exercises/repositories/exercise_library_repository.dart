import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/exercise.dart';

part 'exercise_library_repository.g.dart';

class ExerciseLibraryRepository {
  static Database? _database;
  static const String tableName = 'exercises_library';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'exercises_library.sqlite');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            category TEXT,
            difficulty TEXT,
            primaryMuscles TEXT,
            secondaryMuscles TEXT,
            equipment TEXT,
            instructions TEXT,
            gifUrl TEXT,
            imageUrl TEXT,
            videoUrl TEXT,
            mechanic TEXT,
            force TEXT,
            source TEXT
          )
        ''');
      },
    );
  }

  Future<void> seedDatabase() async {
    final db = await database;
    
    // Check if already seeded
    final countResult = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    final count = Sqflite.firstIntValue(countResult);
    if (count != null && count > 0) return;

    // Load from assets
    try {
      final jsonString = await rootBundle.loadString('assets/data/exercises.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      
      final batch = db.batch();
      for (var item in jsonData) {
        final exercise = Exercise.fromJson(item);
        batch.insert(tableName, exercise.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      // In a real app, you'd log this or handle it better
      print('Error seeding exercise library: $e');
    }
  }

  Future<List<Exercise>> getAllExercises({int limit = 50, int offset = 0}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName, 
      limit: limit, 
      offset: offset,
      orderBy: 'name ASC'
    );
    return List.generate(maps.length, (i) => Exercise.fromMap(maps[i]));
  }

  Future<List<Exercise>> searchExercises(String query, {int limit = 50}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'name LIKE ? OR primaryMuscles LIKE ? OR equipment LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      limit: limit,
      orderBy: 'name ASC'
    );
    return List.generate(maps.length, (i) => Exercise.fromMap(maps[i]));
  }

  Future<List<Exercise>> filterExercises({
    String? category,
    String? equipment,
    String? difficulty,
    int limit = 50,
    int offset = 0,
  }) async {
    final db = await database;
    String where = '1=1';
    List<dynamic> whereArgs = [];

    if (category != null && category.isNotEmpty) {
      where += ' AND category = ?';
      whereArgs.add(category);
    }
    if (equipment != null && equipment.isNotEmpty) {
      where += ' AND equipment = ?';
      whereArgs.add(equipment);
    }
    if (difficulty != null && difficulty.isNotEmpty) {
      where += ' AND difficulty = ?';
      whereArgs.add(difficulty);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
      offset: offset,
      orderBy: 'name ASC'
    );
    return List.generate(maps.length, (i) => Exercise.fromMap(maps[i]));
  }

  Future<Exercise?> getExerciseById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Exercise.fromMap(maps.first);
    }
    return null;
  }
}

@riverpod
ExerciseLibraryRepository exerciseLibraryRepository(ExerciseLibraryRepositoryRef ref) {
  return ExerciseLibraryRepository();
}
