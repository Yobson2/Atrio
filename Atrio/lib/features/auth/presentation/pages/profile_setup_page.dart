import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/utils/validators.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/features/auth/domain/entities/user_role.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

/// Profile setup page shown after role selection.
///
/// Collects the user's profile photo, full name, and optional email.
/// This is step 1 of a 3-step setup flow.
class ProfileSetupPage extends ConsumerStatefulWidget {
  /// Creates a [ProfileSetupPage].
  const ProfileSetupPage({required this.role, super.key});

  /// The role selected on the previous screen.
  final UserRole role;

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _onNext() async {
    if (_formKey.currentState?.validate() ?? false) {
      context.unfocus();
      // Mark profile setup as complete before navigating.
      final localStorage = ref.read(localStorageProvider);
      await localStorage.setProfileSetupComplete();
      if (!mounted) return;
      // Navigate to home based on role (steps 2-3 are future work).
      if (widget.role == UserRole.owner) {
        context.go(RouteNames.ownerDashboard);
      } else {
        context.go(RouteNames.discover);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            // Glassmorphic top bar
            SafeArea(
              bottom: false,
              child: AuthTopBar(
                showBackButton: true,
                onBack: () => Navigator.of(context).maybePop(),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingHorizontalXl,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xl),

                      // Editorial header
                      Text(
                        context.l10n.profileSetupTitle,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.verticalSm,
                      Text(
                        context.l10n.profileSetupSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.xxxl),

                      // Profile photo upload
                      GestureDetector(
                        onTap: _pickImage,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 128,
                                  height: 128,
                                  decoration: BoxDecoration(
                                    color:
                                        theme.colorScheme.surfaceContainerLow,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.outlineVariant
                                          .withValues(
                                        alpha: AppOpacity.ghostBorder,
                                      ),
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: _selectedImage != null
                                        ? Image.asset(
                                            _selectedImage!.path,
                                            fit: BoxFit.cover,
                                            width: 128,
                                            height: 128,
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 48,
                                            color: theme
                                                .colorScheme.outlineVariant,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: theme.colorScheme.primary
                                              .withValues(alpha: 0.2),
                                          blurRadius: 32,
                                          offset: const Offset(0, 12),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.upload_rounded,
                                      size: 20,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.verticalMd,
                            Text(
                              context.l10n.profileSetupUploadPhoto,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxxl),

                      // Full Name field
                      AppTextField(
                        controller: _nameController,
                        label: context.l10n.profileSetupFullName,
                        hint: context.l10n.profileSetupFullNameHint,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        validator: (v) => Validators.required(
                          v,
                          fieldName: 'Full Name',
                        ),
                      ),
                      AppSpacing.verticalLg,

                      // Email field (optional)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  context.l10n.profileSetupEmail,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Text(
                                context.l10n.profileSetupEmailOptional,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outlineVariant,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalSm,
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.email],
                            onFieldSubmitted: (_) => _onNext(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return null;
                              }
                              return Validators.email(value);
                            },
                            decoration: InputDecoration(
                              hintText: context.l10n.profileSetupEmailHint,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // Privacy info card
                      Container(
                        padding: AppSpacing.paddingLg,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLowest,
                          borderRadius: AppRadius.borderRadiusXl,
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant.withValues(
                              alpha: AppOpacity.ghostBorder,
                            ),
                          ),
                          boxShadow:
                              isDark ? AppShadows.smDark : AppShadows.smLight,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: AppSpacing.paddingSm,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: AppRadius.borderRadiusSm,
                              ),
                              child: Icon(
                                Icons.verified_user,
                                color: theme.colorScheme.onSecondaryContainer,
                                size: 24,
                              ),
                            ),
                            AppSpacing.horizontalMd,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.l10n.profileSetupPrivacyTitle,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  AppSpacing.verticalXs,
                                  Text(
                                    context.l10n.profileSetupPrivacyDescription,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxxl),

                      // Next button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.primaryContainer,
                              ],
                            ),
                            borderRadius: AppRadius.borderRadiusMd,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.15),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _onNext,
                              borderRadius: AppRadius.borderRadiusMd,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context.l10n.profileSetupNext,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  AppSpacing.horizontalSm,
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      AppSpacing.verticalLg,

                      // Step indicator
                      Text(
                        context.l10n.profileSetupStep(1, 3),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),

                      AppSpacing.verticalXl,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
