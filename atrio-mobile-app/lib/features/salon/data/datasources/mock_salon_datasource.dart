// coverage:ignore-file

import 'package:flutter_templates/features/salon/data/models/barber_model.dart';
import 'package:flutter_templates/features/salon/data/models/review_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_service_model.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/business_hours.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';

/// Mock implementation of [SalonRepository] with realistic sample data.
class MockSalonRepository implements SalonRepository {
  static const _delay = Duration(milliseconds: 600);

  static final _salons = [
    const SalonModel(
      id: 'salon-001',
      name: 'Precision Grooming Co.',
      address: '242 Artisan Way, Arts District',
      rating: 4.8,
      reviewCount: 156,
      description:
          'A premium grooming studio offering signature cuts and hot towel shaves in a refined atmosphere.',
      phone: '+1 (555) 500-0988',
      email: 'hello@precisiongrooming.co',
      isActive: true,
      tags: ['INDIE MASTER', 'HOT TOWEL'],
      tier: 'Premium Tier',
    ),
    const SalonModel(
      id: 'salon-002',
      name: 'The Heritage Barbers',
      address: '88 Vintage Blvd, Midtown',
      rating: 4.7,
      reviewCount: 203,
      description:
          'Classic barbershop experience with modern techniques. Specializing in fades, beard sculpting, and traditional grooming.',
      phone: '+1 (555) 234-8901',
      isActive: true,
      tags: ['CLASSIC CUT', 'BEARD GROOMING'],
    ),
    const SalonModel(
      id: 'salon-003',
      name: 'Urban Blade Studio',
      address: '15 Main Plaza, Downtown',
      rating: 4.5,
      reviewCount: 89,
      description:
          'Contemporary urban grooming with creative styling and precision fades.',
      isActive: true,
      tags: ['MODERN', 'CREATIVE'],
    ),
    const SalonModel(
      id: 'salon-004',
      name: 'The Iron & Oak Studio',
      address: '67 Ashford Way, West Chelsea, NY',
      rating: 4.9,
      reviewCount: 312,
      description:
          'Artisan grooming in a warm, oak-paneled setting. Known for signature scissor cuts and premium beard treatments.',
      phone: '+1 (555) 678-4321',
      isActive: true,
      tags: ['SIGNATURE', 'PREMIUM'],
      tier: 'Premium Tier',
    ),
  ];

  static final _services = {
    'salon-001': [
      const SalonServiceModel(
        id: 'svc-001',
        salonId: 'salon-001',
        name: 'The Signature Sculpt',
        price: 45.00,
        durationMinutes: 45,
        description:
            'Our signature service. High-precision clipper work with a meticulous scissor finish.',
        category: 'Haircut',
        isPopular: true,
        tier: 'Signature',
      ),
      const SalonServiceModel(
        id: 'svc-002',
        salonId: 'salon-001',
        name: 'Beard Sculpting & Steam',
        price: 35.00,
        durationMinutes: 30,
        description:
            'Full beard shaping followed by a revitalizing hot towel steam treatment.',
        category: 'Beard',
      ),
      const SalonServiceModel(
        id: 'svc-003',
        salonId: 'salon-001',
        name: 'Executive Grooming Pack',
        price: 85.00,
        durationMinutes: 75,
        description:
            'The ultimate package. Haircut, Beard Trim, Face Mask and Scalp Massage.',
        category: 'Haircut',
        tier: 'Premium',
      ),
      const SalonServiceModel(
        id: 'svc-004',
        salonId: 'salon-001',
        name: 'Classic Hot Towel Shave',
        price: 30.00,
        durationMinutes: 25,
        description:
            'Traditional straight razor shave with premium oils and cold stone finish.',
        category: 'Beard',
      ),
    ],
    'salon-002': [
      const SalonServiceModel(
        id: 'svc-005',
        salonId: 'salon-002',
        name: 'Heritage Fade',
        price: 40.00,
        durationMinutes: 40,
        category: 'Haircut',
        isPopular: true,
      ),
      const SalonServiceModel(
        id: 'svc-006',
        salonId: 'salon-002',
        name: 'Classic Beard Trim',
        price: 25.00,
        durationMinutes: 20,
        category: 'Beard',
      ),
    ],
  };

  static final _barbers = {
    'salon-001': [
      const BarberModel(
        id: 'barber-001',
        salonId: 'salon-001',
        name: 'Marcus Precision',
        rating: 4.9,
        reviewCount: 130,
        specialties: ['Signature Sculpt', 'Fades'],
        tier: 'Master Artisan',
      ),
      const BarberModel(
        id: 'barber-002',
        salonId: 'salon-001',
        name: 'Julian Sharp',
        rating: 4.8,
        reviewCount: 98,
        specialties: ['Beard Sculpting', 'Hot Towel'],
        tier: 'Senior Stylist',
      ),
      const BarberModel(
        id: 'barber-003',
        salonId: 'salon-001',
        name: 'Elias Master',
        rating: 5.0,
        reviewCount: 75,
        specialties: ['Classic Cuts', 'Razor Work'],
        tier: 'Master Artisan',
      ),
      const BarberModel(
        id: 'barber-004',
        salonId: 'salon-001',
        name: 'Sasha Fade',
        rating: 4.7,
        reviewCount: 62,
        specialties: ['Modern Fades', 'Designs'],
      ),
    ],
    'salon-002': [
      const BarberModel(
        id: 'barber-005',
        salonId: 'salon-002',
        name: 'Marco "The Blade" Rossi',
        rating: 4.8,
        reviewCount: 110,
        specialties: ['Heritage Fade', 'Straight Razor'],
      ),
    ],
  };

  static final _reviews = {
    'salon-001': [
      ReviewModel(
        id: 'rev-001',
        salonId: 'salon-001',
        clientName: 'Marcus Sterling',
        rating: 5.0,
        comment:
            'The attention to detail is unmatched. They truly take the time to understand your style. The atmosphere is spoken of in editorial terms.',
        createdAt: DateTime(2024, 10, 15),
      ),
      ReviewModel(
        id: 'rev-002',
        salonId: 'salon-001',
        clientName: 'Julian Voss',
        rating: 4.5,
        comment:
            'Best barrel shave in the city. The products they use are smooth. Only giving 4 stars because the wait was a bit longer than expected, but the result was worth it.',
        createdAt: DateTime(2024, 10, 10),
      ),
      ReviewModel(
        id: 'rev-003',
        salonId: 'salon-001',
        clientName: 'David Chen',
        rating: 5.0,
        comment:
            'Consistently excellent. Satisfaction has never been an issue. Their service has kept me happy and the result was exceptional.',
        createdAt: DateTime(2024, 10, 5),
      ),
      ReviewModel(
        id: 'rev-004',
        salonId: 'salon-001',
        clientName: 'Ryan Price',
        rating: 4.0,
        comment:
            'The precision is just unmatched. Used 22mm at roots for 45 mins. Results with 10V and 10P were impressive.',
        createdAt: DateTime(2024, 9, 28),
      ),
    ],
  };

  static const _hours = {
    'salon-001': [
      BusinessHours(dayOfWeek: 1, openTime: '09:00', closeTime: '21:00'),
      BusinessHours(dayOfWeek: 2, openTime: '09:00', closeTime: '21:00'),
      BusinessHours(dayOfWeek: 3, openTime: '09:00', closeTime: '21:00'),
      BusinessHours(dayOfWeek: 4, openTime: '09:00', closeTime: '21:00'),
      BusinessHours(dayOfWeek: 5, openTime: '09:00', closeTime: '21:00'),
      BusinessHours(dayOfWeek: 6, openTime: '10:00', closeTime: '18:00'),
      BusinessHours(dayOfWeek: 7, openTime: '10:00', closeTime: '18:00'),
    ],
  };

  @override
  Future<Either<Failure, List<Salon>>> getSalons({String? query}) async {
    await Future<void>.delayed(_delay);
    var salons = _salons.map((m) => m.toEntity()).toList();
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      salons = salons
          .where(
            (s) =>
                s.name.toLowerCase().contains(q) ||
                s.address.toLowerCase().contains(q),
          )
          .toList();
    }
    return Right(salons);
  }

  @override
  Future<Either<Failure, Salon>> getSalonById(String id) async {
    await Future<void>.delayed(_delay);
    final salon = _salons.where((s) => s.id == id).firstOrNull;
    if (salon == null) {
      return const Left(ServerFailure(message: 'Salon not found'));
    }
    return Right(salon.toEntity());
  }

  @override
  Future<Either<Failure, List<SalonService>>> getSalonServices(
    String salonId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final services = (_services[salonId] ?? [])
        .map((m) => m.toEntity())
        .toList();
    return Right(services);
  }

  @override
  Future<Either<Failure, List<Barber>>> getSalonBarbers(
    String salonId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final barbers = (_barbers[salonId] ?? [])
        .map((m) => m.toEntity())
        .toList();
    return Right(barbers);
  }

  @override
  Future<Either<Failure, List<BusinessHours>>> getSalonHours(
    String salonId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return Right(_hours[salonId] ?? []);
  }

  @override
  Future<Either<Failure, List<Review>>> getSalonReviews(
    String salonId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final reviews = (_reviews[salonId] ?? [])
        .map((m) => m.toEntity())
        .toList();
    return Right(reviews);
  }
}
