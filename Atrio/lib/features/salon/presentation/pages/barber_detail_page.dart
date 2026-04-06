import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/rating_stars.dart';
import 'package:go_router/go_router.dart';

/// Page showing detailed information about a single barber.
class BarberDetailPage extends StatelessWidget {
  /// Creates a [BarberDetailPage].
  const BarberDetailPage({
    required this.barber,
    super.key,
    this.services = const [],
  });

  /// The barber to display.
  final Barber barber;

  /// The salon services this barber can perform.
  final List<SalonService> services;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filter services to only those the barber performs.
    final barberServices = services
        .where((s) => barber.serviceIds.contains(s.id))
        .toList();

    return Scaffold(
      appBar: const AppAppBar(title: 'Barber Profile'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // Avatar hero
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                colorScheme.primary.withValues(alpha: 0.15),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: AppAvatar(
                        imageUrl: barber.avatarUrl,
                        name: barber.name,
                        radius: 56,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Name
                    Text(
                      barber.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Rating
                    RatingStars(rating: barber.rating, size: 18),
                    const SizedBox(height: AppSpacing.md),

                    // Availability badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.xs + 2,
                      ),
                      decoration: BoxDecoration(
                        color: barber.isAvailable
                            ? Colors.green.withValues(alpha: 0.12)
                            : colorScheme.error.withValues(alpha: 0.12),
                        borderRadius: AppRadius.borderRadiusFull,
                      ),
                      child: Text(
                        barber.isAvailable ? 'Available' : 'Unavailable',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: barber.isAvailable
                              ? Colors.green
                              : colorScheme.error,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Services section
                    if (barberServices.isNotEmpty) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: AppSpacing.xxs),
                          child: Text(
                            'SPECIALTIES',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLowest,
                          borderRadius: AppRadius.borderRadiusXl,
                          boxShadow: isDark
                              ? AppShadows.smDark
                              : AppShadows.smLight,
                        ),
                        child: Column(
                          children: barberServices
                              .map(
                                (service) => _ServiceRow(
                                  service: service,
                                  colorScheme: colorScheme,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),

            // Book CTA
            if (barber.isAvailable)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: AppPrimaryButton(
                  text: 'Book with ${barber.name}',
                  onPressed: () => context.push(
                    RouteNames.bookingFlow,
                    extra: <String, dynamic>{
                      'salonId': barber.salonId,
                      'salonName': '',
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.service,
    required this.colorScheme,
  });

  final SalonService service;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: AppRadius.borderRadiusMd,
            ),
            child: Icon(
              Icons.content_cut,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (service.durationMinutes > 0) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '${service.durationMinutes} min',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '\$${service.price.toStringAsFixed(0)}',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
