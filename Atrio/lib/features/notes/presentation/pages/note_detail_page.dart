import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_notifier.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_providers.dart';
import 'package:flutter_templates/features/notes/presentation/providers/notes_state.dart';
import 'package:go_router/go_router.dart';

/// Page for creating or editing a note.
/// Editorial Artisan style with tonal input fields and gradient save button.
class NoteDetailPage extends ConsumerStatefulWidget {
  /// Creates a [NoteDetailPage].
  ///
  /// Pass [noteId] to edit an existing note, or leave null to create new.
  const NoteDetailPage({super.key, this.noteId});

  /// ID of the note to edit. Null for creating a new note.
  final String? noteId;

  @override
  ConsumerState<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = true;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _isEditing = true;
      _loadNote();
    } else {
      _isLoading = false;
    }
  }

  Future<void> _loadNote() async {
    final repository = ref.read(notesRepositoryProvider);
    final result = await repository.getNoteById(widget.noteId!);
    result.fold(
      (failure) {
        if (mounted) {
          context.showSnackBar(failure.message, isError: true);
          context.pop();
        }
      },
      (note) {
        if (mounted) {
          _titleController.text = note.title;
          _contentController.text = note.content;
          setState(() => _isLoading = false);
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<NotesState>(notesNotifierProvider, (_, state) {
      switch (state) {
        case NotesSuccess():
          context.pop();
        case NotesError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    final notesState = ref.watch(notesNotifierProvider);
    final isSaving = notesState is NotesLoading;
    final colorScheme = context.colorScheme;

    return Scaffold(
      appBar: AppAppBar(
        title: _isEditing ? 'Edit Note' : 'New Note',
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: colorScheme.error,
              ),
              onPressed: isSaving ? null : _deleteNote,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                children: [
                  // Title field
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter note title',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.error,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.error,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(AppSpacing.lg),
                    ),
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Content field
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      hintText: 'Write your note...',
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.error,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                        borderSide: BorderSide(
                          color: colorScheme.error,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(AppSpacing.lg),
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                    maxLines: 12,
                    minLines: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Content is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Save button
                  AppPrimaryButton(
                    text: _isEditing ? 'Update' : 'Create',
                    onPressed: isSaving ? null : _saveNote,
                    isLoading: isSaving,
                  ),
                ],
              ),
            ),
    );
  }

  void _saveNote() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (_isEditing) {
      ref.read(notesNotifierProvider.notifier).updateNote(
            id: widget.noteId!,
            title: title,
            content: content,
          );
    } else {
      ref.read(notesNotifierProvider.notifier).createNote(
            title: title,
            content: content,
          );
    }
  }

  void _deleteNote() {
    final colorScheme = context.colorScheme;

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusXl,
        ),
        title: const Text(
          'Delete Note',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to delete this note?',
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderRadiusMd,
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        ref.read(notesNotifierProvider.notifier).deleteNote(widget.noteId!);
      }
    });
  }
}
