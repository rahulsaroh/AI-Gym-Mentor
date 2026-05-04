import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_photo.freezed.dart';
part 'progress_photo.g.dart';

@freezed
abstract class ProgressPhoto with _$ProgressPhoto {
  const ProgressPhoto._();

  const factory ProgressPhoto({
    required int id,
    required DateTime date,
    required String imagePath,
    @Default('front') String category,
    String? notes,
  }) = _ProgressPhoto;

  factory ProgressPhoto.fromJson(Map<String, dynamic> json) => _$ProgressPhotoFromJson(json);
}
