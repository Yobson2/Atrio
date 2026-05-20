import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/sync/sync_providers.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/gradient_fab.dart';
import 'package:flutter_templates/core/widgets/feedback/sync_status_banner.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/notes/domain/entities/note.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_notifier.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_providers.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_state.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the list of notes in a bento-style grid with sync status.
class NotesPage extends ConsumerWidget {
  /// Creates a [NotesPage].
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesStreamProvider);

    // Listen for mutation results (create/update/delete).
    ref.listen<NotesState>(notesNotifierProvider, (_, state) {
      switch (state) {
        case NotesSuccess(:final message):
          if (message != null) {
            context.showSnackBar(message);
          }
        case NotesError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    return Scaffold(
      appBar: AppAppBar(
        title: context.l10n.notesTitle,
        showBackButton: false,
        actions: [
          _SyncBadge(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.notesSubtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                AppSpacing.verticalSm,
              ],
            ),
          ),
          const SyncStatusBanner(),
          Expanded(
            child: notesAsync.when(
              data: (notes) =>
                  notes.isEmpty ? _EmptyState() : _NotesGrid(notes: notes),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GradientFab(
        onPressed: () => _openNoteDetail(context),
      ),
    );
  }

  void _openNoteDetail(BuildContext context) {
    context.goNamed(RouteNames.noteDetailName);
  }
}

class _SyncBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(pendingSyncCountProvider);
    return countAsync.when(
      data: (count) {
        if (count == 0) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: Badge(
            label: Text('$count'),
            child: IconButton(
              icon: const Icon(Icons.cloud_upload_outlined),
              onPressed: () => ref.read(syncEngineProvider).processQueue(),
              tooltip: '$count pending sync',
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_rounded,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          AppSpacing.verticalLg,
          Text(
            'No client notes yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Tap + to add formulas, preferences, or history',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesGrid extends StatelessWidget {
  const _NotesGrid({required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Pull-to-refresh triggers server sync.
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return _NoteCard(note: notes[index]);
        },
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        context.goNamed(
          RouteNames.noteDetailName,
          extra: note.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.smLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + sync icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  note.isSynced
                      ? Icons.cloud_done_outlined
                      : Icons.sync_problem_rounded,
                  size: 16,
                  color: note.isSynced
                      ? theme.colorScheme.primary.withValues(alpha: 0.4)
                      : theme.colorScheme.tertiary,
                ),
              ],
            ),
            AppSpacing.verticalSm,

            // Content preview
            Expanded(
              child: Text(
                note.content,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AppSpacing.verticalSm,

            // Timestamp
            Text(
              _formatTimeAgo(note.updatedAt),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }
}
