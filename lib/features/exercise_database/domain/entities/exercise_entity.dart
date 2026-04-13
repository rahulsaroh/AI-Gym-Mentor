import 'dart:convert';

class ExerciseEntity {
  final int id;
  final String exerciseId;
  final String name;
  final List<String> alternateNames;
  final String category;
  final String difficulty;
  final String? force;
  final String? mechanic;
  final String? equipment;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final List<String> targetBodyParts;
  final List<String> instructions;
  final List<String> safetyTips;
  final List<String> commonMistakes;
  final String? overview;
  final List<String> imageUrls;
  final String? gifUrl;
  final String? videoUrl;
  final List<String> variations;
  final List<String> relatedExerciseIds;
  final List<String> progressionPath;
  final bool isFavorite;
  final bool isEnriched;
  final String? nameHi;
  final String? nameMr;

  // Project-specific metadata
  final String setType;
  final int restTime;
  final String source;
  final bool isCustom;
  final DateTime? lastUsed;

  const ExerciseEntity({
    required this.id,
    required this.exerciseId,
    required this.name,
    this.alternateNames = const [],
    this.category = 'strength',
    this.difficulty = 'beginner',
    this.force,
    this.mechanic,
    this.equipment,
    this.primaryMuscles = const [],
    this.secondaryMuscles = const [],
    this.targetBodyParts = const [],
    this.instructions = const [],
    this.safetyTips = const [],
    this.commonMistakes = const [],
    this.overview,
    this.imageUrls = const [],
    this.gifUrl,
    this.videoUrl,
    this.variations = const [],
    this.relatedExerciseIds = const [],
    this.progressionPath = const [],
    this.isFavorite = false,
    this.isEnriched = false,
    this.nameHi,
    this.nameMr,
    this.setType = 'Straight',
    this.restTime = 90,
    this.source = 'local',
    this.isCustom = false,
    this.lastUsed,
  });

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) {
    return ExerciseEntity(
      id: json['id'] as int? ?? 0,
      exerciseId: json['exerciseId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'strength',
      difficulty: json['difficulty'] as String? ?? 'beginner',
      primaryMuscles: List<String>.from(json['primaryMuscles'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'name': name,
      'category': category,
      'difficulty': difficulty,
      'primaryMuscles': primaryMuscles,
      'instructions': instructions,
      'imageUrls': imageUrls,
    };
  }

  String get primaryBodyPart => targetBodyParts.isNotEmpty ? targetBodyParts.first : category;

  String get difficultyColor {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return 'green';
      case 'intermediate':
        return 'orange';
      case 'expert':
        return 'red';
      default:
        return 'grey';
    }
  }

  // Manual copyWith for convenience since we removed Freezed
  ExerciseEntity copyWith({
    int? id,
    String? exerciseId,
    String? name,
    List<String>? alternateNames,
    String? category,
    String? difficulty,
    String? force,
    String? mechanic,
    String? equipment,
    List<String>? primaryMuscles,
    List<String>? secondaryMuscles,
    List<String>? targetBodyParts,
    List<String>? instructions,
    List<String>? safetyTips,
    List<String>? commonMistakes,
    String? overview,
    List<String>? imageUrls,
    String? gifUrl,
    String? videoUrl,
    List<String>? variations,
    List<String>? relatedExerciseIds,
    List<String>? progressionPath,
    bool? isFavorite,
    bool? isEnriched,
    String? nameHi,
    String? nameMr,
    String? setType,
    int? restTime,
    String? source,
    bool? isCustom,
    DateTime? lastUsed,
  }) {
    return ExerciseEntity(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      alternateNames: alternateNames ?? this.alternateNames,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      force: force ?? this.force,
      mechanic: mechanic ?? this.mechanic,
      equipment: equipment ?? this.equipment,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      targetBodyParts: targetBodyParts ?? this.targetBodyParts,
      instructions: instructions ?? this.instructions,
      safetyTips: safetyTips ?? this.safetyTips,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      overview: overview ?? this.overview,
      imageUrls: imageUrls ?? this.imageUrls,
      gifUrl: gifUrl ?? this.gifUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      variations: variations ?? this.variations,
      relatedExerciseIds: relatedExerciseIds ?? this.relatedExerciseIds,
      progressionPath: progressionPath ?? this.progressionPath,
      isFavorite: isFavorite ?? this.isFavorite,
      isEnriched: isEnriched ?? this.isEnriched,
      nameHi: nameHi ?? this.nameHi,
      nameMr: nameMr ?? this.nameMr,
      setType: setType ?? this.setType,
      restTime: restTime ?? this.restTime,
      source: source ?? this.source,
      isCustom: isCustom ?? this.isCustom,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }
}
