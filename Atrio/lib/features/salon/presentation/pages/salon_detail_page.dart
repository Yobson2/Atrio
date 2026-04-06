import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_network_image.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_reviews_page.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/barber_card.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/review_card.dart';

/// Page displaying full salon details, services, barbers, and reviews.
class SalonDetailPage extends ConsumerStatefulWidget {
  /// Creates a [SalonDetailPage].
  const SalonDetailPage({
    required this.salonId,
    super.key,
  });

  /// The ID of the salon to display.
  final String salonId;

  @override
  ConsumerState<SalonDetailPage> createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends ConsumerState<SalonDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(salonDetailNotifierProvider.notifier)
        ..loadSalonDetail(widget.salonId)
        ..loadReviews(widget.salonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salonDetailNotifierProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: switch (state) {
        SalonDetailInitial() || SalonDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        SalonDetailLoaded(:final salon, :final services, :final barbers) =>
          _buildContent(context, salon, services, barbers),
        SalonDetailError(:final message) => SafeArea(
            child: Column(
              children: [
                AppBar(title: const Text('Salon Details')),
                Expanded(
                  child: AppErrorState(
                    message: message,
                    onRetry: () {
                      ref
                          .read(salonDetailNotifierProvider.notifier)
                          .loadSalonDetail(widget.salonId);
                    },
                  ),
                ),
              ],
            ),
          ),
      },
      // Gradient FAB for booking
      floatingActionButton: state is SalonDetailLoaded
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colorScheme.primary,
                    context.colorScheme.primaryContainer,
                  ],
                ),
                borderRadius: AppRadius.borderRadiusFull,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary.withValues(alpha: 0.15),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _navigateToBooking(context),
                  borderRadius: AppRadius.borderRadiusFull,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.lg,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.event_available,
                          color: context.colorScheme.onPrimary,
                        ),
                        AppSpacing.horizontalSm,
                        Text(
                          'BOOK NOW',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildContent(
    BuildContext context,
    Salon salon,
    List<SalonService> services,
    List<Barber> barbers,
  ) {
    final reviews = ref.read(salonDetailNotifierProvider.notifier).reviews;

    return CustomScrollView(
      slivers: [
        // Hero image with gradient overlay
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 320,
                width: double.infinity,
                child: salon.coverImageUrl != null
                    ? AppNetworkImage(
                        imageUrl: salon.coverImageUrl!,
                        height: 320,
                        width: double.infinity,
                        borderRadius: BorderRadius.zero,
                      )
                    : ColoredBox(
                        color: context.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.storefront,
                          size: 80,
                          color: context.colorScheme.onPrimaryContainer
                              .withValues(alpha: 0.3),
                        ),
                      ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.transparent,
                        context.colorScheme.surface,
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Back button
              Positioned(
                top: MediaQuery.of(context).padding.top + AppSpacing.sm,
                left: AppSpacing.lg,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: AppRadius.borderRadiusFull,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: AppRadius.borderRadiusFull,
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.sm),
                      child: Icon(Icons.arrow_back, size: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Salon info card (overlapping hero)
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -48),
            child: Padding(
              padding: AppSpacing.paddingHorizontalXl,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppRadius.xl)),
                  boxShadow: AppShadows.lgLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                salon.name,
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              AppSpacing.verticalXs,
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber.shade700,
                                  ),
                                  AppSpacing.horizontalXs,
                                  Text(
                                    '${salon.rating} (${salon.reviewCount} Reviews)',
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: salon.isOpen
                                ? context.colorScheme.secondaryContainer
                                : context.colorScheme.errorContainer,
                            borderRadius: AppRadius.borderRadiusFull,
                          ),
                          child: Text(
                            salon.isOpen ? 'OPEN NOW' : 'CLOSED',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: salon.isOpen
                                  ? context.colorScheme.onSecondaryContainer
                                  : context.colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w700,
                              fontSize: 9,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalLg,
                    // Divider using tonal shift
                    Divider(
                      color: context.colorScheme.surfaceContainerHigh
                          .withValues(alpha: 0.2),
                      height: 1,
                    ),
                    AppSpacing.verticalLg,
                    // Address
                    _InfoRow(
                      icon: Icons.location_on,
                      text: salon.address,
                      iconColor: context.colorScheme.primary,
                    ),
                    AppSpacing.verticalMd,
                    // Phone
                    _InfoRow(
                      icon: Icons.call,
                      text: salon.phone,
                      iconColor: context.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Opening hours section
        if (salon.openingHours.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Opening Hours',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  AppSpacing.verticalLg,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerLow,
                            borderRadius: AppRadius.borderRadiusLg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WEEKDAYS',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  fontSize: 10,
                                ),
                              ),
                              AppSpacing.verticalSm,
                              Text(
                                salon.openingHours.isNotEmpty
                                    ? salon.openingHours.first.isClosed
                                        ? 'Closed'
                                        : '${salon.openingHours.first.openTime} - ${salon.openingHours.first.closeTime}'
                                    : '--',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacing.horizontalLg,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerLow,
                            borderRadius: AppRadius.borderRadiusLg,
                            border: Border(
                              left: BorderSide(
                                color: context.colorScheme.secondary,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WEEKENDS',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  fontSize: 10,
                                ),
                              ),
                              AppSpacing.verticalSm,
                              Text(
                                salon.openingHours.length > 5
                                    ? (salon.openingHours[5].isClosed
                                        ? 'Closed'
                                        : '${salon.openingHours[5].openTime} - ${salon.openingHours[5].closeTime}')
                                    : '--',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalXxl,
                ],
              ),
            ),
          ),

        // Description
        if (salon.description.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salon.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                  AppSpacing.verticalXxl,
                ],
              ),
            ),
          ),

        // Services section - horizontal scroll cards
        if (services.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Signature Services',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'View Menu',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                itemCount: services.length,
                separatorBuilder: (_, __) => AppSpacing.horizontalLg,
                itemBuilder: (_, index) {
                  final service = services[index];
                  return Container(
                    width: 256,
                    padding: const EdgeInsets.all(AppSpacing.lgx),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLowest,
                      borderRadius: AppRadius.borderRadiusLg,
                      boxShadow: AppShadows.smLight,
                      border: Border.all(
                        color: context.colorScheme.outlineVariant
                            .withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: AppRadius.borderRadiusMd,
                          ),
                          child: Icon(
                            Icons.content_cut,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        AppSpacing.verticalMd,
                        Text(
                          service.name,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.verticalXs,
                        Expanded(
                          child: Text(
                            service.description ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 11,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${service.price.toStringAsFixed(2)}',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            Text(
                              '${service.durationMinutes} min',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],

        // Barbers section
        if (barbers.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.xl,
                right: AppSpacing.xl,
                top: AppSpacing.lg,
              ),
              child: Text(
                'Elite Barbers',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                itemCount: barbers.length,
                separatorBuilder: (_, __) => AppSpacing.horizontalXl,
                itemBuilder: (_, index) => BarberCard(barber: barbers[index]),
              ),
            ),
          ),
        ],

        // Reviews preview section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.xl,
            ),
            child: Text(
              'Latest Reviews',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
        if (reviews.isNotEmpty)
          SliverList.builder(
            itemCount: reviews.length > 3 ? 3 : reviews.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.sm,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lgx),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppRadius.xl)),
                ),
                child: ReviewCard(review: reviews[index]),
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingXl,
              child: Text(
                'No reviews yet. Be the first to review!',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),

        // See all reviews button
        if (reviews.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: TextButton(
                onPressed: () => _navigateToReviews(context, salon.id),
                child: Text(
                  'See all reviews',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),

        // Bottom padding for FAB clearance
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  void _navigateToBooking(BuildContext context) {
    // TODO: Navigate to booking flow via GoRouter once routes are wired.
    context.showSnackBar('Booking flow coming soon');
  }

  void _navigateToReviews(BuildContext context, String salonId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SalonReviewsPage(salonId: salonId),
      ),
    );
  }
}

/// Row displaying an icon and text, used for address and phone.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    this.iconColor,
  });
  final IconData icon;
  final String text;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color:
              iconColor ?? context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        AppSpacing.horizontalMd,
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
