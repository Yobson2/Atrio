// coverage:ignore-file

import 'package:flutter_templates/features/booking/data/models/booking_model.dart';
import 'package:flutter_templates/features/owner/data/datasources/owner_remote_datasource.dart';
import 'package:flutter_templates/features/owner/data/models/salon_stats_model.dart';
import 'package:flutter_templates/features/salon/data/models/barber_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_service_model.dart';

/// Mock implementation of [OwnerRemoteDataSource] for local testing.
///
/// Returns realistic fake owner data with simulated delays.
///
/// Set `USE_MOCK_OWNER=true` in `.env` to use this implementation.
class MockOwnerRemoteDataSource implements OwnerRemoteDataSource {
  static const _delay = Duration(milliseconds: 800);

  SalonModel _salon = const SalonModel(
    id: 'salon-001',
    name: 'Elite Cuts Barbershop',
    description:
        'Premium barbershop offering classic and modern cuts in a relaxed '
        'atmosphere. Walk-ins welcome.',
    address: '123 Main Street, Downtown',
    latitude: 48.8566,
    longitude: 2.3522,
    phone: '+1 555-0101',
    coverImageUrl: 'https://picsum.photos/seed/salon1/800/400',
    photoUrls: [
      'https://picsum.photos/seed/salon1a/400/300',
      'https://picsum.photos/seed/salon1b/400/300',
    ],
    rating: 4.7,
    reviewCount: 128,
    isOpen: true,
    ownerId: 'mock-user-001',
  );

  final List<SalonServiceModel> _services = [
    const SalonServiceModel(
      id: 'svc-001',
      salonId: 'salon-001',
      name: 'Classic Haircut',
      description: 'Traditional scissor cut with hot towel finish.',
      price: 25.0,
      durationMinutes: 30,
    ),
    const SalonServiceModel(
      id: 'svc-002',
      salonId: 'salon-001',
      name: 'Beard Trim',
      description: 'Shape and trim with straight razor outline.',
      price: 15.0,
      durationMinutes: 20,
    ),
    const SalonServiceModel(
      id: 'svc-003',
      salonId: 'salon-001',
      name: 'Haircut + Beard Combo',
      description: 'Full haircut with beard trim and hot towel.',
      price: 35.0,
      durationMinutes: 45,
    ),
    const SalonServiceModel(
      id: 'svc-004',
      salonId: 'salon-001',
      name: 'Kids Haircut',
      description: 'Haircut for children under 12.',
      price: 18.0,
      durationMinutes: 20,
    ),
  ];

  final List<BarberModel> _barbers = [
    const BarberModel(
      id: 'barber-001',
      salonId: 'salon-001',
      name: 'James Wilson',
      avatarUrl: 'https://i.pravatar.cc/150?u=barber1',
      rating: 4.8,
      serviceIds: ['svc-001', 'svc-002', 'svc-003'],
    ),
    const BarberModel(
      id: 'barber-002',
      salonId: 'salon-001',
      name: 'Marcus Brown',
      avatarUrl: 'https://i.pravatar.cc/150?u=barber2',
      rating: 4.6,
      serviceIds: ['svc-001', 'svc-003', 'svc-004'],
    ),
  ];

  int _serviceCounter = 100;
  int _barberCounter = 100;

  @override
  Future<SalonModel> getMySalon() async {
    await Future<void>.delayed(_delay);
    return _salon;
  }

  @override
  Future<SalonModel> updateSalon(SalonModel salon) async {
    await Future<void>.delayed(_delay);
    _salon = salon;
    return _salon;
  }

  @override
  Future<SalonServiceModel> createService(SalonServiceModel service) async {
    await Future<void>.delayed(_delay);
    _serviceCounter++;
    final created = SalonServiceModel(
      id: 'svc-$_serviceCounter',
      salonId: 'salon-001',
      name: service.name,
      description: service.description,
      price: service.price,
      durationMinutes: service.durationMinutes,
      imageUrl: service.imageUrl,
      isActive: service.isActive,
    );
    _services.add(created);
    return created;
  }

  @override
  Future<SalonServiceModel> updateService(SalonServiceModel service) async {
    await Future<void>.delayed(_delay);
    final index = _services.indexWhere((s) => s.id == service.id);
    if (index != -1) {
      _services[index] = service;
    }
    return service;
  }

  @override
  Future<void> deleteService(String serviceId) async {
    await Future<void>.delayed(_delay);
    _services.removeWhere((s) => s.id == serviceId);
  }

  @override
  Future<BarberModel> addBarber(BarberModel barber) async {
    await Future<void>.delayed(_delay);
    _barberCounter++;
    final created = BarberModel(
      id: 'barber-$_barberCounter',
      salonId: 'salon-001',
      name: barber.name,
      avatarUrl: barber.avatarUrl,
      rating: barber.rating,
      isAvailable: barber.isAvailable,
      serviceIds: barber.serviceIds,
    );
    _barbers.add(created);
    return created;
  }

  @override
  Future<BarberModel> updateBarber(BarberModel barber) async {
    await Future<void>.delayed(_delay);
    final index = _barbers.indexWhere((b) => b.id == barber.id);
    if (index != -1) {
      _barbers[index] = barber;
    }
    return barber;
  }

  @override
  Future<void> removeBarber(String barberId) async {
    await Future<void>.delayed(_delay);
    _barbers.removeWhere((b) => b.id == barberId);
  }

  @override
  Future<SalonStatsModel> getStats({DateTime? from, DateTime? to}) async {
    await Future<void>.delayed(_delay);
    return const SalonStatsModel(
      todayBookings: 12,
      todayCompleted: 8,
      todayRevenue: 320.0,
      weekBookings: 67,
      weekRevenue: 2150.0,
      averageRating: 4.7,
      totalReviews: 128,
      averageWaitMinutes: 18.5,
    );
  }

  @override
  Future<List<BookingModel>> getTodayBookings() async {
    await Future<void>.delayed(_delay);
    final now = DateTime.now();
    return [
      BookingModel(
        id: 'bk-001',
        salonId: 'salon-001',
        salonName: 'Elite Cuts Barbershop',
        userId: 'user-101',
        serviceId: 'svc-001',
        serviceName: 'Classic Haircut',
        barberId: 'barber-001',
        barberName: 'James Wilson',
        type: 'reservation',
        status: 'confirmed',
        scheduledAt: now.copyWith(hour: 10),
        estimatedDurationMinutes: 30,
        price: 25.0,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      BookingModel(
        id: 'bk-002',
        salonId: 'salon-001',
        salonName: 'Elite Cuts Barbershop',
        userId: 'user-102',
        serviceId: 'svc-003',
        serviceName: 'Haircut + Beard Combo',
        barberId: 'barber-002',
        barberName: 'Marcus Brown',
        type: 'reservation',
        status: 'pending',
        scheduledAt: now.copyWith(hour: 11),
        estimatedDurationMinutes: 45,
        price: 35.0,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(hours: 5)),
      ),
      BookingModel(
        id: 'bk-003',
        salonId: 'salon-001',
        salonName: 'Elite Cuts Barbershop',
        userId: 'user-103',
        serviceId: 'svc-002',
        serviceName: 'Beard Trim',
        type: 'walkIn',
        status: 'inProgress',
        estimatedDurationMinutes: 20,
        price: 15.0,
        createdAt: now.subtract(const Duration(minutes: 30)),
        updatedAt: now.subtract(const Duration(minutes: 10)),
      ),
      BookingModel(
        id: 'bk-004',
        salonId: 'salon-001',
        salonName: 'Elite Cuts Barbershop',
        userId: 'user-104',
        serviceId: 'svc-001',
        serviceName: 'Classic Haircut',
        barberId: 'barber-001',
        barberName: 'James Wilson',
        type: 'reservation',
        status: 'completed',
        scheduledAt: now.copyWith(hour: 9),
        estimatedDurationMinutes: 30,
        price: 25.0,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
      BookingModel(
        id: 'bk-005',
        salonId: 'salon-001',
        salonName: 'Elite Cuts Barbershop',
        userId: 'user-105',
        serviceId: 'svc-004',
        serviceName: 'Kids Haircut',
        barberId: 'barber-002',
        barberName: 'Marcus Brown',
        type: 'walkIn',
        status: 'pending',
        estimatedDurationMinutes: 20,
        price: 18.0,
        createdAt: now.subtract(const Duration(minutes: 15)),
        updatedAt: now.subtract(const Duration(minutes: 15)),
      ),
    ];
  }

  @override
  Future<void> advanceQueue(String salonId) async {
    await Future<void>.delayed(_delay);
  }

  @override
  Future<void> skipQueueEntry(String entryId) async {
    await Future<void>.delayed(_delay);
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    await Future<void>.delayed(_delay);
  }
}
