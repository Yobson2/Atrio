// coverage:ignore-file

import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/features/salon/data/datasources/salon_remote_datasource.dart';
import 'package:flutter_templates/features/salon/data/models/barber_model.dart';
import 'package:flutter_templates/features/salon/data/models/opening_hours_model.dart';
import 'package:flutter_templates/features/salon/data/models/review_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_service_model.dart';

/// Mock implementation of [SalonRemoteDataSource] for local testing.
///
/// Returns realistic fake salon data with an 800ms simulated delay.
///
/// Set `USE_MOCK_SALON=true` in `.env` to use this implementation.
class MockSalonRemoteDataSource implements SalonRemoteDataSource {
  static const _delay = Duration(milliseconds: 800);

  static const _defaultOpeningHours = [
    OpeningHoursModel(day: 'Monday', openTime: '09:00', closeTime: '19:00'),
    OpeningHoursModel(day: 'Tuesday', openTime: '09:00', closeTime: '19:00'),
    OpeningHoursModel(day: 'Wednesday', openTime: '09:00', closeTime: '19:00'),
    OpeningHoursModel(day: 'Thursday', openTime: '09:00', closeTime: '20:00'),
    OpeningHoursModel(day: 'Friday', openTime: '09:00', closeTime: '20:00'),
    OpeningHoursModel(day: 'Saturday', openTime: '10:00', closeTime: '18:00'),
    OpeningHoursModel(
      day: 'Sunday',
      openTime: '00:00',
      closeTime: '00:00',
      isClosed: true,
    ),
  ];

  static final List<SalonModel> _mockSalons = [
    const SalonModel(
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
        'https://picsum.photos/seed/salon1c/400/300',
      ],
      rating: 4.7,
      reviewCount: 128,
      isOpen: true,
      ownerId: 'owner-001',
      openingHours: _defaultOpeningHours,
    ),
    const SalonModel(
      id: 'salon-002',
      name: 'The Gentleman\'s Lounge',
      description:
          'A classic gentleman\'s grooming experience with hot towel shaves, '
          'beard trims, and premium hair care.',
      address: '456 Oak Avenue, Midtown',
      latitude: 48.8606,
      longitude: 2.3376,
      phone: '+1 555-0102',
      coverImageUrl: 'https://picsum.photos/seed/salon2/800/400',
      photoUrls: [
        'https://picsum.photos/seed/salon2a/400/300',
        'https://picsum.photos/seed/salon2b/400/300',
      ],
      rating: 4.9,
      reviewCount: 256,
      isOpen: true,
      ownerId: 'owner-002',
      openingHours: _defaultOpeningHours,
    ),
    const SalonModel(
      id: 'salon-003',
      name: 'Fresh Fades Studio',
      description: 'Specializing in fades, tapers, and urban styles. '
          'Book online for the best experience.',
      address: '789 Elm Street, Uptown',
      latitude: 48.8530,
      longitude: 2.3499,
      phone: '+1 555-0103',
      coverImageUrl: 'https://picsum.photos/seed/salon3/800/400',
      photoUrls: [
        'https://picsum.photos/seed/salon3a/400/300',
      ],
      rating: 4.5,
      reviewCount: 89,
      isOpen: false,
      ownerId: 'owner-003',
      openingHours: _defaultOpeningHours,
    ),
    const SalonModel(
      id: 'salon-004',
      name: 'Crown & Blade',
      description:
          'Where tradition meets modern styling. Full-service barbershop '
          'with premium grooming products.',
      address: '321 Pine Road, Westside',
      latitude: 48.8490,
      longitude: 2.3580,
      phone: '+1 555-0104',
      coverImageUrl: 'https://picsum.photos/seed/salon4/800/400',
      photoUrls: [
        'https://picsum.photos/seed/salon4a/400/300',
        'https://picsum.photos/seed/salon4b/400/300',
        'https://picsum.photos/seed/salon4c/400/300',
        'https://picsum.photos/seed/salon4d/400/300',
      ],
      rating: 4.3,
      reviewCount: 67,
      isOpen: true,
      ownerId: 'owner-004',
      openingHours: _defaultOpeningHours,
    ),
    const SalonModel(
      id: 'salon-005',
      name: 'Shear Excellence',
      description:
          'Award-winning salon with expert stylists dedicated to making '
          'you look and feel your best.',
      address: '654 Maple Drive, Eastside',
      latitude: 48.8620,
      longitude: 2.3450,
      phone: '+1 555-0105',
      coverImageUrl: 'https://picsum.photos/seed/salon5/800/400',
      photoUrls: [
        'https://picsum.photos/seed/salon5a/400/300',
        'https://picsum.photos/seed/salon5b/400/300',
      ],
      rating: 4.8,
      reviewCount: 192,
      isOpen: true,
      ownerId: 'owner-005',
      openingHours: _defaultOpeningHours,
    ),
    const SalonModel(
      id: 'salon-006',
      name: 'Urban Roots Barbers',
      description: 'Community-focused barbershop with a laid-back vibe. '
          'Great music, great cuts, great people.',
      address: '987 Cedar Lane, Southside',
      latitude: 48.8470,
      longitude: 2.3550,
      phone: '+1 555-0106',
      coverImageUrl: 'https://picsum.photos/seed/salon6/800/400',
      photoUrls: [],
      rating: 4.1,
      reviewCount: 43,
      isOpen: false,
      ownerId: 'owner-006',
      openingHours: _defaultOpeningHours,
    ),
  ];

  static final Map<String, List<SalonServiceModel>> _mockServices = {
    'salon-001': const [
      SalonServiceModel(
        id: 'svc-001',
        salonId: 'salon-001',
        name: 'Classic Haircut',
        description: 'Traditional scissor cut with hot towel finish.',
        price: 25.0,
        durationMinutes: 30,
      ),
      SalonServiceModel(
        id: 'svc-002',
        salonId: 'salon-001',
        name: 'Beard Trim',
        description: 'Shape and trim with straight razor outline.',
        price: 15.0,
        durationMinutes: 20,
      ),
      SalonServiceModel(
        id: 'svc-003',
        salonId: 'salon-001',
        name: 'Haircut + Beard Combo',
        description: 'Full haircut with beard trim and hot towel.',
        price: 35.0,
        durationMinutes: 45,
      ),
      SalonServiceModel(
        id: 'svc-004',
        salonId: 'salon-001',
        name: 'Kids Haircut',
        description: 'Haircut for children under 12.',
        price: 18.0,
        durationMinutes: 20,
      ),
    ],
    'salon-002': const [
      SalonServiceModel(
        id: 'svc-005',
        salonId: 'salon-002',
        name: 'Executive Cut',
        description: 'Premium haircut with consultation and styling.',
        price: 40.0,
        durationMinutes: 45,
      ),
      SalonServiceModel(
        id: 'svc-006',
        salonId: 'salon-002',
        name: 'Hot Towel Shave',
        description: 'Classic straight razor shave with hot towels.',
        price: 30.0,
        durationMinutes: 35,
      ),
      SalonServiceModel(
        id: 'svc-007',
        salonId: 'salon-002',
        name: 'Royal Treatment',
        description: 'Haircut, shave, facial, and scalp massage.',
        price: 75.0,
        durationMinutes: 90,
      ),
    ],
    'salon-003': const [
      SalonServiceModel(
        id: 'svc-008',
        salonId: 'salon-003',
        name: 'Skin Fade',
        description: 'Precision skin fade with design options.',
        price: 30.0,
        durationMinutes: 40,
      ),
      SalonServiceModel(
        id: 'svc-009',
        salonId: 'salon-003',
        name: 'Taper Fade',
        description: 'Clean taper fade with lineup.',
        price: 28.0,
        durationMinutes: 35,
      ),
    ],
    'salon-004': const [
      SalonServiceModel(
        id: 'svc-010',
        salonId: 'salon-004',
        name: 'Classic Cut',
        description: 'Traditional barbershop haircut.',
        price: 22.0,
        durationMinutes: 30,
      ),
      SalonServiceModel(
        id: 'svc-011',
        salonId: 'salon-004',
        name: 'Buzz Cut',
        description: 'Quick and clean buzz cut.',
        price: 15.0,
        durationMinutes: 15,
      ),
    ],
    'salon-005': const [
      SalonServiceModel(
        id: 'svc-012',
        salonId: 'salon-005',
        name: 'Signature Cut',
        description: 'Our signature haircut with premium products.',
        price: 45.0,
        durationMinutes: 50,
      ),
      SalonServiceModel(
        id: 'svc-013',
        salonId: 'salon-005',
        name: 'Color Treatment',
        description: 'Professional hair coloring service.',
        price: 60.0,
        durationMinutes: 75,
      ),
      SalonServiceModel(
        id: 'svc-014',
        salonId: 'salon-005',
        name: 'Hair & Beard Combo',
        description: 'Complete grooming package.',
        price: 55.0,
        durationMinutes: 60,
      ),
    ],
    'salon-006': const [
      SalonServiceModel(
        id: 'svc-015',
        salonId: 'salon-006',
        name: 'Community Cut',
        description: 'Quality haircut at an affordable price.',
        price: 18.0,
        durationMinutes: 25,
      ),
      SalonServiceModel(
        id: 'svc-016',
        salonId: 'salon-006',
        name: 'Line Up',
        description: 'Crisp edge-up and lineup.',
        price: 12.0,
        durationMinutes: 15,
      ),
    ],
  };

  static final Map<String, List<BarberModel>> _mockBarbers = {
    'salon-001': const [
      BarberModel(
        id: 'barber-001',
        salonId: 'salon-001',
        name: 'James Wilson',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber1',
        rating: 4.8,
        serviceIds: ['svc-001', 'svc-002', 'svc-003'],
      ),
      BarberModel(
        id: 'barber-002',
        salonId: 'salon-001',
        name: 'Marcus Brown',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber2',
        rating: 4.6,
        serviceIds: ['svc-001', 'svc-003', 'svc-004'],
      ),
    ],
    'salon-002': const [
      BarberModel(
        id: 'barber-003',
        salonId: 'salon-002',
        name: 'Alexander Reed',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber3',
        rating: 4.9,
        serviceIds: ['svc-005', 'svc-006', 'svc-007'],
      ),
      BarberModel(
        id: 'barber-004',
        salonId: 'salon-002',
        name: 'Daniel Park',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber4',
        rating: 4.7,
        serviceIds: ['svc-005', 'svc-006'],
      ),
      BarberModel(
        id: 'barber-005',
        salonId: 'salon-002',
        name: 'Michael Torres',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber5',
        rating: 4.8,
        serviceIds: ['svc-005', 'svc-007'],
      ),
    ],
    'salon-003': const [
      BarberModel(
        id: 'barber-006',
        salonId: 'salon-003',
        name: 'DeShawn Carter',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber6',
        rating: 4.7,
        serviceIds: ['svc-008', 'svc-009'],
      ),
    ],
    'salon-004': const [
      BarberModel(
        id: 'barber-007',
        salonId: 'salon-004',
        name: 'Robert Kim',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber7',
        rating: 4.4,
        serviceIds: ['svc-010', 'svc-011'],
      ),
      BarberModel(
        id: 'barber-008',
        salonId: 'salon-004',
        name: 'Anthony Lopez',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber8',
        rating: 4.2,
        serviceIds: ['svc-010'],
      ),
    ],
    'salon-005': const [
      BarberModel(
        id: 'barber-009',
        salonId: 'salon-005',
        name: 'Sophie Laurent',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber9',
        rating: 4.9,
        serviceIds: ['svc-012', 'svc-013', 'svc-014'],
      ),
      BarberModel(
        id: 'barber-010',
        salonId: 'salon-005',
        name: 'Chris Evans',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber10',
        rating: 4.7,
        serviceIds: ['svc-012', 'svc-014'],
      ),
    ],
    'salon-006': const [
      BarberModel(
        id: 'barber-011',
        salonId: 'salon-006',
        name: 'Jamal Washington',
        avatarUrl: 'https://i.pravatar.cc/150?u=barber11',
        rating: 4.3,
        serviceIds: ['svc-015', 'svc-016'],
      ),
    ],
  };

  static final Map<String, List<ReviewModel>> _mockReviews = {
    'salon-001': [
      ReviewModel(
        id: 'rev-001',
        salonId: 'salon-001',
        userId: 'user-001',
        userName: 'John D.',
        rating: 5.0,
        comment:
            'Best barbershop in town! James always knows exactly what I want.',
        createdAt: DateTime(2026, 3, 15),
      ),
      ReviewModel(
        id: 'rev-002',
        salonId: 'salon-001',
        userId: 'user-002',
        userName: 'Mike R.',
        rating: 4.5,
        comment: 'Great atmosphere and consistent quality. Highly recommend.',
        createdAt: DateTime(2026, 3, 10),
      ),
      ReviewModel(
        id: 'rev-003',
        salonId: 'salon-001',
        userId: 'user-003',
        userName: 'Tom S.',
        rating: 4.0,
        comment: 'Good haircut, but had to wait a bit. Book ahead!',
        createdAt: DateTime(2026, 2, 28),
      ),
    ],
    'salon-002': [
      ReviewModel(
        id: 'rev-004',
        salonId: 'salon-002',
        userId: 'user-004',
        userName: 'Alex K.',
        rating: 5.0,
        comment: 'The hot towel shave experience here is unmatched. '
            'Pure luxury at a reasonable price.',
        createdAt: DateTime(2026, 3, 20),
      ),
      ReviewModel(
        id: 'rev-005',
        salonId: 'salon-002',
        userId: 'user-005',
        userName: 'Ryan P.',
        rating: 5.0,
        comment: 'Alexander is the best barber I\'ve ever had. Period.',
        createdAt: DateTime(2026, 3, 18),
      ),
    ],
    'salon-003': [
      ReviewModel(
        id: 'rev-006',
        salonId: 'salon-003',
        userId: 'user-006',
        userName: 'Brandon L.',
        rating: 4.5,
        comment: 'DeShawn does amazing fades. Always leave looking fresh.',
        createdAt: DateTime(2026, 3, 12),
      ),
    ],
    'salon-004': [
      ReviewModel(
        id: 'rev-007',
        salonId: 'salon-004',
        userId: 'user-007',
        userName: 'Steve W.',
        rating: 4.0,
        comment: 'Solid barbershop with fair prices.',
        createdAt: DateTime(2026, 3, 5),
      ),
    ],
    'salon-005': [
      ReviewModel(
        id: 'rev-008',
        salonId: 'salon-005',
        userId: 'user-008',
        userName: 'Emily C.',
        rating: 5.0,
        comment:
            'Sophie is incredibly talented. The color treatment was perfect.',
        createdAt: DateTime(2026, 3, 22),
      ),
      ReviewModel(
        id: 'rev-009',
        salonId: 'salon-005',
        userId: 'user-009',
        userName: 'David H.',
        rating: 4.5,
        comment: 'Top-notch service and great products. Worth every penny.',
        createdAt: DateTime(2026, 3, 14),
      ),
    ],
    'salon-006': [
      ReviewModel(
        id: 'rev-010',
        salonId: 'salon-006',
        userId: 'user-010',
        userName: 'Carlos M.',
        rating: 4.0,
        comment: 'Affordable and friendly. Great neighborhood spot.',
        createdAt: DateTime(2026, 3, 8),
      ),
    ],
  };

  @override
  Future<List<SalonModel>> getNearbySalons({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    String? query,
    double? minRating,
    bool? isOpenNow,
  }) async {
    await Future<void>.delayed(_delay);

    var results = List<SalonModel>.from(_mockSalons);

    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      results = results
          .where(
            (s) =>
                s.name.toLowerCase().contains(q) ||
                s.description.toLowerCase().contains(q) ||
                s.address.toLowerCase().contains(q),
          )
          .toList();
    }

    if (minRating != null) {
      results = results.where((s) => s.rating >= minRating).toList();
    }

    if (isOpenNow == true) {
      results = results.where((s) => s.isOpen).toList();
    }

    return results;
  }

  @override
  Future<SalonModel> getSalonById(String id) async {
    await Future<void>.delayed(_delay);
    return _mockSalons.firstWhere(
      (s) => s.id == id,
      orElse: () => throw const ServerException(
        message: 'Salon not found',
        statusCode: 404,
      ),
    );
  }

  @override
  Future<List<SalonServiceModel>> getSalonServices(String salonId) async {
    await Future<void>.delayed(_delay);
    return _mockServices[salonId] ?? [];
  }

  @override
  Future<List<BarberModel>> getSalonBarbers(String salonId) async {
    await Future<void>.delayed(_delay);
    return _mockBarbers[salonId] ?? [];
  }

  @override
  Future<List<ReviewModel>> getSalonReviews(String salonId) async {
    await Future<void>.delayed(_delay);
    return _mockReviews[salonId] ?? [];
  }

  @override
  Future<void> addReview({
    required String salonId,
    required double rating,
    String? comment,
  }) async {
    await Future<void>.delayed(_delay);

    final reviews = _mockReviews.putIfAbsent(salonId, () => []);
    reviews.insert(
      0,
      ReviewModel(
        id: 'rev-${DateTime.now().millisecondsSinceEpoch}',
        salonId: salonId,
        userId: 'mock-user-001',
        userName: 'Test User',
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
      ),
    );
  }
}
