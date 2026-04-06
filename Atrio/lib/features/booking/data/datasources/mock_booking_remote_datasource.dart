// coverage:ignore-file

import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:flutter_templates/features/booking/data/models/booking_model.dart';
import 'package:flutter_templates/features/booking/data/models/time_slot_model.dart';

/// Mock implementation of [BookingRemoteDataSource] for local testing.
///
/// Remove this file and set `USE_MOCK_BOOKING=false` in `.env` to switch
/// to the real API.
class MockBookingRemoteDataSource implements BookingRemoteDataSource {
  static const _delay = Duration(milliseconds: 800);

  final List<BookingModel> _bookings = [];

  int _idCounter = 1;

  @override
  Future<List<TimeSlotModel>> getAvailableSlots({
    required String salonId,
    required String serviceId,
    required DateTime date,
    String? barberId,
  }) async {
    await Future<void>.delayed(_delay);

    final baseDate = DateTime(date.year, date.month, date.day);
    return List.generate(8, (index) {
      final hour = 9 + index; // 9:00 AM to 4:00 PM
      return TimeSlotModel(
        startTime: baseDate.add(Duration(hours: hour)),
        endTime: baseDate.add(Duration(hours: hour, minutes: 30)),
        isAvailable: index != 2 && index != 5, // Slots 2 and 5 unavailable
      );
    });
  }

  @override
  Future<BookingModel> createBooking({
    required String salonId,
    required String serviceId,
    required String type,
    String? barberId,
    DateTime? scheduledAt,
  }) async {
    await Future<void>.delayed(_delay);

    final now = DateTime.now();
    final booking = BookingModel(
      id: 'mock-booking-${_idCounter++}',
      salonId: salonId,
      salonName: 'Elite Barber Shop',
      userId: 'mock-user-001',
      serviceId: serviceId,
      serviceName: _mockServiceName(serviceId),
      barberId: barberId,
      barberName: barberId != null ? _mockBarberName(barberId) : null,
      type: type,
      status: type == 'walkIn' ? 'confirmed' : 'pending',
      scheduledAt: scheduledAt,
      estimatedDurationMinutes: 30,
      price: _mockServicePrice(serviceId),
      createdAt: now,
      updatedAt: now,
    );
    _bookings.add(booking);
    return booking;
  }

  @override
  Future<BookingModel> cancelBooking(String bookingId) async {
    await Future<void>.delayed(_delay);

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) {
      throw const ServerException(message: 'Booking not found');
    }

    final existing = _bookings[index];
    final cancelled = BookingModel(
      id: existing.id,
      salonId: existing.salonId,
      salonName: existing.salonName,
      userId: existing.userId,
      serviceId: existing.serviceId,
      serviceName: existing.serviceName,
      barberId: existing.barberId,
      barberName: existing.barberName,
      type: existing.type,
      status: 'cancelled',
      scheduledAt: existing.scheduledAt,
      estimatedDurationMinutes: existing.estimatedDurationMinutes,
      price: existing.price,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
    );
    _bookings[index] = cancelled;
    return cancelled;
  }

  @override
  Future<List<BookingModel>> getMyBookings() async {
    await Future<void>.delayed(_delay);

    // Return existing bookings plus some seed data if empty.
    if (_bookings.isEmpty) {
      _seedBookings();
    }
    return List.unmodifiable(_bookings);
  }

  @override
  Future<BookingModel> getBookingById(String id) async {
    await Future<void>.delayed(_delay);

    if (_bookings.isEmpty) {
      _seedBookings();
    }

    final booking = _bookings.where((b) => b.id == id).firstOrNull;
    if (booking == null) {
      throw const ServerException(message: 'Booking not found');
    }
    return booking;
  }

  void _seedBookings() {
    final now = DateTime.now();
    _bookings.addAll([
      BookingModel(
        id: 'mock-booking-seed-1',
        salonId: 'salon-001',
        salonName: 'Elite Barber Shop',
        userId: 'mock-user-001',
        serviceId: 'service-001',
        serviceName: 'Classic Haircut',
        barberId: 'barber-001',
        barberName: 'James Wilson',
        type: 'reservation',
        status: 'confirmed',
        scheduledAt: now.add(const Duration(days: 2, hours: 3)),
        estimatedDurationMinutes: 30,
        price: 35.0,
        createdAt: now.subtract(const Duration(hours: 6)),
        updatedAt: now.subtract(const Duration(hours: 6)),
      ),
      BookingModel(
        id: 'mock-booking-seed-2',
        salonId: 'salon-001',
        salonName: 'Elite Barber Shop',
        userId: 'mock-user-001',
        serviceId: 'service-003',
        serviceName: 'Beard Trim',
        type: 'walkIn',
        status: 'completed',
        estimatedDurationMinutes: 15,
        price: 15.0,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
      BookingModel(
        id: 'mock-booking-seed-3',
        salonId: 'salon-002',
        salonName: 'Downtown Cuts',
        userId: 'mock-user-001',
        serviceId: 'service-002',
        serviceName: 'Hair + Beard Combo',
        barberId: 'barber-002',
        barberName: 'Carlos Rivera',
        type: 'reservation',
        status: 'pending',
        scheduledAt: now.add(const Duration(days: 5, hours: 1)),
        estimatedDurationMinutes: 45,
        price: 50.0,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
    ]);
  }

  String _mockServiceName(String serviceId) {
    switch (serviceId) {
      case 'service-001':
        return 'Classic Haircut';
      case 'service-002':
        return 'Hair + Beard Combo';
      case 'service-003':
        return 'Beard Trim';
      default:
        return 'Standard Service';
    }
  }

  double _mockServicePrice(String serviceId) {
    switch (serviceId) {
      case 'service-001':
        return 35.0;
      case 'service-002':
        return 50.0;
      case 'service-003':
        return 15.0;
      default:
        return 25.0;
    }
  }

  String _mockBarberName(String barberId) {
    switch (barberId) {
      case 'barber-001':
        return 'James Wilson';
      case 'barber-002':
        return 'Carlos Rivera';
      case 'barber-003':
        return 'David Kim';
      default:
        return 'Any Available';
    }
  }
}
