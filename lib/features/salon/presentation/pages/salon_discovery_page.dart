import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/salon_card.dart';
import 'package:flutter_templates/core/widgets/inputs/app_search_field.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_discovery_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_discovery_state.dart';
import 'package:go_router/go_router.dart';

/// Salon discovery page -- the main screen for clients.
///
/// Shows a search bar and a list of salon cards.
class SalonDiscoveryPage extends ConsumerStatefulWidget {
  const SalonDiscoveryPage({super.key});

  @override
  ConsumerState<SalonDiscoveryPage> createState() =>
      _SalonDiscoveryPageState();
}

class _SalonDiscoveryPageState extends ConsumerState<SalonDiscoveryPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salonDiscoveryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BarberBook',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceContainerHighLight,
              child: Icon(
                Icons.person_rounded,
                size: 18,
                color: AppColors.onSurfaceVariantLight,
              ),
            ),
            onPressed: () => context.go('/client-settings'),
          ),
          AppSpacing.horizontalSm,
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: AppSearchField(
              controller: _searchController,
              hint: context.l10n.discoverSearchHint,
              onChanged: (query) {
                ref
                    .read(salonDiscoveryNotifierProvider.notifier)
                    .search(query);
              },
            ),
          ),

          // Salon list
          Expanded(
            child: switch (state) {
              SalonDiscoveryLoading() => const AppShimmerList(),
              SalonDiscoveryError(:final message) => AppErrorState(
                  message: message,
                  onRetry: () => ref
                      .read(salonDiscoveryNotifierProvider.notifier)
                      .loadSalons(),
                ),
              SalonDiscoveryLoaded(:final salons) => salons.isEmpty
                  ? Center(
                      child: Text(
                        context.l10n.commonNoResults,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariantLight,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      itemCount: salons.length,
                      separatorBuilder: (_, __) => AppSpacing.verticalLg,
                      itemBuilder: (context, index) {
                        final salon = salons[index];
                        return SalonCard(
                          name: salon.name,
                          rating: salon.rating,
                          reviewCount: salon.reviewCount,
                          address: salon.address,
                          imageUrl: salon.imageUrl,
                          tags: salon.tags,
                          onTap: () =>
                              context.go('/discover/salon/${salon.id}'),
                        );
                      },
                    ),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }
}
