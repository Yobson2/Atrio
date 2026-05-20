import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';

/// Chronological points history with filter chips.
class PointsHistoryPage extends StatefulWidget {
  /// Creates a [PointsHistoryPage].
  const PointsHistoryPage({super.key});

  @override
  State<PointsHistoryPage> createState() => _PointsHistoryPageState();
}

class _PointsHistoryPageState extends State<PointsHistoryPage> {
  String _selectedFilter = 'All';

  List<_MockHistoryItem> get _filteredItems {
    if (_selectedFilter == 'Earned') {
      return _mockHistory.where((i) => i.isEarned).toList();
    }
    if (_selectedFilter == 'Redeemed') {
      return _mockHistory.where((i) => !i.isEarned).toList();
    }
    return _mockHistory;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    // Group items by section.
    final grouped = <String, List<_MockHistoryItem>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.section, () => []).add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.pointsHistoryTitle),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          // ── Filter Chips ──
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Row(
              children: [
                for (final filter in const ['All', 'Earned', 'Redeemed']) ...[
                  PillChip(
                    label: filter,
                    isSelected: _selectedFilter == filter,
                    onTap: () => setState(() => _selectedFilter = filter),
                  ),
                  AppSpacing.horizontalSm,
                ],
              ],
            ),
          ),

          // ── List ──
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              itemCount: grouped.length,
              itemBuilder: (context, sectionIndex) {
                final section = grouped.keys.elementAt(sectionIndex);
                final sectionItems = grouped[section]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sectionIndex > 0) AppSpacing.verticalLg,
                    SectionLabel(label: section),
                    AppSpacing.verticalSm,
                    ...sectionItems.map(
                      (item) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _HistoryListItem(item: item),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private Widgets ─────────────────────────────────────────────────────────

class _HistoryListItem extends StatelessWidget {
  const _HistoryListItem({required this.item});

  final _MockHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pointsColor = item.isEarned
        ? theme.colorScheme.secondary
        : theme.colorScheme.tertiary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: pointsColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isEarned
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 18,
              color: pointsColor,
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  item.date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.isEarned ? "+" : "-"}${item.points} pts',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: pointsColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mock Data ───────────────────────────────────────────────────────────────

class _MockHistoryItem {
  const _MockHistoryItem({
    required this.description,
    required this.date,
    required this.points,
    required this.isEarned,
    required this.section,
  });

  final String description;
  final String date;
  final int points;
  final bool isEarned;
  final String section;
}

const _mockHistory = [
  _MockHistoryItem(
    description: 'Haircut at Prestige Barbers',
    date: 'Today, 2:30 PM',
    points: 50,
    isEarned: true,
    section: 'TODAY',
  ),
  _MockHistoryItem(
    description: 'Beard Grooming',
    date: 'Today, 10:00 AM',
    points: 30,
    isEarned: true,
    section: 'TODAY',
  ),
  _MockHistoryItem(
    description: 'Redeemed: Free Beard Trim',
    date: 'Yesterday, 11:00 AM',
    points: 200,
    isEarned: false,
    section: 'YESTERDAY',
  ),
  _MockHistoryItem(
    description: 'Hot Towel Shave',
    date: 'Yesterday, 3:15 PM',
    points: 75,
    isEarned: true,
    section: 'YESTERDAY',
  ),
  _MockHistoryItem(
    description: 'Referral bonus - John D.',
    date: 'Apr 5, 9:15 AM',
    points: 200,
    isEarned: true,
    section: 'THIS WEEK',
  ),
  _MockHistoryItem(
    description: 'Redeemed: 20% Off Service',
    date: 'Apr 4, 10:30 AM',
    points: 300,
    isEarned: false,
    section: 'THIS WEEK',
  ),
  _MockHistoryItem(
    description: 'Premium Haircut',
    date: 'Apr 3, 4:00 PM',
    points: 60,
    isEarned: true,
    section: 'THIS WEEK',
  ),
  _MockHistoryItem(
    description: 'Scalp Treatment',
    date: 'Apr 2, 1:45 PM',
    points: 40,
    isEarned: true,
    section: 'THIS WEEK',
  ),
  _MockHistoryItem(
    description: 'Redeemed: Premium Product',
    date: 'Apr 1, 11:00 AM',
    points: 500,
    isEarned: false,
    section: 'THIS WEEK',
  ),
  _MockHistoryItem(
    description: 'Classic Fade',
    date: 'Mar 30, 2:00 PM',
    points: 50,
    isEarned: true,
    section: 'THIS WEEK',
  ),
];
