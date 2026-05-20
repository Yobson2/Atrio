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
    required double rating,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @Default([]) List<String> specialties,
    String? tier,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'next_available_at') DateTime? nextAvailableAt,
  }) = _BarberModel;

  factory BarberModel.fromJson(Map<String, dynamic> json) =>
      _$BarberModelFromJson(json);

  Barber toEntity() => Barber(
        id: id,
        salonId: salonId,
        name: name,
        rating: rating,
        photoUrl: photoUrl,
        reviewCount: reviewCount,
        specialties: specialties,
        tier: tier,
        isAvailable: isAvailable,
        nextAvailableAt: nextAvailableAt,
      );
}
