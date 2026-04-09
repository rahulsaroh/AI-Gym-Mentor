import 'package:freezed_annotation/freezed_annotation.dart';

part 'logged_set.freezed.dart';
part 'logged_set.g.dart';

enum SetType {
  straight,
  warmup,
  superset,
  dropSet,
  amrap,
  timed,
  restPause,
  cluster
}

@freezed
class LoggedSet with _$LoggedSet {
  const factory LoggedSet({
    required int id,
    required int workoutId,
    required int exerciseId,
    required int exerciseOrder,
    required int setNumber,
    required double weight,
    required double reps,
    double? rpe,
    int? rir,
    @Default(SetType.straight) SetType setType,
    String? notes,
    @Default(false) bool completed,
    DateTime? completedAt,
    @Default(false) bool isPr,
    String? supersetGroupId,
  }) = _LoggedSet;

  factory LoggedSet.fromJson(Map<String, dynamic> json) => _$LoggedSetFromJson(json);
}
