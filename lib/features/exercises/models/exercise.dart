class Exercise {
  final String id;
  final String name;
  final String description;
  final String category;         // e.g. Strength, Cardio, Stretching
  final String difficulty;       // Beginner, Intermediate, Advanced
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final String equipment;        // e.g. Barbell, Dumbbell, Bodyweight
  final List<String> instructions; // Step-by-step instructions
  final String? gifUrl;          // Animated GIF showing the exercise
  final String? imageUrl;        // Static image fallback
  final String? videoUrl;        // YouTube or video link (optional)
  final String mechanic;         // Compound or Isolation
  final String force;            // Push, Pull, Static
  final String source;           // Which repo/API it came from

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.equipment,
    required this.instructions,
    this.gifUrl,
    this.imageUrl,
    this.videoUrl,
    required this.mechanic,
    required this.force,
    required this.source,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Strength',
      difficulty: json['difficulty']?.toString() ?? 'Beginner',
      primaryMuscles: (json['primaryMuscles'] as List?)?.map((e) => e.toString()).toList() ?? [],
      secondaryMuscles: (json['secondaryMuscles'] as List?)?.map((e) => e.toString()).toList() ?? [],
      equipment: json['equipment']?.toString() ?? 'Bodyweight',
      instructions: (json['instructions'] as List?)?.map((e) => e.toString()).toList() ?? [],
      gifUrl: json['gifUrl']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      videoUrl: json['videoUrl']?.toString(),
      mechanic: json['mechanic']?.toString() ?? 'Compound',
      force: json['force']?.toString() ?? 'Push',
      source: json['source']?.toString() ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'primaryMuscles': primaryMuscles,
      'secondaryMuscles': secondaryMuscles,
      'equipment': equipment,
      'instructions': instructions,
      'gifUrl': gifUrl,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'mechanic': mechanic,
      'force': force,
      'source': source,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'primaryMuscles': primaryMuscles.join(','),
      'secondaryMuscles': secondaryMuscles.join(','),
      'equipment': equipment,
      'instructions': instructions.join('|'),
      'gifUrl': gifUrl,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'mechanic': mechanic,
      'force': force,
      'source': source,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? 'Strength',
      difficulty: map['difficulty']?.toString() ?? 'Beginner',
      primaryMuscles: (map['primaryMuscles']?.toString() ?? '').split(',').where((e) => e.isNotEmpty).toList(),
      secondaryMuscles: (map['secondaryMuscles']?.toString() ?? '').split(',').where((e) => e.isNotEmpty).toList(),
      equipment: map['equipment']?.toString() ?? 'Bodyweight',
      instructions: (map['instructions']?.toString() ?? '').split('|').where((e) => e.isNotEmpty).toList(),
      gifUrl: map['gifUrl']?.toString(),
      imageUrl: map['imageUrl']?.toString(),
      videoUrl: map['videoUrl']?.toString(),
      mechanic: map['mechanic']?.toString() ?? 'Compound',
      force: map['force']?.toString() ?? 'Push',
      source: map['source']?.toString() ?? 'Unknown',
    );
  }
}
