import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_typography.dart';

/// Composes [ThemeData] from design tokens for light and dark modes.
///
/// Implements the "Editorial Artisan" design system:
/// - No-Line rule: no visible borders on cards, chips, dividers
/// - Ghost borders: outline_variant at 15% opacity on inputs
/// - Tonal differentiation: surface layers define depth
class AppTheme {
  const AppTheme._();

  /// Light theme data.
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryLight,
          primaryContainer: AppColors.primaryContainerLight,
          secondary: AppColors.secondaryLight,
          secondaryContainer: AppColors.secondaryContainerLight,
          tertiary: AppColors.tertiaryLight,
          tertiaryContainer: AppColors.tertiaryContainerLight,
          error: AppColors.errorLight,
          errorContainer: AppColors.errorContainerLight,
          surface: AppColors.surfaceLight,
          surfaceContainerLowest: AppColors.surfaceContainerLowestLight,
          surfaceContainerLow: AppColors.surfaceContainerLowLight,
          surfaceContainer: AppColors.surfaceContainerMediumLight,
          surfaceContainerHigh: AppColors.surfaceContainerHighLight,
          surfaceContainerHighest: AppColors.surfaceContainerHighestLight,
          surfaceBright: AppColors.surfaceBrightLight,
          surfaceDim: AppColors.surfaceDimLight,
          onPrimary: AppColors.onPrimaryLight,
          onPrimaryContainer: AppColors.onPrimaryContainerLight,
          onSecondary: AppColors.onSecondaryLight,
          onSecondaryContainer: AppColors.onSecondaryContainerLight,
          onTertiary: AppColors.onTertiaryLight,
          onSurface: AppColors.onSurfaceLight,
          onSurfaceVariant: AppColors.onSurfaceVariantLight,
          outline: AppColors.outlineLight,
          outlineVariant: AppColors.outlineVariantLight,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: AppTypography.lightTextTheme,
        dividerColor: AppColors.dividerLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.textPrimaryLight,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.lightTextTheme.titleLarge,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceContainerLowLight,
          border: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide(
              color: AppColors.outlineVariantLight
                  .withValues(alpha: AppOpacity.ghostBorder),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide(
              color: AppColors.outlineVariantLight
                  .withValues(alpha: AppOpacity.ghostBorder),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(
              color: AppColors.primaryLight,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.errorLight),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: AppColors.onPrimaryLight,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            textStyle: AppTypography.lightTextTheme.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            backgroundColor: AppColors.surfaceContainerHighLight,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            side: BorderSide.none,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceContainerLowestLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusMd,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primaryLight,
          unselectedItemColor: AppColors.onSurfaceVariantLight,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceContainerHighLight,
          selectedColor: AppColors.primaryLight,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusFull,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.outlineVariantLight
              .withValues(alpha: AppOpacity.ghostBorder),
          thickness: 1,
        ),
      );

  /// Dark theme data.
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          primaryContainer: AppColors.primaryContainerDark,
          secondary: AppColors.secondaryDark,
          secondaryContainer: AppColors.secondaryContainerDark,
          tertiary: AppColors.tertiaryDark,
          tertiaryContainer: AppColors.tertiaryContainerDark,
          error: AppColors.errorDark,
          errorContainer: AppColors.errorContainerDark,
          surface: AppColors.surfaceDark,
          surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
          surfaceContainerLow: AppColors.surfaceContainerLowDark,
          surfaceContainer: AppColors.surfaceContainerMediumDark,
          surfaceContainerHigh: AppColors.surfaceContainerHighDark,
          surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
          surfaceBright: AppColors.surfaceBrightDark,
          surfaceDim: AppColors.surfaceDimDark,
          onPrimary: AppColors.onPrimaryDark,
          onPrimaryContainer: AppColors.onPrimaryContainerDark,
          onSecondary: AppColors.onSecondaryDark,
          onSecondaryContainer: AppColors.onSecondaryContainerDark,
          onTertiary: AppColors.onTertiaryDark,
          onSurface: AppColors.onSurfaceDark,
          onSurfaceVariant: AppColors.onSurfaceVariantDark,
          outline: AppColors.outlineDark,
          outlineVariant: AppColors.outlineVariantDark,
        ),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: AppTypography.darkTextTheme,
        dividerColor: AppColors.dividerDark,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: AppColors.textPrimaryDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.darkTextTheme.titleLarge,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceContainerLowDark,
          border: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide(
              color: AppColors.outlineVariantDark
                  .withValues(alpha: AppOpacity.ghostBorder),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide(
              color: AppColors.outlineVariantDark
                  .withValues(alpha: AppOpacity.ghostBorder),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(
              color: AppColors.primaryDark,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.errorDark),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: AppColors.onPrimaryDark,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            textStyle: AppTypography.darkTextTheme.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            backgroundColor: AppColors.surfaceContainerHighDark,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            side: BorderSide.none,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceContainerLowestDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusMd,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.onSurfaceVariantDark,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceContainerHighDark,
          selectedColor: AppColors.primaryDark,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusFull,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.outlineVariantDark
              .withValues(alpha: AppOpacity.ghostBorder),
          thickness: 1,
        ),
      );
}
