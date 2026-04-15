import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GithubExercise {
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  String get gifUrl =>
      'https://raw.githubusercontent.com/rahulsaroh/exercises-gifs/main/assets/$id.gif';

  const GithubExercise({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory GithubExercise.fromCsvRow(Map<String, dynamic> row) {
    return GithubExercise(
      id: row['id']?.toString().trim() ?? '',
      name: row['name']?.toString().trim() ?? '',
      bodyPart: row['bodyPart']?.toString().trim() ?? '',
      equipment: row['equipment']?.toString().trim() ?? '',
      target: row['target']?.toString().trim() ?? '',
      secondaryMuscles: [
        row['secondaryMuscles/0'],
        row['secondaryMuscles/1'],
        row['secondaryMuscles/2'],
        row['secondaryMuscles/3'],
        row['secondaryMuscles/4'],
        row['secondaryMuscles/5'],
      ]
          .where((e) => e != null && e.toString().trim().isNotEmpty)
          .map((e) => e.toString().trim())
          .toList(),
      instructions: [
        row['instructions/0'],
        row['instructions/1'],
        row['instructions/2'],
        row['instructions/3'],
        row['instructions/4'],
        row['instructions/5'],
        row['instructions/6'],
        row['instructions/7'],
        row['instructions/8'],
        row['instructions/9'],
        row['instructions/10'],
      ]
          .where((e) => e != null && e.toString().trim().isNotEmpty)
          .map((e) => e.toString().trim())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'bodyPart': bodyPart,
        'equipment': equipment,
        'target': target,
        'secondaryMuscles': secondaryMuscles,
        'instructions': instructions,
      };

  factory GithubExercise.fromJson(Map<String, dynamic> json) => GithubExercise(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        bodyPart: json['bodyPart'] as String? ?? '',
        equipment: json['equipment'] as String? ?? '',
        target: json['target'] as String? ?? '',
        secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
        instructions: List<String>.from(json['instructions'] ?? []),
      );
}

class GithubExerciseService {
  static const String _csvUrl =
      'https://raw.githubusercontent.com/rahulsaroh/exercises-gifs/main/exercises.csv';
  static const String _cacheKey = 'github_exercises_cache';
  static const String _cacheTimestampKey = 'github_exercises_cache_timestamp';
  static const Duration _cacheDuration = Duration(hours: 24);

  List<GithubExercise>? _cachedExercises;

  /// Get all exercises from GitHub CSV
  Future<List<GithubExercise>> getAllExercises(
      {bool forceRefresh = false}) async {
    if (_cachedExercises != null && !forceRefresh) {
      return _cachedExercises!;
    }

    // Try to load from local cache first
    final cached = await _loadFromCache();
    if (cached != null && !forceRefresh) {
      _cachedExercises = cached;
      return cached;
    }

    // Fetch from network
    final exercises = await _fetchFromNetwork();
    _cachedExercises = exercises;

    // Save to cache
    await _saveToCache(exercises);

    return exercises;
  }

  /// Fetch the CSV from GitHub
  Future<List<GithubExercise>> _fetchFromNetwork() async {
    try {
      final response = await http.get(Uri.parse(_csvUrl)).timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('CSV fetch timeout'),
          );

      if (response.statusCode != 200) {
        throw Exception('Failed to load CSV: ${response.statusCode}');
      }

      return _parseCSV(response.body);
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }

  /// Parse CSV content
  List<GithubExercise> _parseCSV(String csvContent) {
    try {
      final rows = const CsvToListConverter(shouldParseNumbers: false)
          .convert(csvContent, eol: '\n');

      if (rows.isEmpty) {
        throw Exception('Empty CSV data');
      }

      // Extract headers from first row
      final headers = rows[0].map((e) => e.toString()).toList();

      // Parse data rows (skip header row)
      final exercises = <GithubExercise>[];
      for (int i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];
          if (row.isEmpty) continue;

          // Create a map from headers and row values
          final rowMap = <String, dynamic>{};
          for (int j = 0; j < headers.length && j < row.length; j++) {
            rowMap[headers[j]] = row[j];
          }

          final exercise = GithubExercise.fromCsvRow(rowMap);
          if (exercise.name.isNotEmpty && exercise.id.isNotEmpty) {
            exercises.add(exercise);
          }
        } catch (e) {
          // Skip malformed rows
          continue;
        }
      }

      return exercises;
    } catch (e) {
      throw Exception('Error parsing CSV: $e');
    }
  }

  /// Load exercises from local cache
  Future<List<GithubExercise>?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      final timestamp = prefs.getInt(_cacheTimestampKey) ?? 0;

      if (cachedJson == null) return null;

      // Check if cache is still valid
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cacheTime) > _cacheDuration) {
        return null; // Cache expired
      }

      final List<dynamic> decoded = jsonDecode(cachedJson);
      return decoded
          .map((item) => GithubExercise.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return null; // Silently fail and fetch from network
    }
  }

  /// Save exercises to local cache
  Future<void> _saveToCache(List<GithubExercise> exercises) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(
        exercises.map((e) => e.toJson()).toList(),
      );
      await prefs.setString(_cacheKey, json);
      await prefs.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      // Silently fail — caching is optional
    }
  }

  /// Filter exercises by body part
  Future<List<GithubExercise>> getByBodyPart(String bodyPart) async {
    final all = await getAllExercises();
    return all
        .where((e) => e.bodyPart.toLowerCase() == bodyPart.toLowerCase())
        .toList();
  }

  /// Filter exercises by equipment
  Future<List<GithubExercise>> getByEquipment(String equipment) async {
    final all = await getAllExercises();
    return all
        .where((e) => e.equipment.toLowerCase() == equipment.toLowerCase())
        .toList();
  }

  /// Filter exercises by target muscle
  Future<List<GithubExercise>> getByTarget(String targetMuscle) async {
    final all = await getAllExercises();
    return all
        .where((e) => e.target.toLowerCase() == targetMuscle.toLowerCase())
        .toList();
  }

  /// Search exercises by name, body part, or target
  Future<List<GithubExercise>> searchExercises(String query) async {
    if (query.isEmpty) return getAllExercises();

    final all = await getAllExercises();
    final lowerQuery = query.toLowerCase();

    return all
        .where((e) =>
            e.name.toLowerCase().contains(lowerQuery) ||
            e.bodyPart.toLowerCase().contains(lowerQuery) ||
            e.target.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Get unique body parts
  Future<List<String>> getBodyParts() async {
    final all = await getAllExercises();
    final bodyParts = <String>{};

    for (final exercise in all) {
      if (exercise.bodyPart.isNotEmpty) {
        bodyParts.add(exercise.bodyPart);
      }
    }

    return bodyParts.toList()..sort();
  }

  /// Get unique equipment types
  Future<List<String>> getEquipmentTypes() async {
    final all = await getAllExercises();
    final equipment = <String>{};

    for (final exercise in all) {
      if (exercise.equipment.isNotEmpty) {
        equipment.add(exercise.equipment);
      }
    }

    return equipment.toList()..sort();
  }

  /// Get unique target muscles
  Future<List<String>> getMuscleTargets() async {
    final all = await getAllExercises();
    final targets = <String>{};

    for (final exercise in all) {
      if (exercise.target.isNotEmpty) {
        targets.add(exercise.target);
      }
    }

    return targets.toList()..sort();
  }

  /// Clear cache
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheTimestampKey);
      _cachedExercises = null;
    } catch (e) {
      // Silently fail
    }
  }
}
