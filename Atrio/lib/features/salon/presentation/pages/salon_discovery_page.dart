import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_detail_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_map_page.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_list_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_list_state.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/salon_card.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/salon_filter_sheet.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/salon_search_bar.dart';

/// Main salon discovery page with search, filters, and list/map toggle.
class SalonDiscoveryPage extends ConsumerStatefulWidget {
  /// Creates a [SalonDiscoveryPage].
  const SalonDiscoveryPage({super.key});

  @override
  ConsumerState<SalonDiscoveryPage> createState() => _SalonDiscoveryPageState();
}

class _SalonDiscoveryPageState extends ConsumerState<SalonDiscoveryPage> {
  bool _isMapView = false;

  @override
  void initState() {
    super.initState();
    // Load salons with default location on initial build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(salonListNotifierProvider.notifier).loadNearbySalons(
            latitude: 48.8566,
            longitude: 2.3522,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salonListNotifierProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Search & filter bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Row(
                children: [
                  // Search field
                  Expanded(
                    child: SalonSearchBar(
                      onChanged: (query) {
                        ref
                            .read(salonListNotifierProvider.notifier)
                            .search(query);
                      },
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  // Filter button
                  Material(
                    color: context.colorScheme.primary,
                    borderRadius: AppRadius.borderRadiusMd,
                    elevation: 4,
                    shadowColor:
                        context.colorScheme.primary.withValues(alpha: 0.2),
                    child: InkWell(
                      onTap: () => _showFilters(context),
                      borderRadius: AppRadius.borderRadiusMd,
                      child: Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.tune,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List/Map toggle row
            if (!_isMapView)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  bottom: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isMapView ? Icons.list : Icons.map_outlined,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => setState(() => _isMapView = !_isMapView),
                      tooltip: _isMapView ? 'List view' : 'Map view',
                    ),
                  ],
                ),
              ),
            // Content
            Expanded(
              child:
                  _isMapView ? const SalonMapPage() : _buildListContent(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListContent(SalonListState state) {
    return switch (state) {
      SalonListInitial() || SalonListLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      SalonListLoaded(:final salons) => salons.isEmpty
          ? const AppEmptyState(
              icon: Icons.storefront_outlined,
              title: 'No salons found',
              subtitle: 'Try adjusting your search or filters',
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(salonListNotifierProvider.notifier)
                    .loadNearbySalons(
                      latitude: 48.8566,
                      longitude: 2.3522,
                    );
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.sm,
                ),
                itemCount: salons.length,
                separatorBuilder: (_, __) => AppSpacing.verticalXl,
                itemBuilder: (context, index) {
                  final salon = salons[index];
                  return SalonCard(
                    salon: salon,
                    onTap: () => _navigateToDetail(salon.id),
                  );
                },
              ),
            ),
      SalonListError(:final message) => AppErrorState(
          message: message,
          onRetry: () {
            ref.read(salonListNotifierProvider.notifier).loadNearbySalons(
                  latitude: 48.8566,
                  longitude: 2.3522,
                );
          },
        ),
    };
  }

  Future<void> _showFilters(BuildContext context) async {
    final filter = await showSalonFilterSheet(context);
    if (filter != null && mounted) {
      ref.read(salonListNotifierProvider.notifier).applyFilter(filter);
    }
  }

  void _navigateToDetail(String salonId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SalonDetailPage(salonId: salonId),
      ),
    );
  }
}
