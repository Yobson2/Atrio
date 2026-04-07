import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/core/widgets/inputs/photo_upload_grid.dart';
import 'package:go_router/go_router.dart';

/// Page for writing a salon review with star rating, comment, and photos.
class WriteReviewPage extends ConsumerStatefulWidget {
  const WriteReviewPage({super.key});

  @override
  ConsumerState<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends ConsumerState<WriteReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  int _selectedRating = 0;
  final List<String> _photos = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedRating == 0) {
      context.showSnackBar(
        context.l10n.writeReviewRatingRequired,
        isError: true,
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate network request
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _isLoading = false);

    context
      ..showSnackBar(context.l10n.writeReviewSuccess)
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.writeReviewTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingXl,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Experience question
                Center(
                  child: Text(
                    context.l10n.writeReviewExperience,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppSpacing.verticalXl,

                // Star rating
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedRating = starIndex),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          child: Icon(
                            starIndex <= _selectedRating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 40,
                            color: starIndex <= _selectedRating
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                AppSpacing.verticalXxl,

                // Comment field
                AppTextField(
                  label: context.l10n.writeReviewCommentLabel,
                  hint: context.l10n.writeReviewCommentHint,
                  maxLines: 5,
                  controller: _commentController,
                ),
                AppSpacing.verticalXl,

                // Photos section
                SectionLabel(label: context.l10n.writeReviewPhotosLabel),
                AppSpacing.verticalMd,
                PhotoUploadGrid(
                  photos: _photos,
                  onAddPhoto: () {
                    // In a real app, this would open an image picker
                  },
                  onRemovePhoto: (index) {
                    setState(() => _photos.removeAt(index));
                  },
                ),
                AppSpacing.verticalXxl,

                // Submit button
                AppPrimaryButton(
                  text: context.l10n.writeReviewSubmit,
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
