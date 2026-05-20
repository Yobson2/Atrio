import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

/// Data model for [Booking] with JSON serialization.
@freezed
abstract class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    @JsonKey(name: 'salon_name') required String salonName,
    @JsonKey(name: 'service_id') required String serviceId,
    @JsonKey(name: 'service_name') required String serviceName,
    @JsonKey(name: 'client_id') required String clientId,
    required DateTime date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'total_price') required double totalPrice,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'barber_id') String? barberId,
    @JsonKey(name: 'barber_name') String? barberName,
    @JsonKey(name: 'end_time') String? endTime,
    String? notes,
    @JsonKey(name: 'salon_address') String? salonAddress,
    @JsonKey(name: 'service_duration') int? serviceDuration,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Booking toEntity() => Booking(
        id: id,
        salonId: salonId,
        salonName: salonName,
        serviceId: serviceId,
        serviceName: serviceName,
        clientId: clientId,
        date: date,
        startTime: startTime,
        totalPrice: totalPrice,
        status: BookingStatus.values.firstWhere(
          (s) => s.name == status,
          orElse: () => BookingStatus.pending,
        ),
        createdAt: createdAt,
        barberId: barberId,
        barberName: barberName,
        endTime: endTime,
        notes: notes,
        salonAddress: salonAddress,
        serviceDuration: serviceDuration,
      );
}
