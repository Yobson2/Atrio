import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_typography.dart';

/// Composes [ThemeData] from design tokens for light and dark modes.
///
/// Implements the "Editorial Artisan" design spec:
/// - No-Line Rule: no 1px borders, boundaries via tonal shifts + spacing
/// - Ghost Borders: outline_variant at 15% opacity for inputs on focus
/// - Pill chips with full radius
/// - Ambient shadows instead of borders for cards
class AppTheme {
  const AppTheme._();

  /// Light theme data.
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryLight,
          primaryContainer: AppColors.primaryContainerLight,
          onPrimary: AppColors.onPrimaryLight,
          onPrimaryContainer: AppColors.onPrimaryContainerLight,
          secondary: AppColors.secondaryLight,
          secondaryContainer: AppColors.secondaryContainerLight,
          onSecondary: AppColors.onSecondaryLight,
          onSecondaryContainer: AppColors.onSecondaryContainerLight,
          tertiary: AppColors.tertiaryLight,
          tertiaryContainer: AppColors.tertiaryContainerLight,
          onTertiary: AppColors.onTertiaryLight,
          onTertiaryContainer: AppColors.onTertiaryContainerLight,
          error: AppColors.errorLight,
          errorContainer: AppColors.errorContainerLight,
          onError: AppColors.onErrorLight,
          onErrorContainer: AppColors.onErrorContainerLight,
          surface: AppColors.surfaceLight,
          onSurface: AppColors.onSurfaceLight,
          onSurfaceVariant: AppColors.onSurfaceVariantLight,
          outline: AppColors.outlineLight,
          outlineVariant: AppColors.outlineVariantLight,
          inverseSurface: AppColors.inverseSurfaceLight,
          onInverseSurface: AppColors.inverseOnSurfaceLight,
          inversePrimary: AppColors.inversePrimaryLight,
          surfaceTint: AppColors.surfaceTintLight,
          surfaceContainerLowest: AppColors.surfaceContainerLowestLight,
          surfaceContainerLow: AppColors.surfaceContainerLowLight,
          surfaceContainer: AppColors.surfaceContainerLight,
          surfaceContainerHigh: AppColors.surfaceContainerHighLight,
          surfaceContainerHighest: AppColors.surfaceContainerHighestLight,
          surfaceBright: AppColors.surfaceBrightLight,
          surfaceDim: AppColors.surfaceDimLight,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: AppTypography.lightTextTheme,
        dividerColor: AppColors.dividerLight,

        // AppBar: clean, no elevation
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.textPrimaryLight,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.lightTextTheme.titleLarge,
        ),

        // Inputs: ghost borders per design spec
        // Fill with surfaceContainerLow, no border by default,
        // on focus: 1px primary ghost border
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceContainerLowLight,
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
              color: AppColors.primaryLight,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.errorLight),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(
              color: AppColors.errorLight,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: AppTypography.lightTextTheme.bodyMedium?.copyWith(
            color: AppColors.textDisabledLight,
          ),
        ),

        // Elevated button: primary teal, 12px radius
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: AppColors.onPrimaryLight,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            elevation: 0,
            textStyle: AppTypography.lightTextTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Outlined button: no border by default (no-line rule), primary text
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            side: BorderSide(
              color: AppColors.outlineVariantLight.withValues(alpha: 0.4),
            ),
          ),
        ),

        // Text button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
          ),
        ),

        // Cards: NO border (no-line rule), use tonal shift for depth
        // Cards should be surfaceContainerLowest on surface background
        cardTheme: CardThemeData(
          color: AppColors.surfaceContainerLowestLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusMd,
          ),
          margin: EdgeInsets.zero,
        ),

        // Bottom nav: teal palette
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceContainerLowestLight,
          selectedItemColor: AppColors.primaryLight,
          unselectedItemColor: AppColors.onSurfaceVariantLight,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),

        // Chips: pill shape (full radius), active = primary, inactive = surfaceContainerHigh
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceContainerHighLight,
          selectedColor: AppColors.primaryLight,
          labelStyle: AppTypography.lightTextTheme.labelMedium,
          secondaryLabelStyle: AppTypography.lightTextTheme.labelMedium?.copyWith(
            color: AppColors.onPrimaryLight,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusFull,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        // Dividers: subtle, using surfaceContainerLow
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerLight,
          thickness: 1,
          space: 1,
        ),

        // Bottom sheet
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surfaceContainerLowestLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xl),
            ),
          ),
        ),

        // Dialog
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surfaceContainerLowestLight,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusXl,
          ),
        ),

        // Floating action button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.onPrimaryLight,
          elevation: 0,
        ),
      );

  /// Dark theme data.
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          primaryContainer: AppColors.primaryContainerDark,
          onPrimary: AppColors.onPrimaryDark,
          onPrimaryContainer: AppColors.onPrimaryContainerDark,
          secondary: AppColors.secondaryDark,
          secondaryContainer: AppColors.secondaryContainerDark,
          onSecondary: AppColors.onSecondaryDark,
          onSecondaryContainer: AppColors.onSecondaryContainerDark,
          tertiary: AppColors.tertiaryDark,
          tertiaryContainer: AppColors.tertiaryContainerDark,
          onTertiary: AppColors.onTertiaryDark,
          onTertiaryContainer: AppColors.onTertiaryContainerDark,
          error: AppColors.errorDark,
          errorContainer: AppColors.errorContainerDark,
          onError: AppColors.onErrorDark,
          onErrorContainer: AppColors.onErrorContainerDark,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.onSurfaceDark,
          onSurfaceVariant: AppColors.onSurfaceVariantDark,
          outline: AppColors.outlineDark,
          outlineVariant: AppColors.outlineVariantDark,
          inverseSurface: AppColors.inverseSurfaceDark,
          onInverseSurface: AppColors.inverseOnSurfaceDark,
          inversePrimary: AppColors.inversePrimaryDark,
          surfaceTint: AppColors.primaryDark,
          surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
          surfaceContainerLow: AppColors.surfaceContainerLowDark,
          surfaceContainer: AppColors.surfaceContainerDark,
          surfaceContainerHigh: AppColors.surfaceContainerHighDark,
          surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
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
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: BorderSide(
              color: AppColors.primaryDark,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.errorDark),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderRadiusMd,
            borderSide: const BorderSide(
              color: AppColors.errorDark,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: AppTypography.darkTextTheme.bodyMedium?.copyWith(
            color: AppColors.textDisabledDark,
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
            elevation: 0,
            textStyle: AppTypography.darkTextTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
            ),
            side: BorderSide(
              color: AppColors.outlineVariantDark.withValues(alpha: 0.4),
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
          ),
        ),

        cardTheme: CardThemeData(
          color: AppColors.surfaceContainerLowDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusMd,
          ),
          margin: EdgeInsets.zero,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceDark,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.onSurfaceVariantDark,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),

        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceContainerHighDark,
          selectedColor: AppColors.primaryDark,
          labelStyle: AppTypography.darkTextTheme.labelMedium,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusFull,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        dividerTheme: const DividerThemeData(
          color: AppColors.dividerDark,
          thickness: 1,
          space: 1,
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surfaceContainerLowDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xl),
            ),
          ),
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surfaceContainerLowDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusXl,
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.onPrimaryDark,
          elevation: 0,
        ),
      );
}
