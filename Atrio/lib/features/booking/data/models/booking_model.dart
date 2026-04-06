import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

/// Data model for [Booking] with JSON serialization.
///
/// Maps between API JSON responses and the domain [Booking] entity.
@freezed
abstract class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    @JsonKey(name: 'salon_name') required String salonName,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'service_id') required String serviceId,
    @JsonKey(name: 'service_name') required String serviceName,
    @JsonKey(name: 'barber_id') String? barberId,
    @JsonKey(name: 'barber_name') String? barberName,
    required String type,
    required String status,
    @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
    @JsonKey(name: 'estimated_duration_minutes')
    required int estimatedDurationMinutes,
    required double price,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _BookingModel;

  /// Creates a [BookingModel] from JSON.
  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  /// Converts this model to a domain [Booking] entity.
  Booking toEntity() => Booking(
        id: id,
        salonId: salonId,
        salonName: salonName,
        userId: userId,
        serviceId: serviceId,
        serviceName: serviceName,
        barberId: barberId,
        barberName: barberName,
        type: BookingType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => BookingType.reservation,
        ),
        status: BookingStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => BookingStatus.pending,
        ),
        scheduledAt: scheduledAt,
        estimatedDurationMinutes: estimatedDurationMinutes,
        price: price,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Creates a [BookingModel] from a domain [Booking] entity.
  factory BookingModel.fromEntity(Booking booking) => BookingModel(
        id: booking.id,
        salonId: booking.salonId,
        salonName: booking.salonName,
        userId: booking.userId,
        serviceId: booking.serviceId,
        serviceName: booking.serviceName,
        barberId: booking.barberId,
        barberName: booking.barberName,
        type: booking.type.name,
        status: booking.status.name,
        scheduledAt: booking.scheduledAt,
        estimatedDurationMinutes: booking.estimatedDurationMinutes,
        price: booking.price,
        createdAt: booking.createdAt,
        updatedAt: booking.updatedAt,
      );
}
