import 'package:fleetfill/core/theme/design_tokens.dart';
import 'package:fleetfill/core/utils/app_accessibility.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    const seed = Color(0xFF0B6E69);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      surface: const Color(0xFFF7F7F2),
    );

    return _buildTheme(
      colorScheme: colorScheme,
      statusPalette: const AppStatusPalette(
        info: Color(0xFF1D4ED8),
        success: Color(0xFF0F766E),
        warning: Color(0xFFB45309),
        danger: Color(0xFFB42318),
        neutral: Color(0xFF475467),
      ),
    );
  }

  static ThemeData dark() {
    const seed = Color(0xFF5FD3CB);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
      surface: const Color(0xFF0E1719),
    );

    return _buildTheme(
      colorScheme: colorScheme,
      statusPalette: const AppStatusPalette(
        info: Color(0xFF7CB5FF),
        success: Color(0xFF68D8CC),
        warning: Color(0xFFF2B34F),
        danger: Color(0xFFFF8A80),
        neutral: Color(0xFFD0D5DD),
      ),
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required AppStatusPalette statusPalette,
  }) {
    final baseTextTheme = ThemeData(
      brightness: colorScheme.brightness,
    ).textTheme;
    final textTheme = baseTextTheme.copyWith(
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.display,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontFamily: AppTypography.fontFamily,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.title,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.body,
      ),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.label,
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      extensions: <ThemeExtension<dynamic>>[statusPalette],
      cardTheme: CardThemeData(
        elevation: AppElevation.low,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, AppAccessibility.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppAccessibility.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: AppBorders.regular,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        showDragHandle: true,
      ),
    );
  }
}
