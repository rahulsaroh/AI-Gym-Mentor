import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_progress.freezed.dart';
part 'program_progress.g.dart';

@freezed
abstract class UserProgramProgressEntity with _$UserProgramProgressEntity {
  const UserProgramProgressEntity._();

  const factory UserProgramProgressEntity({
    required int id,
    required int mesocycleId,
    required DateTime startDate,
    @Default(0) int currentPhaseIndex,
    @Default(false) bool isCompleted,
    DateTime? lastPhaseAlertAt,
  }) = _UserProgramProgressEntity;

  factory UserProgramProgressEntity.fromJson(Map<String, dynamic> json) =>
      _$UserProgramProgressEntityFromJson(json);
}
