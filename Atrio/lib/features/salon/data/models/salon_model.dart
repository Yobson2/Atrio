import 'package:flutter_templates/features/salon/data/models/opening_hours_model.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_model.freezed.dart';
part 'salon_model.g.dart';

/// Data model for [Salon] with JSON serialization.
@freezed
abstract class SalonModel with _$SalonModel {
  const SalonModel._();

  const factory SalonModel({
    required String id,
    required String name,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required String phone,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    @JsonKey(name: 'photo_urls') @Default([]) List<String> photoUrls,
    @Default(0.0) double rating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @JsonKey(name: 'is_open') @Default(false) bool isOpen,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'opening_hours')
    @Default([])
    List<OpeningHoursModel> openingHours,
  }) = _SalonModel;

  /// Creates a [SalonModel] from JSON.
  factory SalonModel.fromJson(Map<String, dynamic> json) =>
      _$SalonModelFromJson(json);

  /// Converts to a domain [Salon] entity.
  Salon toEntity() => Salon(
        id: id,
        name: name,
        description: description,
        address: address,
        latitude: latitude,
        longitude: longitude,
        phone: phone,
        coverImageUrl: coverImageUrl,
        photoUrls: photoUrls,
        rating: rating,
        reviewCount: reviewCount,
        isOpen: isOpen,
        ownerId: ownerId,
        openingHours: openingHours.map((h) => h.toEntity()).toList(),
      );

  /// Creates from a domain [Salon] entity.
  static SalonModel fromEntity(Salon entity) => SalonModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        address: entity.address,
        latitude: entity.latitude,
        longitude: entity.longitude,
        phone: entity.phone,
        coverImageUrl: entity.coverImageUrl,
        photoUrls: entity.photoUrls,
        rating: entity.rating,
        reviewCount: entity.reviewCount,
        isOpen: entity.isOpen,
        ownerId: entity.ownerId,
        openingHours:
            entity.openingHours.map(OpeningHoursModel.fromEntity).toList(),
      );
}
