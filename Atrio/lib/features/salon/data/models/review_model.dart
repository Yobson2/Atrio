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
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    required double rating,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ReviewModel;

  /// Creates a [ReviewModel] from JSON.
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  /// Converts to a domain [Review] entity.
  Review toEntity() => Review(
        id: id,
        salonId: salonId,
        userId: userId,
        userName: userName,
        rating: rating,
        comment: comment,
        createdAt: createdAt,
      );

  /// Creates from a domain [Review] entity.
  static ReviewModel fromEntity(Review entity) => ReviewModel(
        id: entity.id,
        salonId: entity.salonId,
        userId: entity.userId,
        userName: entity.userName,
        rating: entity.rating,
        comment: entity.comment,
        createdAt: entity.createdAt,
      );
}
