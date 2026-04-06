import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/sync/sync_providers.dart';
import 'package:flutter_templates/core/theme/app_gradients.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/feedback/sync_status_banner.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/notes/domain/entities/note.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_notifier.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_providers.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_state.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the list of notes with sync status.
/// Editorial Artisan style with tonal cards and sync badges.
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
        title: 'Notes',
        showBackButton: false,
        actions: [
          // Pending sync count badge.
          _SyncBadge(),
        ],
      ),
      body: Column(
        children: [
          const SyncStatusBanner(),
          // Page header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Client Notes',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Organize formulas, preferences, and history.',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: notesAsync.when(
              data: (notes) =>
                  notes.isEmpty ? _EmptyState() : _NotesList(notes: notes),
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
      floatingActionButton: _GradientFab(
        onPressed: () => _openNoteDetail(context),
      ),
    );
  }

  void _openNoteDetail(BuildContext context) {
    context.goNamed(RouteNames.noteDetailName);
  }
}

class _GradientFab extends StatelessWidget {
  const _GradientFab({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? AppGradients.primaryButtonDark
        : AppGradients.primaryButtonLight;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: AppRadius.borderRadiusLg,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
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
            backgroundColor: context.colorScheme.tertiary,
            textColor: Colors.white,
            label: Text(
              '$count',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
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
    final colorScheme = context.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.note_add_outlined,
              size: 32,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No notes yet',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Tap + to create your first note',
            style: context.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesList extends StatelessWidget {
  const _NotesList({required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Pull-to-refresh triggers server sync via the page's ProviderScope.
      },
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.jumbo + AppSpacing.xxl,
        ),
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final note = notes[index];
          return _NoteCard(note: note);
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
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () {
        context.goNamed(
          RouteNames.noteDetailName,
          extra: note.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lgx),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.borderRadiusLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Sync status icon
                Icon(
                  note.isSynced
                      ? Icons.cloud_done_outlined
                      : Icons.sync_problem,
                  size: 18,
                  color: note.isSynced
                      ? colorScheme.primary.withValues(alpha: 0.4)
                      : colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
