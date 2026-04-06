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
    String? description,
    required double price,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _SalonServiceModel;

  /// Creates a [SalonServiceModel] from JSON.
  factory SalonServiceModel.fromJson(Map<String, dynamic> json) =>
      _$SalonServiceModelFromJson(json);

  /// Converts to a domain [SalonService] entity.
  SalonService toEntity() => SalonService(
        id: id,
        salonId: salonId,
        name: name,
        description: description,
        price: price,
        durationMinutes: durationMinutes,
        imageUrl: imageUrl,
        isActive: isActive,
      );

  /// Creates from a domain [SalonService] entity.
  static SalonServiceModel fromEntity(SalonService entity) => SalonServiceModel(
        id: entity.id,
        salonId: entity.salonId,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        durationMinutes: entity.durationMinutes,
        imageUrl: entity.imageUrl,
        isActive: entity.isActive,
      );
}
