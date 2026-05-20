import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_service_model.freezed.dart';
part 'salon_service_model.g.dart';

/// Data model for [SalonService] with JSON serialization.
@freezed
abstract class SalonServiceModel with _$SalonServiceModel {
  const SalonServiceModel._();

  const factory SalonServiceModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    required String name,
    required double price,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? category,
    String? tier,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'is_popular') @Default(false) bool isPopular,
  }) = _SalonServiceModel;

  factory SalonServiceModel.fromJson(Map<String, dynamic> json) =>
      _$SalonServiceModelFromJson(json);

  SalonService toEntity() => SalonService(
        id: id,
        salonId: salonId,
        name: name,
        price: price,
        durationMinutes: durationMinutes,
        description: description,
        imageUrl: imageUrl,
        category: category,
        tier: tier,
        isActive: isActive,
        isPopular: isPopular,
      );
}
