import 'dart:convert';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
    required super.id,
    required super.exerciseId,
    required super.name,
    super.alternateNames = const [],
    super.category = 'strength',
    super.difficulty = 'beginner',
    super.force,
    super.mechanic,
    super.equipment,
    super.primaryMuscles = const [],
    super.secondaryMuscles = const [],
    super.targetBodyParts = const [],
    super.instructions = const [],
    super.safetyTips = const [],
    super.commonMistakes = const [],
    super.overview,
    super.imageUrls = const [],
    super.gifUrl,
    super.videoUrl,
    super.variations = const [],
    super.relatedExerciseIds = const [],
    super.progressionPath = const [],
    super.isFavorite = false,
    super.isEnriched = false,
    super.nameHi,
    super.nameMr,
    super.setType = 'Straight',
    super.restTime = 90,
    super.source = 'local',
    super.isCustom = false,
    super.lastUsed,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = 'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/';
    final images = (json['images'] as List<dynamic>? ?? [])
        .map((img) => '$baseUrl$img')
        .toList();

    return ExerciseModel(
      id: 0, // Assigned by DB
      exerciseId: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'strength',
      difficulty: json['level'] as String? ?? 'beginner', // level -> difficulty
      force: json['force'] as String?,
      mechanic: json['mechanic'] as String?,
      equipment: json['equipment'] as String?,
      primaryMuscles: List<String>.from(json['primaryMuscles'] ?? []),
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      imageUrls: images,
    );
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] as int,
      exerciseId: map['exerciseId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? 'strength',
      difficulty: map['difficulty'] as String? ?? 'beginner',
      force: map['force'] as String?,
      mechanic: map['mechanic'] as String?,
      equipment: map['equipment'] as String?,
      primaryMuscles: _decodeList(map['primaryMuscles']),
      secondaryMuscles: _decodeList(map['secondaryMuscles']),
      targetBodyParts: _decodeList(map['targetBodyParts']),
      instructions: _decodeList(map['instructions']),
      safetyTips: _decodeList(map['safetyTips']),
      commonMistakes: _decodeList(map['commonMistakes']),
      overview: map['overview'] as String?,
      imageUrls: _decodeList(map['imageUrls']),
      gifUrl: map['gifUrl'] as String?,
      videoUrl: map['videoUrl'] as String?,
      variations: _decodeList(map['variations']),
      isFavorite: (map['isFavorite'] ?? 0) == 1,
      isEnriched: (map['isEnriched'] ?? 0) == 1,
      setType: map['setType'] as String? ?? 'Straight',
      restTime: map['restTime'] as int? ?? 90,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'name': name,
      'category': category,
      'difficulty': difficulty,
      'force': force,
      'mechanic': mechanic,
      'equipment': equipment,
      'primaryMuscles': jsonEncode(primaryMuscles),
      'secondaryMuscles': jsonEncode(secondaryMuscles),
      'targetBodyParts': jsonEncode(targetBodyParts),
      'instructions': jsonEncode(instructions),
      'safetyTips': jsonEncode(safetyTips),
      'commonMistakes': jsonEncode(commonMistakes),
      'overview': overview,
      'imageUrls': jsonEncode(imageUrls),
      'gifUrl': gifUrl,
      'videoUrl': videoUrl,
      'variations': jsonEncode(variations),
      'isFavorite': isFavorite ? 1 : 0,
      'isEnriched': isEnriched ? 1 : 0,
    };
  }

  ExerciseEntity toEntity() => this;

  static List<String> _decodeList(dynamic value) {
    if (value == null) return [];
    if (value is String) {
      try {
        return List<String>.from(jsonDecode(value));
      } catch (_) {
        return [];
      }
    }
    return [];
  }
}
