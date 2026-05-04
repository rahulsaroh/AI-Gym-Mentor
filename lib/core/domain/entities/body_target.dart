import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_target.freezed.dart';
part 'body_target.g.dart';

@freezed
abstract class BodyTarget with _$BodyTarget {
  const BodyTarget._();

  const factory BodyTarget({
    required int id,
    required String metric,
    required double targetValue,
    DateTime? deadline,
    required DateTime createdAt,
  }) = _BodyTarget;

  factory BodyTarget.fromJson(Map<String, dynamic> json) => _$BodyTargetFromJson(json);
}
