import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/inputs/app_phone_field.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/core/widgets/templates/form_page_template.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/home/presentation/providers/edit_profile_notifier.dart';
import 'package:flutter_templates/features/home/presentation/providers/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

/// Page for editing the current user's profile.
class EditProfilePage extends ConsumerStatefulWidget {
  /// Creates an [EditProfilePage].
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authNotifierProvider);
    if (authState is AuthAuthenticated) {
      _nameController.text = authState.user.name;
      _emailController.text = authState.user.email;
      _phoneController.text = authState.user.phone ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() => _selectedImagePath = image.path);
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ref.read(editProfileNotifierProvider.notifier).updateProfile(
          name: _nameController.text.trim(),
          email: _emailController.text.trim().isNotEmpty
              ? _emailController.text.trim()
              : null,
          phone: _phoneController.text.trim().isNotEmpty
              ? _phoneController.text.trim()
              : null,
          avatarImagePath: _selectedImagePath,
        );
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editProfileNotifierProvider);
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    final authState = ref.watch(authNotifierProvider);
    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };

    ref.listen(editProfileNotifierProvider, (_, next) {
      if (next is EditProfileSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileEditProfile)),
        );
        Navigator.of(context).pop();
      } else if (next is EditProfileError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final isLoading = editState is EditProfileLoading;

    return FormPageTemplate(
      appBar: AppAppBar(title: l10n.profileEditProfile),
      formKey: _formKey,
      submitText: l10n.commonSave,
      isSubmitting: isLoading,
      onSubmit: isLoading ? null : _submit,
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.lg),
          // Avatar
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                if (_selectedImagePath != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(_selectedImagePath!)),
                  )
                else
                  AppAvatar(
                    imageUrl: user?.avatarUrl,
                    name: user?.name ?? '',
                    radius: 50,
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Name field
          AppTextField(
            controller: _nameController,
            label: l10n.authName,
            hint: l10n.profileSetupFullNameHint,
            prefixIcon: const Icon(Icons.person_outline),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // Email field
          AppTextField(
            controller: _emailController,
            label: l10n.authEmail,
            hint: l10n.profileSetupEmailHint,
            prefixIcon: const Icon(Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value != null && value.isNotEmpty && !value.contains('@')) {
                return l10n.validationEmail;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // Phone field
          AppPhoneField(
            controller: _phoneController,
            label: l10n.profileSetupEmail,
            hint: l10n.commonSearch,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
