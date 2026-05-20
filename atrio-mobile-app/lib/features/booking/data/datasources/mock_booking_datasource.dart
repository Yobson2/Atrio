// coverage:ignore-file

import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Mock implementation of [BookingRepository] with sample data.
class MockBookingRepository implements BookingRepository {
  static const _delay = Duration(milliseconds: 600);

  final List<Booking> _bookings = [
    Booking(
      id: 'bk-001',
      salonId: 'salon-001',
      salonName: 'Precision Grooming Co.',
      serviceId: 'svc-001',
      serviceName: 'Signature Beard Sculpt',
      clientId: 'mock-user-001',
      date: DateTime.now().add(const Duration(days: 2)),
      startTime: '10:30 AM',
      totalPrice: 45.00,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      barberId: 'barber-001',
      barberName: 'Marco "The Edge" Rossi',
      salonAddress: 'The Global Buzz • Downtown HQ',
      serviceDuration: 45,
    ),
    Booking(
      id: 'bk-002',
      salonId: 'salon-002',
      salonName: 'The Heritage Barbers',
      serviceId: 'svc-005',
      serviceName: 'Executive Skin Fade',
      clientId: 'mock-user-001',
      date: DateTime.now().add(const Duration(days: 5)),
      startTime: '2:00 PM',
      totalPrice: 70.00,
      status: BookingStatus.pending,
      createdAt: DateTime.now(),
      barberName: 'Alex Precision',
      serviceDuration: 60,
    ),
    Booking(
      id: 'bk-003',
      salonId: 'salon-001',
      salonName: 'Precision Grooming Co.',
      serviceId: 'svc-003',
      serviceName: 'Luxury Hot Towel Shave',
      clientId: 'mock-user-001',
      date: DateTime.now().subtract(const Duration(days: 10)),
      startTime: '11:00 AM',
      totalPrice: 85.00,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      barberId: 'barber-002',
      barberName: 'Marcus T.',
      serviceDuration: 75,
    ),
  ];

  @override
  Future<Either<Failure, List<TimeSlot>>> getAvailableSlots({
    required String salonId,
    required DateTime date,
    String? barberId,
  }) async {
    await Future<void>.delayed(_delay);
    return Right([
      const TimeSlot(startTime: '9:00 AM', endTime: '9:45 AM'),
      const TimeSlot(startTime: '9:30 AM', endTime: '10:15 AM'),
      const TimeSlot(startTime: '10:00 AM', endTime: '10:45 AM'),
      const TimeSlot(startTime: '11:00 AM', endTime: '11:45 AM'),
      const TimeSlot(
        startTime: '1:00 PM',
        endTime: '1:45 PM',
        isAvailable: false,
      ),
      const TimeSlot(startTime: '12:30 PM', endTime: '1:15 PM'),
      const TimeSlot(startTime: '2:30 PM', endTime: '3:15 PM'),
      const TimeSlot(startTime: '4:00 PM', endTime: '4:45 PM'),
    ]);
  }

  @override
  Future<Either<Failure, Booking>> createBooking({
    required String salonId,
    required String serviceId,
    required String barberId,
    required DateTime date,
    required String startTime,
    String? notes,
  }) async {
    await Future<void>.delayed(_delay);
    final booking = Booking(
      id: 'bk-${DateTime.now().millisecondsSinceEpoch}',
      salonId: salonId,
      salonName: 'Precision Cuts Studio',
      serviceId: serviceId,
      serviceName: 'Signature Scissor Cut',
      clientId: 'mock-user-001',
      date: date,
      startTime: startTime,
      totalPrice: 65.00,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now(),
      barberId: barberId,
      barberName: 'Alex Precision',
      notes: notes,
      serviceDuration: 45,
    );
    _bookings.insert(0, booking);
    return Right(booking);
  }

  @override
  Future<Either<Failure, List<Booking>>> getMyBookings() async {
    await Future<void>.delayed(_delay);
    return Right(List.unmodifiable(_bookings));
  }

  @override
  Future<Either<Failure, Booking>> getBookingById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final booking = _bookings.where((b) => b.id == id).firstOrNull;
    if (booking == null) {
      return const Left(ServerFailure(message: 'Booking not found'));
    }
    return Right(booking);
  }

  @override
  Future<Either<Failure, void>> cancelBooking(String id) async {
    await Future<void>.delayed(_delay);
    final index = _bookings.indexWhere((b) => b.id == id);
    if (index == -1) {
      return const Left(ServerFailure(message: 'Booking not found'));
    }
    final old = _bookings[index];
    _bookings[index] = Booking(
      id: old.id,
      salonId: old.salonId,
      salonName: old.salonName,
      serviceId: old.serviceId,
      serviceName: old.serviceName,
      clientId: old.clientId,
      date: old.date,
      startTime: old.startTime,
      totalPrice: old.totalPrice,
      status: BookingStatus.cancelled,
      createdAt: old.createdAt,
      barberId: old.barberId,
      barberName: old.barberName,
    );
    return const Right(null);
  }
}
