
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
  final int usageCount;

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
    this.usageCount = 0,
  });

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) {
    return ExerciseEntity(
      id: json['id'] as int? ?? 0,
      exerciseId: json['exerciseId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      alternateNames: List<String>.from(json['alternateNames'] ?? []),
      category: json['category'] as String? ?? 'strength',
      difficulty: json['difficulty'] as String? ?? 'beginner',
      force: json['force'] as String?,
      mechanic: json['mechanic'] as String?,
      equipment: json['equipment'] as String?,
      primaryMuscles: List<String>.from(json['primaryMuscles'] ?? []),
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
      targetBodyParts: List<String>.from(json['targetBodyParts'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      safetyTips: List<String>.from(json['safetyTips'] ?? []),
      commonMistakes: List<String>.from(json['commonMistakes'] ?? []),
      overview: json['overview'] as String?,
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      gifUrl: json['gifUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      variations: List<String>.from(json['variations'] ?? []),
      relatedExerciseIds: List<String>.from(json['relatedExerciseIds'] ?? []),
      progressionPath: List<String>.from(json['progressionPath'] ?? []),
      isFavorite: json['isFavorite'] as bool? ?? false,
      isEnriched: json['isEnriched'] as bool? ?? false,
      nameHi: json['nameHi'] as String?,
      nameMr: json['nameMr'] as String?,
      setType: json['setType'] as String? ?? 'Straight',
      restTime: json['restTime'] as int? ?? 90,
      source: json['source'] as String? ?? 'local',
      isCustom: json['isCustom'] as bool? ?? false,
      lastUsed: json['lastUsed'] != null ? DateTime.parse(json['lastUsed'] as String) : null,
      usageCount: json['usageCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'name': name,
      'alternateNames': alternateNames,
      'category': category,
      'difficulty': difficulty,
      'force': force,
      'mechanic': mechanic,
      'equipment': equipment,
      'primaryMuscles': primaryMuscles,
      'secondaryMuscles': secondaryMuscles,
      'targetBodyParts': targetBodyParts,
      'instructions': instructions,
      'safetyTips': safetyTips,
      'commonMistakes': commonMistakes,
      'overview': overview,
      'imageUrls': imageUrls,
      'gifUrl': gifUrl,
      'videoUrl': videoUrl,
      'variations': variations,
      'relatedExerciseIds': relatedExerciseIds,
      'progressionPath': progressionPath,
      'isFavorite': isFavorite,
      'isEnriched': isEnriched,
      'nameHi': nameHi,
      'nameMr': nameMr,
      'setType': setType,
      'restTime': restTime,
      'source': source,
      'isCustom': isCustom,
      'lastUsed': lastUsed?.toIso8601String(),
      'usageCount': usageCount,
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
    int? usageCount,
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
      usageCount: usageCount ?? this.usageCount,
    );
  }
}
