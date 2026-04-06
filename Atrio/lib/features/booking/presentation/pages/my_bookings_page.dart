import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_notifier.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_state.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/booking_card.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the user's bookings with upcoming/past tabs.
class MyBookingsPage extends ConsumerStatefulWidget {
  /// Creates a [MyBookingsPage].
  const MyBookingsPage({super.key});

  @override
  ConsumerState<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends ConsumerState<MyBookingsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() => _selectedTab = _tabController.index);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myBookingsNotifierProvider.notifier).loadBookings();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Upcoming bookings are those that are pending, confirmed, or in progress.
  static const _upcomingStatuses = {
    BookingStatus.pending,
    BookingStatus.confirmed,
    BookingStatus.inProgress,
  };

  List<Booking> _upcomingBookings(List<Booking> bookings) {
    return bookings.where((b) => _upcomingStatuses.contains(b.status)).toList();
  }

  List<Booking> _pastBookings(List<Booking> bookings) {
    return bookings
        .where((b) => !_upcomingStatuses.contains(b.status))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBookingsNotifierProvider);

    ref.listen<MyBookingsState>(myBookingsNotifierProvider, (_, current) {
      if (current is MyBookingsError) {
        context.showSnackBar(current.message, isError: true);
      }
    });

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bookings',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    'Manage your signature grooming sessions.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Segmented tab bar
            Padding(
              padding: AppSpacing.paddingHorizontalXl,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: AppRadius.borderRadiusLg,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TabButton(
                        label: 'Upcoming',
                        isActive: _selectedTab == 0,
                        onTap: () => _tabController.animateTo(0),
                      ),
                    ),
                    Expanded(
                      child: _TabButton(
                        label: 'Past',
                        isActive: _selectedTab == 1,
                        onTap: () => _tabController.animateTo(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.verticalXl,

            // Content
            Expanded(
              child: switch (state) {
                MyBookingsInitial() ||
                MyBookingsLoading() =>
                  const Center(child: CircularProgressIndicator()),
                MyBookingsLoaded(:final bookings) => TabBarView(
                    controller: _tabController,
                    children: [
                      _BookingsList(
                        bookings: _upcomingBookings(bookings),
                        emptyMessage: 'No Upcoming Sessions',
                        emptySubMessage: "It's time to sharpen your look. "
                            'Book a session with our master artisans.',
                        emptyIcon: Icons.event_busy_outlined,
                        onRefresh: () async {
                          await ref
                              .read(myBookingsNotifierProvider.notifier)
                              .loadBookings();
                        },
                      ),
                      _BookingsList(
                        bookings: _pastBookings(bookings),
                        emptyMessage: 'No Past Sessions',
                        emptySubMessage:
                            'Your completed bookings will appear here.',
                        emptyIcon: Icons.history_outlined,
                        onRefresh: () async {
                          await ref
                              .read(myBookingsNotifierProvider.notifier)
                              .loadBookings();
                        },
                      ),
                    ],
                  ),
                MyBookingsError() => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: context.colorScheme.error,
                        ),
                        AppSpacing.verticalMd,
                        Text(
                          'Failed to load bookings',
                          style: context.textTheme.titleMedium,
                        ),
                        AppSpacing.verticalMd,
                        FilledButton(
                          onPressed: () => ref
                              .read(myBookingsNotifierProvider.notifier)
                              .loadBookings(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? context.colorScheme.primary : Colors.transparent,
      borderRadius: AppRadius.borderRadiusMd,
      elevation: isActive ? 4 : 0,
      shadowColor: isActive
          ? context.colorScheme.primary.withValues(alpha: 0.3)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderRadiusMd,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Center(
            child: Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isActive
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  const _BookingsList({
    required this.bookings,
    required this.emptyMessage,
    required this.emptySubMessage,
    required this.emptyIcon,
    required this.onRefresh,
  });

  final List<Booking> bookings;
  final String emptyMessage;
  final String emptySubMessage;
  final IconData emptyIcon;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: AppSpacing.paddingXl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  emptyIcon,
                  size: 40,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
              AppSpacing.verticalXl,
              Text(
                emptyMessage,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                emptySubMessage,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
        itemCount: bookings.length,
        separatorBuilder: (_, __) => AppSpacing.verticalXl,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookingCard(
            booking: booking,
            onTap: () => context.push(
              '/bookings/detail',
              extra: booking.id,
            ),
          );
        },
      ),
    );
  }
}
