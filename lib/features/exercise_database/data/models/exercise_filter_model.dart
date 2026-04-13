import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_filter_model.freezed.dart';

@freezed
abstract class ExerciseFilter with _$ExerciseFilter {
  const ExerciseFilter._();

  const factory ExerciseFilter({
    @Default(null) String? bodyPart,
    @Default(null) String? category,
    @Default(null) String? equipment,
    @Default(null) String? difficulty,
    @Default(null) String? searchQuery,
    @Default(false) bool favoritesOnly,
  }) = _ExerciseFilter;

  bool get isActive =>
    bodyPart != null || category != null || equipment != null ||
    difficulty != null || (searchQuery?.isNotEmpty ?? false) || favoritesOnly;
}
