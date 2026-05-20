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
    required String address,
    required double rating,
    @JsonKey(name: 'review_count') required int reviewCount,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'gallery_urls') @Default([]) List<String> galleryUrls,
    String? phone,
    String? email,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @Default([]) List<String> tags,
    String? tier,
  }) = _SalonModel;

  factory SalonModel.fromJson(Map<String, dynamic> json) =>
      _$SalonModelFromJson(json);

  Salon toEntity() => Salon(
        id: id,
        name: name,
        address: address,
        rating: rating,
        reviewCount: reviewCount,
        description: description,
        imageUrl: imageUrl,
        galleryUrls: galleryUrls,
        phone: phone,
        email: email,
        latitude: latitude,
        longitude: longitude,
        isActive: isActive,
        tags: tags,
        tier: tier,
      );
}
