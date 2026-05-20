import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

/// Data model for [Review] with JSON serialization.
@freezed
abstract class ReviewModel with _$ReviewModel {
  const ReviewModel._();

  const factory ReviewModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    @JsonKey(name: 'client_name') required String clientName,
    required double rating,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'client_photo_url') String? clientPhotoUrl,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Review toEntity() => Review(
        id: id,
        salonId: salonId,
        clientName: clientName,
        rating: rating,
        comment: comment,
        createdAt: createdAt,
        clientPhotoUrl: clientPhotoUrl,
      );
}
