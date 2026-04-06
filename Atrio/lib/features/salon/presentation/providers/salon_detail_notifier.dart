import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_detail_notifier.g.dart';

/// Manages the salon detail screen state.
@riverpod
class SalonDetailNotifier extends _$SalonDetailNotifier {
  List<Review> _reviews = [];

  @override
  SalonDetailState build() => const SalonDetailState.initial();

  /// Current reviews for the loaded salon.
  List<Review> get reviews => _reviews;

  /// Loads full salon detail including services and barbers.
  Future<void> loadSalonDetail(String salonId) async {
    state = const SalonDetailState.loading();
    try {
      final salonResult =
          await ref.read(getSalonDetailUseCaseProvider).call(salonId);

      await salonResult.fold(
        (failure) async {
          state = SalonDetailState.error(failure.message);
        },
        (salon) async {
          final servicesResult =
              await ref.read(getSalonServicesUseCaseProvider).call(salonId);
          final barbersResult =
              await ref.read(getSalonBarbersUseCaseProvider).call(salonId);

          final services = servicesResult.fold(
            (_) => <SalonService>[],
            (s) => s,
          );
          final barbers = barbersResult.fold(
            (_) => <Barber>[],
            (b) => b,
          );

          state = SalonDetailState.loaded(
            salon: salon,
            services: services,
            barbers: barbers,
          );
        },
      );
    } catch (e) {
      state = SalonDetailState.error(e.toString());
    }
  }

  /// Loads reviews for the current salon.
  Future<void> loadReviews(String salonId) async {
    try {
      final result =
          await ref.read(getSalonReviewsUseCaseProvider).call(salonId);
      result.fold(
        (_) {},
        (reviews) => _reviews = reviews,
      );
    } catch (_) {
      // Reviews are non-critical; silently fail.
    }
  }
}
