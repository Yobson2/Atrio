import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barber_model.freezed.dart';
part 'barber_model.g.dart';

/// Data model for [Barber] with JSON serialization.
@freezed
abstract class BarberModel with _$BarberModel {
  const BarberModel._();

  const factory BarberModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @Default(0.0) double rating,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'service_ids') @Default([]) List<String> serviceIds,
  }) = _BarberModel;

  /// Creates a [BarberModel] from JSON.
  factory BarberModel.fromJson(Map<String, dynamic> json) =>
      _$BarberModelFromJson(json);

  /// Converts to a domain [Barber] entity.
  Barber toEntity() => Barber(
        id: id,
        salonId: salonId,
        name: name,
        avatarUrl: avatarUrl,
        rating: rating,
        isAvailable: isAvailable,
        serviceIds: serviceIds,
      );

  /// Creates from a domain [Barber] entity.
  static BarberModel fromEntity(Barber entity) => BarberModel(
        id: entity.id,
        salonId: entity.salonId,
        name: entity.name,
        avatarUrl: entity.avatarUrl,
        rating: entity.rating,
        isAvailable: entity.isAvailable,
        serviceIds: entity.serviceIds,
      );
}
