import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
abstract class Exercise with _$Exercise {
  const Exercise._();

  const factory Exercise({
    required int id,
    required String name,
    String? description,
    @Default('Strength') String category,
    @Default('Beginner') String difficulty,
    @Default('') String primaryMuscle,
    String? secondaryMuscle,
    @Default('Barbell') String equipment,
    @Default('Straight') String setType,
    @Default(90) int restTime,
    List<String>? instructions,
    String? gifUrl,
    String? imageUrl,
    String? videoUrl,
    String? mechanic,
    String? force,
    @Default('local') String source,
    @Default(false) bool isCustom,
    DateTime? lastUsed,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}
